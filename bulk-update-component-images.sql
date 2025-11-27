-- Bulk Update Component Images
-- Replace YOUR-PROJECT-ID with your actual Supabase project ID
-- Replace the base URL with your actual image storage URL

-- Option 1: Using Supabase Storage
-- First, upload images to Supabase Storage bucket 'component-images'
-- Then run these queries:

-- Update CPU images
UPDATE components 
SET component_image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/cpu/' || 
                     LOWER(REPLACE(REPLACE(REPLACE(component_name, ' ', '-'), '/', '-'), ' - ', '-')) || '.jpg'
WHERE category_id = 1  -- CPU
AND component_image IS NULL;

-- Update Motherboard images
UPDATE components 
SET component_image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/motherboard/' || 
                     LOWER(REPLACE(REPLACE(REPLACE(component_name, ' ', '-'), '/', '-'), ' - ', '-')) || '.jpg'
WHERE category_id = 2  -- Motherboard
AND component_image IS NULL;

-- Update RAM/Memory images
UPDATE components 
SET component_image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/ram/' || 
                     LOWER(REPLACE(REPLACE(REPLACE(component_name, ' ', '-'), '/', '-'), ' - ', '-')) || '.jpg'
WHERE category_id = 3  -- RAM
AND component_image IS NULL;

-- Update Storage images
UPDATE components 
SET component_image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/storage/' || 
                     LOWER(REPLACE(REPLACE(REPLACE(component_name, ' ', '-'), '/', '-'), ' - ', '-')) || '.jpg'
WHERE category_id = 4  -- Storage
AND component_image IS NULL;

-- Update GPU/Video Card images
UPDATE components 
SET component_image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/gpu/' || 
                     LOWER(REPLACE(REPLACE(REPLACE(component_name, ' ', '-'), '/', '-'), ' - ', '-')) || '.jpg'
WHERE category_id = 5  -- GPU
AND component_image IS NULL;

-- Update PSU images
UPDATE components 
SET component_image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/psu/' || 
                     LOWER(REPLACE(REPLACE(REPLACE(component_name, ' ', '-'), '/', '-'), ' - ', '-')) || '.jpg'
WHERE category_id = 6  -- PSU
AND component_image IS NULL;

-- Update Case images
UPDATE components 
SET component_image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/case/' || 
                     LOWER(REPLACE(REPLACE(REPLACE(component_name, ' ', '-'), '/', '-'), ' - ', '-')) || '.jpg'
WHERE category_id = 7  -- Case
AND component_image IS NULL;

-- Update Cooling images
UPDATE components 
SET component_image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/cooling/' || 
                     LOWER(REPLACE(REPLACE(REPLACE(component_name, ' ', '-'), '/', '-'), ' - ', '-')) || '.jpg'
WHERE category_id = 8  -- Cooling
AND component_image IS NULL;

-- Option 2: Using Component ID for unique naming
-- This uses component_id for unique image names
UPDATE components 
SET component_image = CASE category_id
  WHEN 1 THEN 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/cpu/component-' || component_id || '.jpg'
  WHEN 2 THEN 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/motherboard/component-' || component_id || '.jpg'
  WHEN 3 THEN 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/ram/component-' || component_id || '.jpg'
  WHEN 4 THEN 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/storage/component-' || component_id || '.jpg'
  WHEN 5 THEN 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/gpu/component-' || component_id || '.jpg'
  WHEN 6 THEN 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/psu/component-' || component_id || '.jpg'
  WHEN 7 THEN 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/case/component-' || component_id || '.jpg'
  WHEN 8 THEN 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/cooling/component-' || component_id || '.jpg'
END
WHERE component_image IS NULL;

-- Option 3: Update specific components by name pattern
-- Example: Update all Intel CPUs
UPDATE components 
SET component_image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/cpu/' || 
                     LOWER(REPLACE(REPLACE(component_name, ' ', '-'), 'INTEL', 'intel')) || '.jpg'
WHERE component_name ILIKE '%INTEL%'
AND category_id = 1
AND component_image IS NULL;

-- Example: Update all AMD CPUs
UPDATE components 
SET component_image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/cpu/' || 
                     LOWER(REPLACE(REPLACE(component_name, ' ', '-'), 'AMD', 'amd')) || '.jpg'
WHERE component_name ILIKE '%AMD%'
AND category_id = 1
AND component_image IS NULL;

-- Verification queries:
-- Check how many components have images
SELECT 
  category_id,
  COUNT(*) as total,
  COUNT(component_image) as with_images,
  COUNT(*) - COUNT(component_image) as without_images
FROM components
GROUP BY category_id
ORDER BY category_id;

-- List components without images
SELECT component_id, component_name, category_id
FROM components
WHERE component_image IS NULL
ORDER BY category_id, component_name;

-- List components with images
SELECT component_id, component_name, component_image
FROM components
WHERE component_image IS NOT NULL
ORDER BY category_id, component_name;

