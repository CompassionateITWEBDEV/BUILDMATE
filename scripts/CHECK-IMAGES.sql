-- CHECK IF IMAGES EXIST IN DATABASE
-- Run this in Supabase SQL Editor to verify

-- 1. Check if component_image column exists
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'components' 
AND column_name LIKE '%image%';

-- 2. Count how many components have images
SELECT 
  COUNT(*) as total_components,
  COUNT(component_image) as components_with_images,
  COUNT(*) - COUNT(component_image) as components_without_images
FROM components;

-- 3. Show sample components with images
SELECT 
  component_id,
  component_name,
  component_image,
  LENGTH(component_image) as image_url_length
FROM components
WHERE component_image IS NOT NULL
LIMIT 10;

-- 4. Show components that should have images (based on our SQL script)
SELECT 
  component_id,
  component_name,
  component_image
FROM components
WHERE 
  component_name LIKE '%i9-13900K%' 
  OR component_name LIKE '%Ryzen 9 7950X%'
  OR component_name LIKE '%Aerocool CS%'
ORDER BY component_name;

-- 5. Check RLS policies on components table
SELECT 
  schemaname,
  tablename,
  policyname,
  permissive,
  roles,
  cmd,
  qual,
  with_check
FROM pg_policies
WHERE tablename = 'components';








