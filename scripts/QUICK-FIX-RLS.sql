-- QUICK FIX: Enable Public Read Access for Components
-- Run this in Supabase SQL Editor

-- Allow everyone to read components (no login required)
ALTER TABLE components DISABLE ROW LEVEL SECURITY;
ALTER TABLE component_categories DISABLE ROW LEVEL SECURITY;
ALTER TABLE retailers DISABLE ROW LEVEL SECURITY;

-- OR if you want to keep RLS enabled, use policies instead:
/*
CREATE POLICY "Public can read components"
ON components
FOR SELECT
TO public
USING (true);

CREATE POLICY "Public can read categories"
ON component_categories
FOR SELECT
TO public
USING (true);

CREATE POLICY "Public can read retailers"
ON retailers
FOR SELECT
TO public
USING (true);
*/

-- Verify it works:
SELECT component_name, component_price, component_image
FROM components
LIMIT 5;




