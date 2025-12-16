-- ============================================================
-- LIMIT COMPONENTS TO 40 PER CATEGORY (Keep Top 40 by Price)
-- ============================================================
-- This SQL will delete excess components, keeping only the top 40
-- (highest priced) components per category
-- 
-- Run this in Supabase SQL Editor
-- ============================================================

-- First, let's see what we have before cleanup
SELECT 
    cc.category_name,
    COUNT(c.component_id) as total_count,
    COUNT(c.component_id) - 40 as to_delete
FROM components c
LEFT JOIN component_categories cc ON c.category_id = cc.category_id
GROUP BY cc.category_name, cc.category_id
ORDER BY cc.category_id;

-- ============================================================
-- DELETE EXCESS COMPONENTS (Keep only top 40 per category)
-- ============================================================

-- Delete excess RAM components (keep top 40 by price)
DELETE FROM components
WHERE component_id IN (
    SELECT component_id
    FROM (
        SELECT 
            component_id,
            ROW_NUMBER() OVER (ORDER BY component_price DESC) as row_num
        FROM components
        WHERE category_id = 3  -- RAM
    ) ranked
    WHERE row_num > 40
);

-- Delete excess CPU components (keep top 40 by price)
DELETE FROM components
WHERE component_id IN (
    SELECT component_id
    FROM (
        SELECT 
            component_id,
            ROW_NUMBER() OVER (ORDER BY component_price DESC) as row_num
        FROM components
        WHERE category_id = 1  -- CPU
    ) ranked
    WHERE row_num > 40
);

-- Delete excess Motherboard components (keep top 40 by price)
DELETE FROM components
WHERE component_id IN (
    SELECT component_id
    FROM (
        SELECT 
            component_id,
            ROW_NUMBER() OVER (ORDER BY component_price DESC) as row_num
        FROM components
        WHERE category_id = 2  -- Motherboard
    ) ranked
    WHERE row_num > 40
);

-- Delete excess Storage components (keep top 40 by price)
DELETE FROM components
WHERE component_id IN (
    SELECT component_id
    FROM (
        SELECT 
            component_id,
            ROW_NUMBER() OVER (ORDER BY component_price DESC) as row_num
        FROM components
        WHERE category_id = 4  -- Storage
    ) ranked
    WHERE row_num > 40
);

-- Delete excess Video Card/GPU components (keep top 40 by price)
DELETE FROM components
WHERE component_id IN (
    SELECT component_id
    FROM (
        SELECT 
            component_id,
            ROW_NUMBER() OVER (ORDER BY component_price DESC) as row_num
        FROM components
        WHERE category_id = 5  -- Video Card
    ) ranked
    WHERE row_num > 40
);

-- Delete excess Power Supply components (keep top 40 by price)
DELETE FROM components
WHERE component_id IN (
    SELECT component_id
    FROM (
        SELECT 
            component_id,
            ROW_NUMBER() OVER (ORDER BY component_price DESC) as row_num
        FROM components
        WHERE category_id = 6  -- Power Supply
    ) ranked
    WHERE row_num > 40
);

-- Delete excess Case components (keep top 40 by price)
DELETE FROM components
WHERE component_id IN (
    SELECT component_id
    FROM (
        SELECT 
            component_id,
            ROW_NUMBER() OVER (ORDER BY component_price DESC) as row_num
        FROM components
        WHERE category_id = 7  -- Case
    ) ranked
    WHERE row_num > 40
);

-- Delete excess CPU Cooler/Cooling components (keep top 40 by price)
DELETE FROM components
WHERE component_id IN (
    SELECT component_id
    FROM (
        SELECT 
            component_id,
            ROW_NUMBER() OVER (ORDER BY component_price DESC) as row_num
        FROM components
        WHERE category_id = 8  -- CPU Cooler
    ) ranked
    WHERE row_num > 40
);

-- ============================================================
-- VERIFY: Check counts after cleanup (should be 40 each)
-- ============================================================
SELECT 
    cc.category_name,
    COUNT(c.component_id) as component_count,
    MIN(c.component_price) as min_price,
    MAX(c.component_price) as max_price
FROM components c
LEFT JOIN component_categories cc ON c.category_id = cc.category_id
GROUP BY cc.category_name, cc.category_id
ORDER BY cc.category_id;

-- ============================================================
-- OPTIONAL: View the remaining 40 components per category
-- ============================================================

-- View RAM (40 components)
SELECT component_name, component_price, compatibility_information
FROM components
WHERE category_id = 3
ORDER BY component_price DESC;

-- View CPU (40 components)
SELECT component_name, component_price, compatibility_information
FROM components
WHERE category_id = 1
ORDER BY component_price DESC;

-- View Motherboard (40 components)
SELECT component_name, component_price, compatibility_information
FROM components
WHERE category_id = 2
ORDER BY component_price DESC;

-- View Storage (40 components)
SELECT component_name, component_price, compatibility_information
FROM components
WHERE category_id = 4
ORDER BY component_price DESC;

-- View Video Card (40 components)
SELECT component_name, component_price, compatibility_information
FROM components
WHERE category_id = 5
ORDER BY component_price DESC;

-- View Power Supply (40 components)
SELECT component_name, component_price, compatibility_information
FROM components
WHERE category_id = 6
ORDER BY component_price DESC;

-- View Case (40 components)
SELECT component_name, component_price, compatibility_information
FROM components
WHERE category_id = 7
ORDER BY component_price DESC;

-- View CPU Cooler (40 components)
SELECT component_name, component_price, compatibility_information
FROM components
WHERE category_id = 8
ORDER BY component_price DESC;





















