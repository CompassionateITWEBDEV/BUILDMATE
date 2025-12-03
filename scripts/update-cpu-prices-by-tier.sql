-- ============================================================
-- UPDATE CPU PRICES BASED ON PERFORMANCE TIERS
-- ============================================================
-- Budget CPUs: ₱3,000 - ₱8,000
-- Mid-range CPUs: ₱8,000 - ₱20,000
-- High-end CPUs: ₱20,000 - ₱50,000+
-- ============================================================

-- First, let's see current CPU prices
SELECT 
    component_name,
    component_price,
    CASE
        WHEN component_name ILIKE '%i3%' OR component_name ILIKE '%Ryzen 3%' OR component_name ILIKE '%Pentium%' OR component_name ILIKE '%Athlon%' THEN 'Budget'
        WHEN component_name ILIKE '%i5%' OR component_name ILIKE '%Ryzen 5%' THEN 'Mid-range'
        WHEN component_name ILIKE '%i7%' OR component_name ILIKE '%i9%' OR component_name ILIKE '%Ryzen 7%' OR component_name ILIKE '%Ryzen 9%' OR component_name ILIKE '%Xeon%' THEN 'High-end'
        ELSE 'Unknown'
    END as tier
FROM components
WHERE category_id = 1  -- CPU category
ORDER BY tier, component_price DESC;

-- ============================================================
-- UPDATE BUDGET CPUS (₱3,000 - ₱8,000)
-- ============================================================
-- Intel Core i3, Ryzen 3, Pentium, Athlon

UPDATE components
SET component_price = 
    CASE 
        -- Pentium/Athlon (lowest tier)
        WHEN component_name ILIKE '%Pentium%' OR component_name ILIKE '%Athlon%' 
            THEN 3000 + (RANDOM() * 2000)::int  -- ₱3,000 - ₱5,000
        
        -- Ryzen 3 (entry budget)
        WHEN component_name ILIKE '%Ryzen 3%' 
            THEN 4000 + (RANDOM() * 3000)::int  -- ₱4,000 - ₱7,000
        
        -- Intel Core i3 (mid budget)
        WHEN component_name ILIKE '%i3%' 
            THEN 5000 + (RANDOM() * 3000)::int  -- ₱5,000 - ₱8,000
        
        ELSE component_price  -- Keep existing price if no match
    END
WHERE category_id = 1  -- CPU category
  AND (
    component_name ILIKE '%i3%' 
    OR component_name ILIKE '%Ryzen 3%' 
    OR component_name ILIKE '%Pentium%' 
    OR component_name ILIKE '%Athlon%'
  );

-- ============================================================
-- UPDATE MID-RANGE CPUS (₱8,000 - ₱20,000)
-- ============================================================
-- Intel Core i5, AMD Ryzen 5

UPDATE components
SET component_price = 
    CASE 
        -- Ryzen 5 (lower mid-range)
        WHEN component_name ILIKE '%Ryzen 5 3%' OR component_name ILIKE '%Ryzen 5 4%'
            THEN 8000 + (RANDOM() * 4000)::int  -- ₱8,000 - ₱12,000
        
        -- Intel Core i5 (mid-range)
        WHEN component_name ILIKE '%i5 10%' OR component_name ILIKE '%i5 11%'
            THEN 10000 + (RANDOM() * 5000)::int  -- ₱10,000 - ₱15,000
        
        -- Newer Ryzen 5 / Core i5 (higher mid-range)
        WHEN component_name ILIKE '%Ryzen 5 5%' OR component_name ILIKE '%Ryzen 5 7%' 
          OR component_name ILIKE '%i5 12%' OR component_name ILIKE '%i5 13%'
            THEN 12000 + (RANDOM() * 8000)::int  -- ₱12,000 - ₱20,000
        
        -- Generic i5 or Ryzen 5
        WHEN component_name ILIKE '%i5%'
            THEN 9000 + (RANDOM() * 6000)::int  -- ₱9,000 - ₱15,000
        
        WHEN component_name ILIKE '%Ryzen 5%'
            THEN 8500 + (RANDOM() * 6500)::int  -- ₱8,500 - ₱15,000
        
        ELSE component_price
    END
WHERE category_id = 1
  AND (component_name ILIKE '%i5%' OR component_name ILIKE '%Ryzen 5%');

