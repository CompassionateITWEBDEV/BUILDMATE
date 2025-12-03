-- ============================================================
-- UPDATE MOTHERBOARD PRICES BASED ON CHIPSET TIER
-- ============================================================
-- Budget Motherboards: ₱2,000 - ₱5,000
-- Mid-range Motherboards: ₱5,000 - ₱15,000
-- High-end Motherboards: ₱15,000 - ₱40,000+
-- ============================================================

-- ============================================================
-- ADD MISSING COLUMNS IF THEY DON'T EXIST
-- ============================================================
-- Add component_image column
ALTER TABLE components 
ADD COLUMN IF NOT EXISTS component_image TEXT;

-- Add component_brand column
ALTER TABLE components 
ADD COLUMN IF NOT EXISTS component_brand TEXT;

-- Add component_purpose column
ALTER TABLE components 
ADD COLUMN IF NOT EXISTS component_purpose TEXT;

-- Add comments to explain the fields
COMMENT ON COLUMN components.component_image IS 'URL or Supabase Storage path to the component image';
COMMENT ON COLUMN components.component_brand IS 'Brand or manufacturer of the component';
COMMENT ON COLUMN components.component_purpose IS 'Intended use: academic, office, or gaming';

-- ============================================================

-- First, let's see current motherboard prices
SELECT 
    component_name,
    component_price,
    CASE
        WHEN component_name ILIKE '%H310%' OR component_name ILIKE '%A320%' OR component_name ILIKE '%H410%' OR component_name ILIKE '%A520%' THEN 'Budget'
        WHEN component_name ILIKE '%B450%' OR component_name ILIKE '%B460%' OR component_name ILIKE '%B550%' OR component_name ILIKE '%B560%' OR component_name ILIKE '%B660%' OR component_name ILIKE '%B760%' THEN 'Mid-range'
        WHEN component_name ILIKE '%Z490%' OR component_name ILIKE '%Z590%' OR component_name ILIKE '%Z690%' OR component_name ILIKE '%Z790%' OR component_name ILIKE '%X570%' OR component_name ILIKE '%X670%' OR component_name ILIKE '%X870%' THEN 'High-end'
        ELSE 'Unknown'
    END as tier
FROM components
WHERE category_id = 2  -- Motherboard category
ORDER BY tier, component_price DESC;

-- ============================================================
-- UPDATE BUDGET MOTHERBOARDS (₱2,000 - ₱5,000)
-- ============================================================
-- Intel: H310, H410, H510
-- AMD: A320, A520, A620

UPDATE components
SET component_price = 
    CASE 
        -- Intel H-series (budget)
        WHEN component_name ILIKE '%H310%' 
            THEN 2000 + (RANDOM() * 2000)::int  -- ₱2,000 - ₱4,000
        
        WHEN component_name ILIKE '%H410%' OR component_name ILIKE '%H510%'
            THEN 2500 + (RANDOM() * 2500)::int  -- ₱2,500 - ₱5,000
        
        -- AMD A-series (budget)
        WHEN component_name ILIKE '%A320%'
            THEN 2000 + (RANDOM() * 2000)::int  -- ₱2,000 - ₱4,000
        
        WHEN component_name ILIKE '%A520%' OR component_name ILIKE '%A620%'
            THEN 2500 + (RANDOM() * 2500)::int  -- ₱2,500 - ₱5,000
        
        ELSE component_price
    END
WHERE category_id = 2
  AND (
    component_name ILIKE '%H310%' 
    OR component_name ILIKE '%H410%' 
    OR component_name ILIKE '%H510%'
    OR component_name ILIKE '%A320%' 
    OR component_name ILIKE '%A520%'
    OR component_name ILIKE '%A620%'
  );

-- ============================================================
-- UPDATE MID-RANGE MOTHERBOARDS (₱5,000 - ₱15,000)
-- ============================================================
-- Intel: B460, B560, B660, B760
-- AMD: B450, B550, B650

