-- UPDATE COMPONENT IMAGES AND CLEAN UP DATABASE
-- Run this in Supabase SQL Editor

-- ============================================
-- 1. ADD IMAGES TO EXISTING COMPONENTS
-- ============================================

-- Intel CPUs (use local placeholder image)
UPDATE components 
SET component_image = '/intel-core-i7-cpu.png'
WHERE component_name LIKE '%Intel%' AND component_name LIKE '%Core%' AND component_image IS NULL;

-- AMD CPUs (use local placeholder image)
UPDATE components 
SET component_image = '/amd-ryzen-cpu.jpg'
WHERE component_name LIKE '%AMD%' AND component_name LIKE '%Ryzen%' AND component_image IS NULL;

-- Xeon CPUs (use Intel image)
UPDATE components 
SET component_image = '/intel-core-i7-cpu.png'
WHERE component_name LIKE '%Xeon%' AND component_image IS NULL;

-- PC Cases - Aerocool CS Series (use local images)
UPDATE components 
SET component_image = '/AEROCOOL CS-111-G-BK-V2 Black Case with 3 FRGB Fan.webp'
WHERE component_name LIKE '%Aerocool CS%' AND component_name LIKE '%Black%' AND component_image IS NULL;

UPDATE components 
SET component_image = '/AEROCOOL CS-111-G-WT-V2 White Case with 3 FRGB Fan.webp'
WHERE component_name LIKE '%Aerocool CS%' AND component_name LIKE '%White%' AND component_image IS NULL;

-- If no color specified, use black version
UPDATE components 
SET component_image = '/AEROCOOL CS-111-G-BK-V2 Black Case with 3 FRGB Fan.webp'
WHERE component_name LIKE '%Aerocool CS%' AND component_image IS NULL;

-- Aerocool Viewport Mini cases
UPDATE components 
SET component_image = '/AEROCOOL Viewport Mini-G-BK-V2 Black Mini Tower.webp'
WHERE component_name LIKE '%Aerocool Viewport%' AND component_name LIKE '%Black%' AND component_image IS NULL;

UPDATE components 
SET component_image = '/AEROCOOL Viewport Mini-G-WT-V2 White Mini Tower.webp'
WHERE component_name LIKE '%Aerocool Viewport%' AND component_name LIKE '%White%' AND component_image IS NULL;

-- If no color specified, use black version
UPDATE components 
SET component_image = '/AEROCOOL Viewport Mini-G-BK-V2 Black Mini Tower.webp'
WHERE component_name LIKE '%Aerocool Viewport%' AND component_image IS NULL;

-- All other cases without images
UPDATE components 
SET component_image = '/AEROCOOL CS-111-G-BK-V2 Black Case with 3 FRGB Fan.webp'
WHERE category_id = (SELECT category_id FROM component_categories WHERE category_name = 'Case' LIMIT 1)
AND component_image IS NULL;

-- GPUs (use local placeholder image)
UPDATE components 
SET component_image = '/nvidia-rtx-4080-graphics-card.jpg'
WHERE category_id = (SELECT category_id FROM component_categories WHERE category_name = 'GPU' LIMIT 1)
AND component_image IS NULL;

-- Motherboards (use local placeholder image)
UPDATE components 
SET component_image = '/asus-motherboard.jpg'
WHERE category_id = (SELECT category_id FROM component_categories WHERE category_name = 'Motherboard' LIMIT 1)
AND component_image IS NULL;

-- ============================================
-- 2. UPDATE PRICES FOR EXISTING COMPONENTS
-- ============================================

UPDATE components SET component_price = 35495.00 WHERE component_name LIKE '%i9-13900K%' AND component_name NOT LIKE '%KF%';
UPDATE components SET component_price = 20195.00 WHERE component_name LIKE '%i5-13600K%';
UPDATE components SET component_price = 6595.00 WHERE component_name LIKE '%i5-12400F%';
UPDATE components SET component_price = 6550.00 WHERE component_name LIKE '%i3-12100%';
UPDATE components SET component_price = 34895.00 WHERE component_name LIKE '%Ryzen 9 7950X%';
UPDATE components SET component_price = 7795.00 WHERE component_name LIKE '%Ryzen 5 5600X%';
UPDATE components SET component_price = 6550.00 WHERE component_name LIKE '%Ryzen 5 5600G%';
UPDATE components SET component_price = 3255.00 WHERE component_name LIKE '%Ryzen 3 3200G%';
UPDATE components SET component_price = 7999.00 WHERE component_name LIKE '%i5 9400%';
UPDATE components SET component_price = 4866.67 WHERE component_name LIKE '%Ryzen 5 4500%';
UPDATE components SET component_price = 12299.00 WHERE component_name LIKE '%i5 10500%';
UPDATE components SET component_price = 20195.00 WHERE component_name LIKE '%Xeon E5 1650 V3%';
UPDATE components SET component_price = 21850.00 WHERE component_name LIKE '%Ryzen 9 7900%';
UPDATE components SET component_price = 14795.00 WHERE component_name LIKE '%Xeon E5 E5-2643 V2%';
UPDATE components SET component_price = 14795.00 WHERE component_name LIKE '%Xeon E5 2660 V3%';
UPDATE components SET component_price = 33895.00 WHERE component_name LIKE '%i9 13900KF%';
UPDATE components SET component_price = 15395.00 WHERE component_name LIKE '%Ryzen 7 8700F%';
UPDATE components SET component_price = 24550.00 WHERE component_name LIKE '%i7 14700KF%';
UPDATE components SET component_price = 13995.00 WHERE component_name LIKE '%Core Ultra 5 225F%';
UPDATE components SET component_price = 8450.00 WHERE component_name LIKE '%Ryzen 5 2600X%';
UPDATE components SET component_price = 6295.00 WHERE component_name LIKE '%i5 11400%';
UPDATE components SET component_price = 11829.63 WHERE component_name LIKE '%i5 12500%';

-- ============================================
-- 3. REMOVE OUTDATED/DISCONTINUED COMPONENTS
-- ============================================

-- Delete discontinued components (safer to delete if they have "Remove" in your list)
DELETE FROM components 
WHERE component_name IN (
  'Intel Core i5 8500',
  'Intel Core i5 8600',
  'Intel Xeon E5 2660',
  'Intel Core i9 9820X',
  'AMD Ryzen 9 3950X',
  'Intel Core i9 10900X',
  'Intel Core i9-9900X',
  'Intel Xeon E5 2699 V3',
  'Intel Xeon E5 2687W',
  'Intel Core i7 Extreme 4960X',
  'Intel Core i9 9900X',
  'Intel Xeon E5 2697 V3',
  'AMD FX FX 8370',
  'AMD EPYC 4564P',
  'AMD Threadripper 2990WX',
  'AMD Opteron 6320'
);

-- ============================================
-- 4. VERIFY UPDATES
-- ============================================

-- Check components with images
SELECT component_name, component_price, component_image
FROM components
WHERE category_id = (SELECT category_id FROM component_categories WHERE category_name = 'CPU' LIMIT 1)
ORDER BY component_price DESC
LIMIT 20;

-- Count components by category
SELECT cc.category_name, COUNT(*) as total
FROM components c
JOIN component_categories cc ON c.category_id = cc.category_id
GROUP BY cc.category_name
ORDER BY cc.category_name;