-- ============================================================
-- UPDATE HIGH-END CPUS (₱20,000 - ₱50,000+)
-- ============================================================
-- Intel Core i7, i9, AMD Ryzen 7, Ryzen 9, Xeon

UPDATE components
SET component_price = 
    CASE 
        -- Ryzen 7 (entry high-end)
        WHEN component_name ILIKE '%Ryzen 7 3%' OR component_name ILIKE '%Ryzen 7 5%'
            THEN 18000 + (RANDOM() * 10000)::int  -- ₱18,000 - ₱28,000
        
        -- Intel Core i7 (high-end)
        WHEN component_name ILIKE '%i7 10%' OR component_name ILIKE '%i7 11%'
            THEN 20000 + (RANDOM() * 12000)::int  -- ₱20,000 - ₱32,000
        
        -- Newer i7, Ryzen 7
        WHEN component_name ILIKE '%i7 12%' OR component_name ILIKE '%i7 13%' OR component_name ILIKE '%i7 14%'
          OR component_name ILIKE '%Ryzen 7 7%'
            THEN 25000 + (RANDOM() * 15000)::int  -- ₱25,000 - ₱40,000
        
        -- Generic i7
        WHEN component_name ILIKE '%i7%'
            THEN 22000 + (RANDOM() * 13000)::int  -- ₱22,000 - ₱35,000
        
        -- Ryzen 9 (enthusiast)
        WHEN component_name ILIKE '%Ryzen 9 5%'
            THEN 28000 + (RANDOM() * 15000)::int  -- ₱28,000 - ₱43,000
        
        WHEN component_name ILIKE '%Ryzen 9 7%'
            THEN 35000 + (RANDOM() * 20000)::int  -- ₱35,000 - ₱55,000
        
        -- Intel Core i9 (enthusiast/extreme)
        WHEN component_name ILIKE '%i9 10%' OR component_name ILIKE '%i9 11%'
            THEN 30000 + (RANDOM() * 20000)::int  -- ₱30,000 - ₱50,000
        
        WHEN component_name ILIKE '%i9 12%' OR component_name ILIKE '%i9 13%' OR component_name ILIKE '%i9 14%'
            THEN 40000 + (RANDOM() * 30000)::int  -- ₱40,000 - ₱70,000
        
        -- Intel Xeon (workstation)
        WHEN component_name ILIKE '%Xeon%'
            THEN 25000 + (RANDOM() * 25000)::int  -- ₱25,000 - ₱50,000
        
        -- Generic Ryzen 7/9
        WHEN component_name ILIKE '%Ryzen 7%'
            THEN 20000 + (RANDOM() * 15000)::int  -- ₱20,000 - ₱35,000
        
        WHEN component_name ILIKE '%Ryzen 9%'
            THEN 30000 + (RANDOM() * 20000)::int  -- ₱30,000 - ₱50,000
        
        -- Generic i9
        WHEN component_name ILIKE '%i9%'
            THEN 35000 + (RANDOM() * 25000)::int  -- ₱35,000 - ₱60,000
        
        ELSE component_price
    END
WHERE category_id = 1
  AND (
    component_name ILIKE '%i7%' 
    OR component_name ILIKE '%i9%' 
    OR component_name ILIKE '%Ryzen 7%' 
    OR component_name ILIKE '%Ryzen 9%'
    OR component_name ILIKE '%Xeon%'
  );

-- ============================================================
-- VERIFY UPDATED PRICES
-- ============================================================
SELECT 
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
GROUP BY tier
ORDER BY avg_price;

-- Show sample CPUs per tier
SELECT 
    CASE
        WHEN component_name ILIKE '%i3%' OR component_name ILIKE '%Ryzen 3%' OR component_name ILIKE '%Pentium%' OR component_name ILIKE '%Athlon%' THEN 'Budget'
        WHEN component_name ILIKE '%i5%' OR component_name ILIKE '%Ryzen 5%' THEN 'Mid-range'
        WHEN component_name ILIKE '%i7%' OR component_name ILIKE '%i9%' OR component_name ILIKE '%Ryzen 7%' OR component_name ILIKE '%Ryzen 9%' OR component_name ILIKE '%Xeon%' THEN 'High-end'
        ELSE 'Unknown'
    END as tier,
    component_name,
    component_price
FROM components
WHERE category_id = 1
ORDER BY tier, component_price
LIMIT 50;