UPDATE components
SET component_price = 
    CASE 
        -- AMD B450 (older mid-range)
        WHEN component_name ILIKE '%B450%'
            THEN 4000 + (RANDOM() * 4000)::int  -- ₱4,000 - ₱8,000
        
        -- Intel B460, B560 (mid-range)
        WHEN component_name ILIKE '%B460%' OR component_name ILIKE '%B560%'
            THEN 5000 + (RANDOM() * 5000)::int  -- ₱5,000 - ₱10,000
        
        -- AMD B550 (mid-range)
        WHEN component_name ILIKE '%B550%'
            THEN 6000 + (RANDOM() * 6000)::int  -- ₱6,000 - ₱12,000
        
        -- Intel B660, B760 (newer mid-range)
        WHEN component_name ILIKE '%B660%' OR component_name ILIKE '%B760%'
            THEN 7000 + (RANDOM() * 8000)::int  -- ₱7,000 - ₱15,000
        
        -- AMD B650 (newer mid-range)
        WHEN component_name ILIKE '%B650%'
            THEN 7000 + (RANDOM() * 8000)::int  -- ₱7,000 - ₱15,000
        
        ELSE component_price
    END
WHERE category_id = 2
  AND (
    component_name ILIKE '%B450%' 
    OR component_name ILIKE '%B460%' 
    OR component_name ILIKE '%B550%'
    OR component_name ILIKE '%B560%' 
    OR component_name ILIKE '%B660%'
    OR component_name ILIKE '%B650%'
    OR component_name ILIKE '%B760%'
  );

-- ============================================================
-- UPDATE HIGH-END MOTHERBOARDS (₱15,000 - ₱40,000+)
-- ============================================================
-- Intel: Z390, Z490, Z590, Z690, Z790
-- AMD: X470, X570, X670, X870

UPDATE components
SET component_price = 
    CASE 
        -- Intel Z390, Z490 (older high-end)
        WHEN component_name ILIKE '%Z390%' OR component_name ILIKE '%Z490%'
            THEN 12000 + (RANDOM() * 13000)::int  -- ₱12,000 - ₱25,000
        
        -- AMD X470, X570 (high-end)
        WHEN component_name ILIKE '%X470%' OR component_name ILIKE '%X570%'
            THEN 15000 + (RANDOM() * 15000)::int  -- ₱15,000 - ₱30,000
        
        -- Intel Z590, Z690 (newer high-end)
        WHEN component_name ILIKE '%Z590%' OR component_name ILIKE '%Z690%'
            THEN 18000 + (RANDOM() * 17000)::int  -- ₱18,000 - ₱35,000
        
        -- Intel Z790 (latest high-end)
        WHEN component_name ILIKE '%Z790%'
            THEN 20000 + (RANDOM() * 20000)::int  -- ₱20,000 - ₱40,000
        
        -- AMD X670, X870 (latest high-end)
        WHEN component_name ILIKE '%X670%' OR component_name ILIKE '%X870%'
            THEN 20000 + (RANDOM() * 25000)::int  -- ₱20,000 - ₱45,000
        
        ELSE component_price
    END
WHERE category_id = 2
  AND (
    component_name ILIKE '%Z390%' 
    OR component_name ILIKE '%Z490%' 
    OR component_name ILIKE '%Z590%'
    OR component_name ILIKE '%Z690%' 
    OR component_name ILIKE '%Z790%'
    OR component_name ILIKE '%X470%' 
    OR component_name ILIKE '%X570%'
    OR component_name ILIKE '%X670%'
    OR component_name ILIKE '%X870%'
  );

-- ============================================================
-- UPDATE MOTHERBOARD COMPONENT_PURPOSE
-- ============================================================

-- Academic: Budget motherboards
UPDATE components
SET component_purpose = 'academic'
WHERE category_id = 2
  AND (
    component_name ILIKE '%H310%' 
    OR component_name ILIKE '%H410%' 
    OR component_name ILIKE '%A320%'
  );

