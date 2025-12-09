-- Enable Row Level Security (RLS) policies for BuildMate

-- IMPORTANT: Run these queries in your Supabase SQL Editor

-- ============================================
-- 1. Enable RLS on tables
-- ============================================

-- Components table (needs public read access)
ALTER TABLE components ENABLE ROW LEVEL SECURITY;

-- Component categories (needs public read access)
ALTER TABLE component_categories ENABLE ROW LEVEL SECURITY;

-- Retailers (needs public read access)
ALTER TABLE retailers ENABLE ROW LEVEL SECURITY;

-- Builds (needs authenticated access)
ALTER TABLE builds ENABLE ROW LEVEL SECURITY;

-- Build components (needs authenticated access)
ALTER TABLE build_components ENABLE ROW LEVEL SECURITY;

-- ============================================
-- 2. Create public read policies for components
-- ============================================

-- Allow public read access to components
CREATE POLICY "Allow public read access to components"
ON components
FOR SELECT
TO public
USING (true);

-- Allow public read access to component_categories
CREATE POLICY "Allow public read access to component_categories"
ON component_categories
FOR SELECT
TO public
USING (true);

-- Allow public read access to retailers
CREATE POLICY "Allow public read access to retailers"
ON retailers
FOR SELECT
TO public
USING (true);

-- ============================================
-- 3. Create authenticated user policies for builds
-- ============================================

-- Allow users to read all builds (public builds feed)
CREATE POLICY "Allow public read access to builds"
ON builds
FOR SELECT
TO public
USING (true);

-- Allow authenticated users to create builds
CREATE POLICY "Allow authenticated users to create builds"
ON builds
FOR INSERT
TO authenticated
WITH CHECK (auth.uid()::text = (SELECT supabase_id::text FROM users WHERE user_id = builds.user_id));

-- Allow users to update their own builds
CREATE POLICY "Allow users to update their own builds"
ON builds
FOR UPDATE
TO authenticated
USING (auth.uid()::text = (SELECT supabase_id::text FROM users WHERE user_id = builds.user_id))
WITH CHECK (auth.uid()::text = (SELECT supabase_id::text FROM users WHERE user_id = builds.user_id));

-- Allow users to delete their own builds
CREATE POLICY "Allow users to delete their own builds"
ON builds
FOR DELETE
TO authenticated
USING (auth.uid()::text = (SELECT supabase_id::text FROM users WHERE user_id = builds.user_id));

-- ============================================
-- 4. Create policies for build_components
-- ============================================

-- Allow public read access to build_components
CREATE POLICY "Allow public read access to build_components"
ON build_components
FOR SELECT
TO public
USING (true);

-- Allow authenticated users to insert build_components
CREATE POLICY "Allow authenticated users to insert build_components"
ON build_components
FOR INSERT
TO authenticated
WITH CHECK (
  auth.uid()::text = (
    SELECT supabase_id::text 
    FROM users 
    WHERE user_id = (
      SELECT user_id 
      FROM builds 
      WHERE build_id = build_components.build_id
    )
  )
);

-- Allow users to delete their build_components
CREATE POLICY "Allow users to delete their build_components"
ON build_components
FOR DELETE
TO authenticated
USING (
  auth.uid()::text = (
    SELECT supabase_id::text 
    FROM users 
    WHERE user_id = (
      SELECT user_id 
      FROM builds 
      WHERE build_id = build_components.build_id
    )
  )
);

-- ============================================
-- 5. Verify policies
-- ============================================

-- Check all policies
SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual 
FROM pg_policies 
WHERE schemaname = 'public'
ORDER BY tablename, policyname;

-- ============================================
-- TROUBLESHOOTING
-- ============================================

-- If you still have issues, try disabling RLS temporarily:
-- ALTER TABLE components DISABLE ROW LEVEL SECURITY;
-- ALTER TABLE component_categories DISABLE ROW LEVEL SECURITY;
-- ALTER TABLE retailers DISABLE ROW LEVEL SECURITY;

-- Re-enable after testing:
-- ALTER TABLE components ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE component_categories ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE retailers ENABLE ROW LEVEL SECURITY;

-- ============================================
-- NOTES
-- ============================================
-- 1. These policies allow public read access to components, categories, and retailers
-- 2. Only authenticated users can create/update/delete builds
-- 3. Users can only modify their own builds
-- 4. All policies are created with proper security checks





