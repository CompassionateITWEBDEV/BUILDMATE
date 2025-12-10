-- ============================================================
-- ADD IMAGES TO ALL EXISTING COMPONENTS
-- ============================================================
-- This will add placeholder images to components that don't have images yet

-- Add component_image column if it doesn't exist
ALTER TABLE components 
ADD COLUMN IF NOT EXISTS component_image TEXT;

-- ============================================================
-- UPDATE CPU IMAGES (Category ID: 1)
-- ============================================================
UPDATE components 
SET component_image = 'https://via.placeholder.com/400x400/0066cc/ffffff?text=' || 
                     REPLACE(REPLACE(REPLACE(SUBSTRING(component_name, 1, 30), ' ', '+'), '/', '-'), '&', 'and')
WHERE category_id = 1
AND (component_image IS NULL OR component_image = '');

-- ============================================================
-- UPDATE MOTHERBOARD IMAGES (Category ID: 2)
-- ============================================================
UPDATE components 
SET component_image = 'https://via.placeholder.com/400x400/00aa44/ffffff?text=' || 
                     REPLACE(REPLACE(REPLACE(SUBSTRING(component_name, 1, 30), ' ', '+'), '/', '-'), '&', 'and')
WHERE category_id = 2
AND (component_image IS NULL OR component_image = '');

-- ============================================================
-- UPDATE RAM/MEMORY IMAGES (Category ID: 3)
-- ============================================================
UPDATE components 
SET component_image = 'https://via.placeholder.com/400x400/9933cc/ffffff?text=' || 
                     REPLACE(REPLACE(REPLACE(SUBSTRING(component_name, 1, 30), ' ', '+'), '/', '-'), '&', 'and')
WHERE category_id = 3
AND (component_image IS NULL OR component_image = '');

-- ============================================================
-- UPDATE STORAGE IMAGES (Category ID: 4)
-- ============================================================
UPDATE components 
SET component_image = 'https://via.placeholder.com/400x400/ff8800/ffffff?text=' || 
                     REPLACE(REPLACE(REPLACE(SUBSTRING(component_name, 1, 30), ' ', '+'), '/', '-'), '&', 'and')
WHERE category_id = 4
AND (component_image IS NULL OR component_image = '');

-- ============================================================
-- UPDATE GPU/VIDEO CARD IMAGES (Category ID: 5)
-- ============================================================
UPDATE components 
SET component_image = 'https://via.placeholder.com/400x400/cc0000/ffffff?text=' || 
                     REPLACE(REPLACE(REPLACE(SUBSTRING(component_name, 1, 30), ' ', '+'), '/', '-'), '&', 'and')
WHERE category_id = 5
AND (component_image IS NULL OR component_image = '');

-- ============================================================
-- UPDATE PSU/POWER SUPPLY IMAGES (Category ID: 6)
-- ============================================================
UPDATE components 
SET component_image = 'https://via.placeholder.com/400x400/ffaa00/ffffff?text=' || 
                     REPLACE(REPLACE(REPLACE(SUBSTRING(component_name, 1, 30), ' ', '+'), '/', '-'), '&', 'and')
WHERE category_id = 6
AND (component_image IS NULL OR component_image = '');

-- ============================================================
-- UPDATE CASE IMAGES (Category ID: 7)
-- ============================================================
UPDATE components 
SET component_image = 'https://via.placeholder.com/400x400/666666/ffffff?text=' || 
                     REPLACE(REPLACE(REPLACE(SUBSTRING(component_name, 1, 30), ' ', '+'), '/', '-'), '&', 'and')
WHERE category_id = 7
AND (component_image IS NULL OR component_image = '');

-- ============================================================
-- UPDATE COOLING IMAGES (Category ID: 8)
-- ============================================================
UPDATE components 
SET component_image = 'https://via.placeholder.com/400x400/00ccff/ffffff?text=' || 
                     REPLACE(REPLACE(REPLACE(SUBSTRING(component_name, 1, 30), ' ', '+'), '/', '-'), '&', 'and')
WHERE category_id = 8
AND (component_image IS NULL OR component_image = '');

-- ============================================================
-- VERIFY UPDATED IMAGES
-- ============================================================
SELECT 
    cc.category_name,
    COUNT(*) as total_components,
    COUNT(c.component_image) as components_with_images,
    COUNT(*) - COUNT(c.component_image) as components_without_images
FROM components c
JOIN component_categories cc ON c.category_id = cc.category_id
GROUP BY cc.category_name
ORDER BY cc.category_name;

-- Show sample components with images
SELECT 
    component_id,
    component_name,
    category_id,
    LEFT(component_image, 60) as image_preview
FROM components
WHERE component_image IS NOT NULL
ORDER BY category_id, component_id
LIMIT 20;














