-- Verification Query: Check if components are imported correctly
-- Run this in Supabase SQL Editor after importing components

-- 1. Check total component count
SELECT 
  'Total Components' as check_type,
  COUNT(*) as count
FROM components;

-- 2. Check distribution by category
SELECT 
  c.category_id,
  cc.category_name,
  COUNT(*) as component_count,
  MIN(c.component_price) as min_price,
  MAX(c.component_price) as max_price,
  AVG(c.component_price)::numeric(10,2) as avg_price
FROM components c
LEFT JOIN component_categories cc ON c.category_id = cc.category_id
GROUP BY c.category_id, cc.category_name
ORDER BY c.category_id;

-- 3. Check for components with price = 0 (these will be filtered out in UI)
SELECT 
  c.category_id,
  cc.category_name,
  COUNT(*) as components_with_zero_price
FROM components c
LEFT JOIN component_categories cc ON c.category_id = cc.category_id
WHERE c.component_price = 0 OR c.component_price IS NULL
GROUP BY c.category_id, cc.category_name
ORDER BY c.category_id;

-- 4. Check for components with missing compatibility info
SELECT 
  c.category_id,
  cc.category_name,
  COUNT(*) as components_without_compat_info
FROM components c
LEFT JOIN component_categories cc ON c.category_id = cc.category_id
WHERE c.compatibility_information IS NULL OR c.compatibility_information::text = '{}'
GROUP BY c.category_id, cc.category_name
ORDER BY c.category_id;

-- 5. Sample components from each category (first 3)
SELECT 
  c.component_id,
  c.component_name,
  c.component_price,
  cc.category_name,
  c.category_id
FROM components c
LEFT JOIN component_categories cc ON c.category_id = cc.category_id
ORDER BY c.category_id, c.component_id
LIMIT 24;  -- 3 per category × 8 categories

-- 6. Check BuildCores imported components (by name pattern)
SELECT 
  cc.category_name,
  COUNT(*) as buildcores_components
FROM components c
LEFT JOIN component_categories cc ON c.category_id = cc.category_id
WHERE c.component_name LIKE '%Intel%' 
   OR c.component_name LIKE '%AMD%'
   OR c.component_name LIKE '%Asus%'
   OR c.component_name LIKE '%Gigabyte%'
   OR c.component_name LIKE '%MSI%'
   OR c.component_name LIKE '%Corsair%'
   OR c.component_name LIKE '%TEAMGROUP%'
GROUP BY cc.category_name
ORDER BY cc.category_name;