-- Office: Budget to Mid-range motherboards
UPDATE components
SET component_purpose = 'office'
WHERE category_id = 2
  AND (
    component_name ILIKE '%H510%'
    OR component_name ILIKE '%A520%'
    OR component_name ILIKE '%A620%'
    OR component_name ILIKE '%B450%'
    OR component_name ILIKE '%B460%'
    OR (component_name ILIKE '%B550%' AND component_price < 10000)
    OR (component_name ILIKE '%B560%' AND component_price < 10000)
  );

-- Gaming: Mid to High-end motherboards
UPDATE components
SET component_purpose = 'gaming'
WHERE category_id = 2
  AND (
    -- High-end B-series
    (component_name ILIKE '%B550%' AND component_price >= 10000)
    OR (component_name ILIKE '%B560%' AND component_price >= 10000)
    OR component_name ILIKE '%B660%'
    OR component_name ILIKE '%B650%'
    OR component_name ILIKE '%B760%'
    -- All Z-series and X-series (high-end gaming/enthusiast)
    OR component_name ILIKE '%Z390%'
    OR component_name ILIKE '%Z490%'
    OR component_name ILIKE '%Z590%'
    OR component_name ILIKE '%Z690%'
    OR component_name ILIKE '%Z790%'
    OR component_name ILIKE '%X470%'
    OR component_name ILIKE '%X570%'
    OR component_name ILIKE '%X670%'
    OR component_name ILIKE '%X870%'
  );

-- ============================================================
-- VERIFY UPDATED PRICES AND PURPOSE
-- ============================================================
SELECT 
    component_purpose,
    CASE
        WHEN component_name ILIKE '%H310%' OR component_name ILIKE '%H410%' OR component_name ILIKE '%A320%' OR component_name ILIKE '%A520%' THEN 'Budget'
        WHEN component_name ILIKE '%B450%' OR component_name ILIKE '%B460%' OR component_name ILIKE '%B550%' OR component_name ILIKE '%B560%' OR component_name ILIKE '%B660%' OR component_name ILIKE '%B650%' THEN 'Mid-range'
        WHEN component_name ILIKE '%Z%' OR component_name ILIKE '%X%' THEN 'High-end'
        ELSE 'Unknown'
    END as tier,
    COUNT(*) as mobo_count,
    MIN(component_price) as min_price,
    MAX(component_price) as max_price,
    ROUND(AVG(component_price)) as avg_price
FROM components
WHERE category_id = 2
GROUP BY component_purpose, tier
ORDER BY component_purpose, avg_price;

-- Show sample motherboards by purpose
SELECT 
    component_purpose,
    component_name,
    component_price
FROM components
WHERE category_id = 2
ORDER BY component_purpose, component_price
LIMIT 30;

-- ============================================================
-- UPDATE ALL COMPONENT IMAGES WITH PLACEHOLDERS
-- ============================================================
-- Using placeholder images that display component info
-- Format: https://via.placeholder.com/400x400/COLOR/ffffff?text=COMPONENT+NAME

-- ============================================================
-- CPU IMAGES (Category ID: 1)
-- ============================================================
-- Blue background for CPUs
UPDATE components 
SET component_image = 'https://via.placeholder.com/400x400/0066cc/ffffff?text=' || 
                     REPLACE(REPLACE(REPLACE(SUBSTRING(component_name, 1, 30), ' ', '+'), '/', '-'), '&', 'and')
WHERE category_id = 1  -- CPU
AND component_image IS NULL;

-- ============================================================
-- MOTHERBOARD IMAGES (Category ID: 2)
-- ============================================================
-- Green background for Motherboards
UPDATE components 
SET component_image = 'https://via.placeholder.com/400x400/00aa44/ffffff?text=' || 
                     REPLACE(REPLACE(REPLACE(SUBSTRING(component_name, 1, 30), ' ', '+'), '/', '-'), '&', 'and')
