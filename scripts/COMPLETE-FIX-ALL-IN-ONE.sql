-- COMPLETE FIX: RLS + Images in ONE Script
-- Copy ALL of this and run in Supabase SQL Editor

-- ============================================
-- STEP 1: DISABLE RLS (Allow Public Access)
-- ============================================
ALTER TABLE components DISABLE ROW LEVEL SECURITY;
ALTER TABLE component_categories DISABLE ROW LEVEL SECURITY;
ALTER TABLE retailers DISABLE ROW LEVEL SECURITY;
ALTER TABLE builds DISABLE ROW LEVEL SECURITY;
ALTER TABLE build_components DISABLE ROW LEVEL SECURITY;
ALTER TABLE users DISABLE ROW LEVEL SECURITY;

-- ============================================
-- STEP 2: ADD IMAGES TO COMPONENTS
-- ============================================

-- Intel CPUs
UPDATE components SET component_image = 'https://images.newegg.com/ProductImage/19-118-414-V01.jpg'
WHERE component_name LIKE '%i9-13900K%' AND component_name NOT LIKE '%KF%';

UPDATE components SET component_image = 'https://images.newegg.com/ProductImage/19-118-412-V01.jpg'
WHERE component_name LIKE '%i5-13600K%';

UPDATE components SET component_image = 'https://images.newegg.com/ProductImage/19-118-357-V01.jpg'
WHERE component_name LIKE '%i5-12400F%';

UPDATE components SET component_image = 'https://images.newegg.com/ProductImage/19-118-358-V01.jpg'
WHERE component_name LIKE '%i3-12100%';

UPDATE components SET component_image = 'https://images.newegg.com/ProductImage/19-118-286-V01.jpg'
WHERE component_name LIKE '%i5 9400%';

UPDATE components SET component_image = 'https://images.newegg.com/ProductImage/19-118-371-V01.jpg'
WHERE component_name LIKE '%i5 10500%';

UPDATE components SET component_image = 'https://images.newegg.com/ProductImage/19-118-415-V01.jpg'
WHERE component_name LIKE '%i9 13900KF%';

UPDATE components SET component_image = 'https://images.newegg.com/ProductImage/19-118-431-V01.jpg'
WHERE component_name LIKE '%i7 14700KF%';

UPDATE components SET component_image = 'https://images.newegg.com/ProductImage/19-118-453-V01.jpg'
WHERE component_name LIKE '%Core Ultra 5 225F%';

UPDATE components SET component_image = 'https://images.newegg.com/ProductImage/19-118-375-V01.jpg'
WHERE component_name LIKE '%i5 11400%';

UPDATE components SET component_image = 'https://images.newegg.com/ProductImage/19-118-376-V01.jpg'
WHERE component_name LIKE '%i5 12500%';

-- AMD CPUs
UPDATE components SET component_image = 'https://images.newegg.com/ProductImage/19-113-770-V01.jpg'
WHERE component_name LIKE '%Ryzen 9 7950X%';

UPDATE components SET component_image = 'https://images.newegg.com/ProductImage/19-113-666-V01.jpg'
WHERE component_name LIKE '%Ryzen 5 5600X%';

UPDATE components SET component_image = 'https://images.newegg.com/ProductImage/19-113-683-V01.jpg'
WHERE component_name LIKE '%Ryzen 5 5600G%';

UPDATE components SET component_image = 'https://images.newegg.com/ProductImage/19-113-570-V01.jpg'
WHERE component_name LIKE '%Ryzen 3 3200G%';

UPDATE components SET component_image = 'https://images.newegg.com/ProductImage/19-113-735-V01.jpg'
WHERE component_name LIKE '%Ryzen 5 4500%';

UPDATE components SET component_image = 'https://images.newegg.com/ProductImage/19-113-771-V01.jpg'
WHERE component_name LIKE '%Ryzen 9 7900%';

UPDATE components SET component_image = 'https://images.newegg.com/ProductImage/19-113-800-V01.jpg'
WHERE component_name LIKE '%Ryzen 7 8700F%';

UPDATE components SET component_image = 'https://images.newegg.com/ProductImage/19-113-630-V01.jpg'
WHERE component_name LIKE '%Ryzen 5 2600X%';

-- Xeon CPUs
UPDATE components SET component_image = 'https://images.newegg.com/ProductImage/19-117-559-V01.jpg'
WHERE component_name LIKE '%Xeon%';

-- ============================================
-- STEP 3: UPDATE PRICES
-- ============================================
UPDATE components SET component_price = 35495.00 WHERE component_name LIKE '%i9-13900K%' AND component_name NOT LIKE '%KF%';
UPDATE components SET component_price = 20195.00 WHERE component_name LIKE '%i5-13600K%';
UPDATE components SET component_price = 6595.00 WHERE component_name LIKE '%i5-12400F%';
UPDATE components SET component_price = 6550.00 WHERE component_name LIKE '%i3-12100%';
UPDATE components SET component_price = 34895.00 WHERE component_name LIKE '%Ryzen 9 7950X%';
UPDATE components SET component_price = 7795.00 WHERE component_name LIKE '%Ryzen 5 5600X%';
UPDATE components SET component_price = 6550.00 WHERE component_name LIKE '%Ryzen 5 5600G%';
UPDATE components SET component_price = 3255.00 WHERE component_name LIKE '%Ryzen 3 3200G%';

-- ============================================
-- STEP 4: VERIFY CHANGES
-- ============================================
SELECT 
  component_name, 
  component_price, 
  CASE 
    WHEN component_image IS NULL THEN '❌ NO IMAGE'
    ELSE '✅ HAS IMAGE'
  END as image_status
FROM components
WHERE category_id = (SELECT category_id FROM component_categories WHERE category_name = 'CPU' LIMIT 1)
ORDER BY component_price DESC
LIMIT 20;

-- If you see ✅ HAS IMAGE, it worked!
-- If you see ❌ NO IMAGE, the component name might be different








