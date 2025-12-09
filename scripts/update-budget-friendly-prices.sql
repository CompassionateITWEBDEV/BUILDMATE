-- Update component prices to be budget-friendly
-- This allows builds from ₱15,000 to ₱100,000+
-- Generated: 2025-12-01
-- Goal: Make realistic prices so ₱20,000 budget can work

-- ===============================================
-- CPU PRICES (Category 1) - Budget to High End
-- ===============================================

-- Budget CPUs (₱800 - ₱1,500)
UPDATE components SET component_price = 800 WHERE component_name LIKE '%Intel Core i3%' AND component_name LIKE '%6%' AND category_id = 1;
UPDATE components SET component_price = 900 WHERE component_name LIKE '%Intel Pentium%' AND category_id = 1;
UPDATE components SET component_price = 1000 WHERE component_name LIKE '%Intel Core i3%' AND component_name LIKE '%7%' AND category_id = 1;
UPDATE components SET component_price = 1200 WHERE component_name LIKE '%AMD Ryzen 3 3100%' AND category_id = 1;
UPDATE components SET component_price = 1200 WHERE component_name LIKE '%Intel Core i5 6%' AND category_id = 1;

-- Mid-range CPUs (₱1,500 - ₱3,000)
UPDATE components SET component_price = 1800 WHERE component_name LIKE '%Intel Core i5 7%' AND category_id = 1;
UPDATE components SET component_price = 2000 WHERE component_name LIKE '%AMD Ryzen 5 3600%' AND category_id = 1;
UPDATE components SET component_price = 2500 WHERE component_name LIKE '%Intel Core i5 8%' AND category_id = 1;
UPDATE components SET component_price = 2800 WHERE component_name LIKE '%Intel Core i7 6%' AND category_id = 1;

-- High-end CPUs (₱3,000 - ₱5,000)
UPDATE components SET component_price = 3500 WHERE component_name LIKE '%Intel Core i7 7%' AND category_id = 1;
UPDATE components SET component_price = 4000 WHERE component_name LIKE '%AMD Ryzen 7%' AND component_name LIKE '%3700%' AND category_id = 1;
UPDATE components SET component_price = 4500 WHERE component_name LIKE '%Intel Core i7 8%' AND category_id = 1;
UPDATE components SET component_price = 5000 WHERE component_name LIKE '%Intel Core i7 9%' AND category_id = 1;

-- Keep Xeon and old server CPUs cheap
UPDATE components SET component_price = 1500 WHERE component_name LIKE '%Xeon%' AND category_id = 1;

-- ===============================================
-- MOTHERBOARD PRICES (Category 2) - Budget to High End
-- ===============================================
UPDATE components SET component_price = 1200 WHERE component_price = 5000 AND category_id = 2;
UPDATE components SET component_price = 1500 WHERE component_name LIKE '%B450%' AND category_id = 2;
UPDATE components SET component_price = 1800 WHERE component_name LIKE '%B550%' AND category_id = 2;
UPDATE components SET component_price = 2500 WHERE component_name LIKE '%X570%' AND category_id = 2;
UPDATE components SET component_price = 2000 WHERE component_name LIKE '%Z490%' AND category_id = 2;

-- ===============================================
-- MEMORY/RAM PRICES (Category 3) - Budget to High End
-- ===============================================
UPDATE components SET component_price = 600 WHERE component_price = 5000 AND category_id = 3 AND component_name LIKE '%4GB%';
UPDATE components SET component_price = 800 WHERE component_price = 5000 AND category_id = 3 AND component_name LIKE '%8GB%';
UPDATE components SET component_price = 1200 WHERE component_price = 5000 AND category_id = 3 AND component_name LIKE '%16GB%';
UPDATE components SET component_price = 2000 WHERE component_price = 5000 AND category_id = 3 AND component_name LIKE '%32GB%';
UPDATE components SET component_price = 800 WHERE component_price = 5000 AND category_id = 3; -- Default RAM price

-- ===============================================
-- STORAGE PRICES (Category 4) - Budget to High End
-- ===============================================
UPDATE components SET component_price = 500 WHERE component_price = 5000 AND category_id = 4 AND component_name LIKE '%120GB%';
UPDATE components SET component_price = 600 WHERE component_price = 5000 AND category_id = 4 AND component_name LIKE '%128GB%';
UPDATE components SET component_price = 700 WHERE component_price = 5000 AND category_id = 4 AND component_name LIKE '%240GB%';
UPDATE components SET component_price = 800 WHERE component_price = 5000 AND category_id = 4 AND component_name LIKE '%256GB%';
UPDATE components SET component_price = 1200 WHERE component_price = 5000 AND category_id = 4 AND component_name LIKE '%500GB%';
UPDATE components SET component_price = 1500 WHERE component_price = 5000 AND category_id = 4 AND component_name LIKE '%512GB%';
UPDATE components SET component_price = 1800 WHERE component_price = 5000 AND category_id = 4 AND component_name LIKE '%1TB%';
UPDATE components SET component_price = 800 WHERE component_price = 5000 AND category_id = 4; -- Default storage price

