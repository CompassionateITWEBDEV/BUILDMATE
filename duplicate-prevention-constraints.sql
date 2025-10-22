-- Additional database constraints to prevent duplicate builds
-- Run this after the main migration script

-- Add unique constraint on build name per user to prevent exact name duplicates
ALTER TABLE public.builds 
ADD CONSTRAINT unique_build_name_per_user 
UNIQUE (user_id, LOWER(build_name));

-- Create an index for faster duplicate checking
CREATE INDEX IF NOT EXISTS idx_builds_user_name 
ON public.builds (user_id, LOWER(build_name));

-- Create a function to check for similar builds based on components
CREATE OR REPLACE FUNCTION check_similar_builds(
  p_user_id integer,
  p_build_name text,
  p_component_ids integer[]
) RETURNS TABLE(
  build_id integer,
  build_name text,
  similarity_score numeric,
  is_duplicate boolean
) AS $$
DECLARE
  existing_build RECORD;
  component_overlap integer;
  total_components integer;
  similarity numeric;
BEGIN
  -- Get all builds for the user
  FOR existing_build IN
    SELECT b.build_id, b.build_name, 
           array_agg(bc.component_id ORDER BY bc.component_id) as components
    FROM builds b
    LEFT JOIN build_components bc ON b.build_id = bc.build_id
    WHERE b.user_id = p_user_id
    GROUP BY b.build_id, b.build_name
  LOOP
    -- Skip if it's the same build name (exact duplicate)
    IF LOWER(existing_build.build_name) = LOWER(p_build_name) THEN
      RETURN QUERY SELECT existing_build.build_id, existing_build.build_name, 1.0::numeric, true;
      CONTINUE;
    END IF;
    
    -- Calculate component overlap
    SELECT COUNT(*) INTO component_overlap
    FROM unnest(p_component_ids) AS new_comp(id)
    WHERE new_comp.id = ANY(existing_build.components);
    
    -- Calculate total unique components
    SELECT COUNT(DISTINCT id) INTO total_components
    FROM (
      SELECT unnest(p_component_ids) AS id
      UNION
      SELECT unnest(existing_build.components) AS id
    ) AS all_components;
    
    -- Calculate similarity score
    IF total_components > 0 THEN
      similarity := component_overlap::numeric / total_components::numeric;
    ELSE
      similarity := 0;
    END IF;
    
    -- Return builds with similarity >= 0.8 (80% similar)
    IF similarity >= 0.8 THEN
      RETURN QUERY SELECT 
        existing_build.build_id, 
        existing_build.build_name, 
        similarity, 
        (similarity >= 0.95); -- Consider 95%+ as duplicate
    END IF;
  END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger function to prevent duplicate builds
CREATE OR REPLACE FUNCTION prevent_duplicate_builds()
RETURNS TRIGGER AS $$
DECLARE
  similar_builds RECORD;
  component_ids integer[];
BEGIN
  -- Get component IDs for the new build
  -- Note: This would need to be called after build_components are inserted
  -- For now, we'll just check name duplicates
  
  -- Check for exact name duplicates
  IF EXISTS (
    SELECT 1 FROM builds 
    WHERE user_id = NEW.user_id 
    AND LOWER(build_name) = LOWER(NEW.build_name)
    AND build_id != COALESCE(NEW.build_id, 0)
  ) THEN
    RAISE EXCEPTION 'Build name "%" already exists for this user', NEW.build_name;
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to prevent duplicate builds
DROP TRIGGER IF EXISTS prevent_duplicate_builds_trigger ON builds;
CREATE TRIGGER prevent_duplicate_builds_trigger
  BEFORE INSERT OR UPDATE ON builds
  FOR EACH ROW
  EXECUTE FUNCTION prevent_duplicate_builds();

-- Create a view for build statistics to help identify potential duplicates
CREATE OR REPLACE VIEW build_similarity_stats AS
SELECT 
  b1.build_id as build_1_id,
  b1.build_name as build_1_name,
  b2.build_id as build_2_id,
  b2.build_name as build_2_name,
  b1.user_id,
  -- Calculate component overlap
  (
    SELECT COUNT(*)
    FROM build_components bc1
    JOIN build_components bc2 ON bc1.component_id = bc2.component_id
    WHERE bc1.build_id = b1.build_id 
    AND bc2.build_id = b2.build_id
  ) as shared_components,
  -- Calculate total unique components
  (
    SELECT COUNT(DISTINCT component_id)
    FROM build_components
    WHERE build_id IN (b1.build_id, b2.build_id)
  ) as total_components,
  -- Calculate similarity score
  CASE 
    WHEN (
      SELECT COUNT(DISTINCT component_id)
      FROM build_components
      WHERE build_id IN (b1.build_id, b2.build_id)
    ) > 0 THEN
      (
        SELECT COUNT(*)
        FROM build_components bc1
        JOIN build_components bc2 ON bc1.component_id = bc2.component_id
        WHERE bc1.build_id = b1.build_id 
        AND bc2.build_id = b2.build_id
      )::numeric / (
        SELECT COUNT(DISTINCT component_id)
        FROM build_components
        WHERE build_id IN (b1.build_id, b2.build_id)
      )::numeric
    ELSE 0
  END as similarity_score
FROM builds b1
JOIN builds b2 ON b1.user_id = b2.user_id AND b1.build_id < b2.build_id
WHERE b1.user_id = b2.user_id;

-- Create an index for faster similarity calculations
CREATE INDEX IF NOT EXISTS idx_build_components_build_component 
ON build_components (build_id, component_id);

-- Add a comment explaining the duplicate prevention system
COMMENT ON CONSTRAINT unique_build_name_per_user ON builds IS 
'Prevents users from creating builds with identical names (case-insensitive)';

COMMENT ON FUNCTION check_similar_builds IS 
'Function to identify similar builds based on component overlap. Returns builds with 80%+ similarity.';

COMMENT ON VIEW build_similarity_stats IS 
'View showing similarity scores between builds from the same user based on shared components.';
