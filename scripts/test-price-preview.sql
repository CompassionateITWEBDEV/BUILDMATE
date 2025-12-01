-- TEST QUERY: Preview what prices will change
-- Run this FIRST to see what will happen before updating
-- This is SAFE - it only reads, doesn't modify anything

-- Show current price distribution by category
SELECT 
  c.category_id,
  MAX(cc.category_name) as category_name,
  COUNT(*) as total_components,
  COUNT(CASE WHEN component_price = 5000 THEN 1 END) as components_at_5000,
  MIN(component_price) as current_min_price,
  MAX(component_price) as current_max_price,
  ROUND(AVG(component_price), 2) as current_avg_price
FROM components c
LEFT JOIN component_categories cc ON c.category_id = cc.category_id
GROUP BY c.category_id
ORDER BY c.category_id;

-- Show sample components that would be affected
SELECT 
  component_id,
  component_name,
  component_price as current_price,
  category_id,
  CASE 
    -- Category 1: CPU
    WHEN category_id = 1 AND component_name LIKE '%Intel Core i3%' AND component_name LIKE '%6%' THEN 800
    WHEN category_id = 1 AND component_name LIKE '%Intel Pentium%' THEN 900
    WHEN category_id = 1 AND component_name LIKE '%Intel Core i5 6%' THEN 1200
    WHEN category_id = 1 AND component_name LIKE '%AMD Ryzen 5 3600%' THEN 2000
    WHEN category_id = 1 AND component_name LIKE '%Intel Core i7%' THEN 3500
    WHEN category_id = 1 AND component_name LIKE '%Xeon%' THEN 1500
    
    -- Category 3: RAM
    WHEN category_id = 3 AND component_name LIKE '%4GB%' THEN 600
    WHEN category_id = 3 AND component_name LIKE '%8GB%' THEN 800
    WHEN category_id = 3 AND component_name LIKE '%16GB%' THEN 1200
    
    -- Category 5: GPU
    WHEN category_id = 5 AND component_name LIKE '%GT 1030%' THEN 1500
    WHEN category_id = 5 AND component_name LIKE '%GTX 1050%' THEN 1800
    WHEN category_id = 5 AND component_name LIKE '%GTX 1650%' THEN 2500
    WHEN category_id = 5 AND component_name LIKE '%RX 550%' THEN 2000
    
    -- Category 6: PSU
    WHEN category_id = 6 AND component_name LIKE '%450W%' THEN 1000
    WHEN category_id = 6 AND component_name LIKE '%500W%' THEN 1200
    WHEN category_id = 6 AND component_name LIKE '%600W%' THEN 1800
    
    -- Default fallbacks
    WHEN category_id = 2 THEN 1200 -- Motherboards
    WHEN category_id = 3 THEN 800 -- RAM default
    WHEN category_id = 4 THEN 800 -- Storage default
    WHEN category_id = 5 THEN 2000 -- GPU default
    WHEN category_id = 6 THEN 1000 -- PSU default
    WHEN category_id = 7 THEN 700 -- Case default
    WHEN category_id = 8 THEN 600 -- Cooler default
    ELSE 1000
  END as new_price
FROM components
WHERE component_price = 5000
ORDER BY category_id, component_name
LIMIT 50;

-- Count how many components will be affected
SELECT 
  'Total components at ₱5000 that will be updated' as description,
  COUNT(*) as count
FROM components
WHERE component_price = 5000;

