-- ============================================================
-- LIMIT COMPONENTS TO 40 PER CATEGORY (Balanced Mix)
-- ============================================================
-- Keeps 40 components per category with mix of cheap and expensive
-- Run this in Supabase SQL Editor
-- ============================================================

-- First, check current counts
SELECT 
    cc.category_name,
    COUNT(c.component_id) as total_count
FROM components c
LEFT JOIN component_categories cc ON c.category_id = cc.category_id
GROUP BY cc.category_name, cc.category_id
ORDER BY cc.category_id;

-- ============================================================
-- DELETE EXCESS COMPONENTS (Keep 20 cheap + 20 expensive)
-- ============================================================

-- CPU: Keep 20 cheapest + 20 most expensive (40 total)
WITH ranked_cpu AS (
    SELECT 
        component_id,
        component_price,
        ROW_NUMBER() OVER (ORDER BY component_price ASC) as cheap_rank,
        ROW_NUMBER() OVER (ORDER BY component_price DESC) as expensive_rank
    FROM components
    WHERE category_id = 1
)
DELETE FROM components
WHERE component_id IN (
    SELECT component_id FROM ranked_cpu
    WHERE cheap_rank > 20 AND expensive_rank > 20
);

-- Motherboard: Keep 20 cheapest + 20 most expensive
WITH ranked_mobo AS (
    SELECT 
        component_id,
        component_price,
        ROW_NUMBER() OVER (ORDER BY component_price ASC) as cheap_rank,
        ROW_NUMBER() OVER (ORDER BY component_price DESC) as expensive_rank
    FROM components
    WHERE category_id = 2
)
DELETE FROM components
WHERE component_id IN (
    SELECT component_id FROM ranked_mobo
    WHERE cheap_rank > 20 AND expensive_rank > 20
);

-- Memory/RAM: Keep 20 cheapest + 20 most expensive
WITH ranked_ram AS (
    SELECT 
        component_id,
        component_price,
        ROW_NUMBER() OVER (ORDER BY component_price ASC) as cheap_rank,
        ROW_NUMBER() OVER (ORDER BY component_price DESC) as expensive_rank
    FROM components
    WHERE category_id = 3
)
DELETE FROM components
WHERE component_id IN (
    SELECT component_id FROM ranked_ram
    WHERE cheap_rank > 20 AND expensive_rank > 20
);

-- Storage: Keep 20 cheapest + 20 most expensive
WITH ranked_storage AS (
    SELECT 
        component_id,
        component_price,
        ROW_NUMBER() OVER (ORDER BY component_price ASC) as cheap_rank,
        ROW_NUMBER() OVER (ORDER BY component_price DESC) as expensive_rank
    FROM components
    WHERE category_id = 4
)
DELETE FROM components
WHERE component_id IN (
    SELECT component_id FROM ranked_storage
    WHERE cheap_rank > 20 AND expensive_rank > 20
);

-- GPU/Video Card: Keep 20 cheapest + 20 most expensive
WITH ranked_gpu AS (
    SELECT 
        component_id,
        component_price,
        ROW_NUMBER() OVER (ORDER BY component_price ASC) as cheap_rank,
        ROW_NUMBER() OVER (ORDER BY component_price DESC) as expensive_rank
    FROM components
    WHERE category_id = 5
)
DELETE FROM components
WHERE component_id IN (
    SELECT component_id FROM ranked_gpu
    WHERE cheap_rank > 20 AND expensive_rank > 20
);

-- PSU: Keep 20 cheapest + 20 most expensive
WITH ranked_psu AS (
    SELECT 
        component_id,
        component_price,
        ROW_NUMBER() OVER (ORDER BY component_price ASC) as cheap_rank,
        ROW_NUMBER() OVER (ORDER BY component_price DESC) as expensive_rank
    FROM components
    WHERE category_id = 6
)
DELETE FROM components
WHERE component_id IN (
    SELECT component_id FROM ranked_psu
    WHERE cheap_rank > 20 AND expensive_rank > 20
);

-- Case: Keep 20 cheapest + 20 most expensive
WITH ranked_case AS (
    SELECT 
        component_id,
        component_price,
        ROW_NUMBER() OVER (ORDER BY component_price ASC) as cheap_rank,
        ROW_NUMBER() OVER (ORDER BY component_price DESC) as expensive_rank
    FROM components
    WHERE category_id = 7
)
DELETE FROM components
WHERE component_id IN (
    SELECT component_id FROM ranked_case
    WHERE cheap_rank > 20 AND expensive_rank > 20
);

-- CPU Cooler: Keep 20 cheapest + 20 most expensive
WITH ranked_cooler AS (
    SELECT 
        component_id,
        component_price,
        ROW_NUMBER() OVER (ORDER BY component_price ASC) as cheap_rank,
        ROW_NUMBER() OVER (ORDER BY component_price DESC) as expensive_rank
    FROM components
    WHERE category_id = 8
)
DELETE FROM components
WHERE component_id IN (
    SELECT component_id FROM ranked_cooler
    WHERE cheap_rank > 20 AND expensive_rank > 20
);

-- ============================================================
-- VERIFY: Should be 40 components each now
-- ============================================================
SELECT 
    cc.category_name,
    COUNT(c.component_id) as component_count,
    MIN(c.component_price) as min_price,
    MAX(c.component_price) as max_price,
    ROUND(AVG(c.component_price)) as avg_price
FROM components c
LEFT JOIN component_categories cc ON c.category_id = cc.category_id
GROUP BY cc.category_name, cc.category_id
ORDER BY cc.category_id;

-- Total components (should be around 320 = 40 x 8 categories)
SELECT COUNT(*) as total_components FROM components;


















