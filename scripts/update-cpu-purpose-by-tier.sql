-- ============================================================
-- UPDATE CPU COMPONENT_PURPOSE BASED ON TIER
-- ============================================================
-- Academic: Budget CPUs (i3, Ryzen 3, Pentium) - ₱3,000 - ₱8,000
-- Office: Budget to Mid-range (i3, i5, Ryzen 3, Ryzen 5) - ₱3,000 - ₱15,000
-- Gaming: Mid to High-end (i5, i7, i9, Ryzen 5/7/9) - ₱8,000 - ₱50,000+
-- ============================================================

-- First, check current component_purpose distribution
SELECT 
    component_purpose,
    COUNT(*) as count
FROM components
WHERE category_id = 1  -- CPU category
GROUP BY component_purpose;

-- ============================================================
-- UPDATE ACADEMIC CPUS (Budget tier)
-- ============================================================
-- Intel Core i3, Ryzen 3, Pentium, Athlon
-- Perfect for students, online classes, research, document work

UPDATE components
SET component_purpose = 'academic'
WHERE category_id = 1
  AND (
    component_name ILIKE '%i3%' 
    OR component_name ILIKE '%Ryzen 3%' 
    OR component_name ILIKE '%Pentium%' 
    OR component_name ILIKE '%Athlon%'
  );

-- ============================================================
-- UPDATE OFFICE CPUS (Budget to Mid-range)
-- ============================================================
-- Intel Core i5 (lower tier), Ryzen 5 (lower tier)
-- Good for business, productivity, multitasking, office work

UPDATE components
SET component_purpose = 'office'
WHERE category_id = 1
  AND (
    -- Lower tier i5
    (component_name ILIKE '%i5%' AND component_price < 15000)
    OR 
    -- Lower tier Ryzen 5
    (component_name ILIKE '%Ryzen 5%' AND component_price < 15000)
  );

-- ============================================================
-- UPDATE GAMING CPUS (Mid to High-end)
-- ============================================================
-- High-end i5, i7, i9, Ryzen 5/7/9
-- Best for gaming, streaming, content creation, heavy computing

UPDATE components
SET component_purpose = 'gaming'
WHERE category_id = 1
  AND (
    -- High-end i5 (₱15k+)
    (component_name ILIKE '%i5%' AND component_price >= 15000)
    OR
    -- All i7
    component_name ILIKE '%i7%'
    OR
    -- All i9
    component_name ILIKE '%i9%'
    OR
    -- High-end Ryzen 5 (₱15k+)
    (component_name ILIKE '%Ryzen 5%' AND component_price >= 15000)
    OR
    -- All Ryzen 7
    component_name ILIKE '%Ryzen 7%'
    OR
    -- All Ryzen 9
    component_name ILIKE '%Ryzen 9%'
    OR
    -- Xeon (for workstation/gaming)
    component_name ILIKE '%Xeon%'
  );

-- ============================================================
-- VERIFY UPDATED COMPONENT_PURPOSE
-- ============================================================
SELECT 
    component_purpose,
    CASE
        WHEN component_name ILIKE '%i3%' OR component_name ILIKE '%Ryzen 3%' OR component_name ILIKE '%Pentium%' OR component_name ILIKE '%Athlon%' THEN 'Budget'
        WHEN component_name ILIKE '%i5%' OR component_name ILIKE '%Ryzen 5%' THEN 'Mid-range'
        WHEN component_name ILIKE '%i7%' OR component_name ILIKE '%i9%' OR component_name ILIKE '%Ryzen 7%' OR component_name ILIKE '%Ryzen 9%' OR component_name ILIKE '%Xeon%' THEN 'High-end'
        ELSE 'Unknown'
    END as tier,
    COUNT(*) as cpu_count,
    MIN(component_price) as min_price,
    MAX(component_price) as max_price,
    ROUND(AVG(component_price)) as avg_price
FROM components
WHERE category_id = 1
GROUP BY component_purpose, tier
ORDER BY component_purpose, avg_price;

-- ============================================================
-- SHOW SAMPLE CPUS BY PURPOSE
-- ============================================================

-- Academic CPUs (Budget)
SELECT 'ACADEMIC' as purpose, component_name, component_price, component_purpose
FROM components
WHERE category_id = 1 AND component_purpose = 'academic'
ORDER BY component_price
LIMIT 10;

-- Office CPUs (Budget to Mid-range)
SELECT 'OFFICE' as purpose, component_name, component_price, component_purpose
FROM components
WHERE category_id = 1 AND component_purpose = 'office'
ORDER BY component_price
LIMIT 10;

-- Gaming CPUs (Mid to High-end)
SELECT 'GAMING' as purpose, component_name, component_price, component_purpose
FROM components
WHERE category_id = 1 AND component_purpose = 'gaming'
ORDER BY component_price DESC
LIMIT 10;

-- ============================================================
-- SUMMARY: CPUs by Purpose and Price Range
-- ============================================================
SELECT 
    component_purpose,
    COUNT(*) as total_cpus,
    MIN(component_price) as min_price,
    MAX(component_price) as max_price,
    ROUND(AVG(component_price)) as avg_price,
    STRING_AGG(DISTINCT 
        CASE
            WHEN component_name ILIKE '%i3%' THEN 'Core i3'
            WHEN component_name ILIKE '%i5%' THEN 'Core i5'
            WHEN component_name ILIKE '%i7%' THEN 'Core i7'
            WHEN component_name ILIKE '%i9%' THEN 'Core i9'
            WHEN component_name ILIKE '%Ryzen 3%' THEN 'Ryzen 3'
            WHEN component_name ILIKE '%Ryzen 5%' THEN 'Ryzen 5'
            WHEN component_name ILIKE '%Ryzen 7%' THEN 'Ryzen 7'
            WHEN component_name ILIKE '%Ryzen 9%' THEN 'Ryzen 9'
            WHEN component_name ILIKE '%Pentium%' THEN 'Pentium'
        END, ', ') as cpu_types
FROM components
WHERE category_id = 1
GROUP BY component_purpose
ORDER BY avg_price;









