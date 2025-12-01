-- Check how many components exist per category
SELECT 
  cc.category_id,
  cc.category_name,
  COUNT(c.component_id) as component_count,
  MIN(c.component_price) as min_price,
  MAX(c.component_price) as max_price,
  COUNT(CASE WHEN c.component_price = 5000 THEN 1 END) as count_at_5000
FROM component_categories cc
LEFT JOIN components c ON cc.category_id = c.category_id
GROUP BY cc.category_id, cc.category_name
ORDER BY cc.category_id;

-- Show which categories are missing components
SELECT 
  cc.category_id,
  cc.category_name
FROM component_categories cc
LEFT JOIN components c ON cc.category_id = c.category_id
WHERE c.component_id IS NULL
GROUP BY cc.category_id, cc.category_name
ORDER BY cc.category_id;

-- Count components in categories 6, 7, 8 specifically
SELECT 
  'PSU (Category 6)' as category,
  COUNT(*) as count
FROM components
WHERE category_id = 6

UNION ALL

SELECT 
  'Case (Category 7)' as category,
  COUNT(*) as count
FROM components
WHERE category_id = 7

UNION ALL

SELECT 
  'CPU Cooler (Category 8)' as category,
  COUNT(*) as count
FROM components
WHERE category_id = 8;

