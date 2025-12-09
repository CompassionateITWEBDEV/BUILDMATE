-- ============================================================
-- CHECK COMPONENTS IN DATABASE
-- ============================================================

-- Check total components count
SELECT COUNT(*) as total_components FROM components;

-- Check components by category
SELECT 
    cc.category_name,
    COUNT(c.component_id) as component_count
FROM component_categories cc
LEFT JOIN components c ON cc.category_id = c.category_id
GROUP BY cc.category_name
ORDER BY cc.category_name;

-- Check if component_image column exists
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'components' 
AND column_name = 'component_image';

-- Show sample components
SELECT 
    component_id,
    component_name,
    component_brand,
    component_price,
    category_id
FROM components
LIMIT 20;

-- Check all categories
SELECT * FROM component_categories ORDER BY category_id;










