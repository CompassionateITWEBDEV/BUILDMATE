-- Remove excess CPU components, keeping only 400
-- This will remove at least 300 CPU components (from 728 to 400)
-- Run this in Supabase SQL Editor

-- Step 1: Check current count
SELECT 
  COUNT(*) as current_cpu_count
FROM components 
WHERE category_id = 1;

-- Step 2: Delete excess CPU components
-- This keeps the first 400 components (lowest component_id) and deletes the rest
DELETE FROM components
WHERE category_id = 1
AND component_id IN (
  SELECT component_id 
  FROM (
    SELECT component_id,
           ROW_NUMBER() OVER (ORDER BY component_id) as rn
    FROM components
    WHERE category_id = 1
  ) ranked
  WHERE rn > 400
);

-- Step 3: Verify the new count
SELECT 
  COUNT(*) as remaining_cpu_count
FROM components 
WHERE category_id = 1;

-- Expected result: Should show 400 components remaining
-- This removes at least 328 components (728 - 400 = 328)

