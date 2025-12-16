-- Check component categories and see what components exist
SELECT 
    cc.category_id,
    cc.category_name,
    COUNT(c.component_id) as count
FROM component_categories cc
LEFT JOIN components c ON cc.category_id = c.category_id
GROUP BY cc.category_id, cc.category_name
ORDER BY cc.category_id;

-- Show sample components with their categories
SELECT 
    c.component_id,
    c.component_name,
    c.category_id,
    cc.category_name
FROM components c
LEFT JOIN component_categories cc ON c.category_id = cc.category_id
ORDER BY c.category_id, c.component_name
LIMIT 50;


















