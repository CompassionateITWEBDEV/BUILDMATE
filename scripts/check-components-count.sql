-- Check component counts per category in Supabase
-- Run this in Supabase SQL Editor

-- Component counts by category
SELECT 
    cc.category_name,
    COUNT(c.component_id) as component_count,
    MIN(c.component_price) as min_price,
    MAX(c.component_price) as max_price,
    AVG(c.component_price) as avg_price
FROM components c
LEFT JOIN component_categories cc ON c.category_id = cc.category_id
GROUP BY cc.category_name
ORDER BY component_count DESC;

-- Get top 40 components per category
-- RAM (category_id = 3)
SELECT 
    component_name, 
    component_price,
    compatibility_information
FROM components
WHERE category_id = 3
ORDER BY component_price DESC
LIMIT 40;

-- CPU (category_id = 1)
SELECT 
    component_name, 
    component_price,
    compatibility_information
FROM components
WHERE category_id = 1
ORDER BY component_price DESC
LIMIT 40;

-- GPU/Video Card (category_id = 5)
SELECT 
    component_name, 
    component_price,
    compatibility_information
FROM components
WHERE category_id = 5
ORDER BY component_price DESC
LIMIT 40;

-- Motherboard (category_id = 2)
SELECT 
    component_name, 
    component_price,
    compatibility_information
FROM components
WHERE category_id = 2
ORDER BY component_price DESC
LIMIT 40;

-- Storage (category_id = 4)
SELECT 
    component_name, 
    component_price,
    compatibility_information
FROM components
WHERE category_id = 4
ORDER BY component_price DESC
LIMIT 40;

-- Power Supply (category_id = 6)
SELECT 
    component_name, 
    component_price,
    compatibility_information
FROM components
WHERE category_id = 6
ORDER BY component_price DESC
LIMIT 40;

-- Case (category_id = 7)
SELECT 
    component_name, 
    component_price,
    compatibility_information
FROM components
WHERE category_id = 7
ORDER BY component_price DESC
LIMIT 40;

-- CPU Cooler (category_id = 8)
SELECT 
    component_name, 
    component_price,
    compatibility_information
FROM components
WHERE category_id = 8
ORDER BY component_price DESC
LIMIT 40;