WHERE category_id = 2  -- Motherboard
AND component_image IS NULL;

-- ============================================================
-- RAM/MEMORY IMAGES (Category ID: 3)
-- ============================================================
-- Purple background for RAM
UPDATE components 
SET component_image = 'https://via.placeholder.com/400x400/9933cc/ffffff?text=' || 
                     REPLACE(REPLACE(REPLACE(SUBSTRING(component_name, 1, 30), ' ', '+'), '/', '-'), '&', 'and')
WHERE category_id = 3  -- RAM
AND component_image IS NULL;

-- ============================================================
-- STORAGE IMAGES (Category ID: 4)
-- ============================================================
-- Orange background for Storage
UPDATE components 
SET component_image = 'https://via.placeholder.com/400x400/ff8800/ffffff?text=' || 
                     REPLACE(REPLACE(REPLACE(SUBSTRING(component_name, 1, 30), ' ', '+'), '/', '-'), '&', 'and')
WHERE category_id = 4  -- Storage
AND component_image IS NULL;

-- ============================================================
-- GPU/VIDEO CARD IMAGES (Category ID: 5)
-- ============================================================
-- Red background for GPUs
UPDATE components 
SET component_image = 'https://via.placeholder.com/400x400/cc0000/ffffff?text=' || 
                     REPLACE(REPLACE(REPLACE(SUBSTRING(component_name, 1, 30), ' ', '+'), '/', '-'), '&', 'and')
WHERE category_id = 5  -- GPU
AND component_image IS NULL;

-- ============================================================
-- PSU/POWER SUPPLY IMAGES (Category ID: 6)
-- ============================================================
-- Yellow/Gold background for PSU
UPDATE components 
SET component_image = 'https://via.placeholder.com/400x400/ffaa00/ffffff?text=' || 
                     REPLACE(REPLACE(REPLACE(SUBSTRING(component_name, 1, 30), ' ', '+'), '/', '-'), '&', 'and')
WHERE category_id = 6  -- PSU
AND component_image IS NULL;

-- ============================================================
-- CASE IMAGES (Category ID: 7)
-- ============================================================
-- Gray background for Cases
UPDATE components 
SET component_image = 'https://via.placeholder.com/400x400/666666/ffffff?text=' || 
                     REPLACE(REPLACE(REPLACE(SUBSTRING(component_name, 1, 30), ' ', '+'), '/', '-'), '&', 'and')
WHERE category_id = 7  -- Case
AND component_image IS NULL;

-- ============================================================
-- COOLING IMAGES (Category ID: 8)
-- ============================================================
-- Cyan/Light Blue background for Cooling
UPDATE components 
SET component_image = 'https://via.placeholder.com/400x400/00ccff/ffffff?text=' || 
                     REPLACE(REPLACE(REPLACE(SUBSTRING(component_name, 1, 30), ' ', '+'), '/', '-'), '&', 'and')
WHERE category_id = 8  -- Cooling
AND component_image IS NULL;

-- ============================================================
-- VERIFY ALL COMPONENTS WITH IMAGES
-- ============================================================
-- Check image coverage by category
SELECT 
    cc.category_id,
    cc.category_name,
    COUNT(*) as total_components,
    COUNT(c.component_image) as components_with_images,
    COUNT(*) - COUNT(c.component_image) as components_without_images,
    ROUND(COUNT(c.component_image) * 100.0 / COUNT(*), 2) as coverage_percentage
FROM components c
JOIN component_categories cc ON c.category_id = cc.category_id
GROUP BY cc.category_id, cc.category_name
ORDER BY cc.category_id;

-- Show sample components by category with image status
SELECT 
    cc.category_name,
    c.component_name,
    CASE WHEN c.component_image IS NOT NULL THEN 'Has Image' ELSE 'No Image' END as image_status,
    c.component_image
FROM components c
JOIN component_categories cc ON c.category_id = cc.category_id
ORDER BY cc.category_name, c.component_name
LIMIT 100;