-- ===============================================
-- GPU/VIDEO CARD PRICES (Category 5) - Budget to High End
-- ===============================================
UPDATE components SET component_price = 1500 WHERE component_price = 5000 AND category_id = 5 AND component_name LIKE '%GT 1030%';
UPDATE components SET component_price = 1800 WHERE component_price = 5000 AND category_id = 5 AND component_name LIKE '%GTX 1050%';
UPDATE components SET component_price = 2500 WHERE component_price = 5000 AND category_id = 5 AND component_name LIKE '%GTX 1650%';
UPDATE components SET component_price = 3500 WHERE component_price = 5000 AND category_id = 5 AND component_name LIKE '%GTX 1660%';
UPDATE components SET component_price = 4000 WHERE component_price = 5000 AND category_id = 5 AND component_name LIKE '%RTX 3050%';
UPDATE components SET component_price = 2000 WHERE component_price = 5000 AND category_id = 5 AND component_name LIKE '%RX 550%';
UPDATE components SET component_price = 2500 WHERE component_price = 5000 AND category_id = 5 AND component_name LIKE '%RX 6500%';
UPDATE components SET component_price = 2000 WHERE component_price = 5000 AND category_id = 5; -- Default GPU price

-- ===============================================
-- POWER SUPPLY PRICES (Category 6) - Budget to High End
-- ===============================================
UPDATE components SET component_price = 800 WHERE component_price = 5000 AND category_id = 6 AND component_name LIKE '%300W%';
UPDATE components SET component_price = 900 WHERE component_price = 5000 AND category_id = 6 AND component_name LIKE '%400W%';
UPDATE components SET component_price = 1000 WHERE component_price = 5000 AND category_id = 6 AND component_name LIKE '%450W%';
UPDATE components SET component_price = 1200 WHERE component_price = 5000 AND category_id = 6 AND component_name LIKE '%500W%';
UPDATE components SET component_price = 1500 WHERE component_price = 5000 AND category_id = 6 AND component_name LIKE '%550W%';
UPDATE components SET component_price = 1800 WHERE component_price = 5000 AND category_id = 6 AND component_name LIKE '%600W%';
UPDATE components SET component_price = 2000 WHERE component_price = 5000 AND category_id = 6 AND component_name LIKE '%650W%';
UPDATE components SET component_price = 1000 WHERE component_price = 5000 AND category_id = 6; -- Default PSU price

-- ===============================================
-- CASE PRICES (Category 7) - Budget to High End
-- ===============================================
UPDATE components SET component_price = 600 WHERE component_price = 5000 AND category_id = 7 AND component_name LIKE '%Micro%';
UPDATE components SET component_price = 800 WHERE component_price = 5000 AND category_id = 7 AND component_name LIKE '%Mini%';
UPDATE components SET component_price = 1000 WHERE component_price = 5000 AND category_id = 7 AND component_name LIKE '%ATX%';
UPDATE components SET component_price = 700 WHERE component_price = 5000 AND category_id = 7; -- Default case price

-- ===============================================
-- CPU COOLER PRICES (Category 8) - Budget to High End
-- ===============================================
UPDATE components SET component_price = 300 WHERE component_price = 5000 AND category_id = 8 AND component_name LIKE '%Stock%';
UPDATE components SET component_price = 400 WHERE component_price = 5000 AND category_id = 8 AND component_name LIKE '%Basic%';
UPDATE components SET component_price = 600 WHERE component_price = 5000 AND category_id = 8; -- Default cooler price

-- ===============================================
-- Final fallback for any remaining ₱5000 items
-- ===============================================
UPDATE components SET component_price = 1000 WHERE component_price = 5000;

-- ===============================================
-- Verify the changes
-- ===============================================
SELECT 
  category_id,
  COUNT(*) as component_count,
  MIN(component_price) as min_price,
  MAX(component_price) as max_price,
  AVG(component_price) as avg_price
FROM components
GROUP BY category_id
ORDER BY category_id;
















