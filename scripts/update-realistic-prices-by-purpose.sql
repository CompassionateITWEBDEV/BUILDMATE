-- Update component prices based on PURPOSE (Academic/Office/Gaming)
-- This makes budget-friendly builds possible for ₱15k-20k range

BEGIN;

-- ==========================================
-- CATEGORY 1: CPU PRICES
-- ==========================================
-- Academic CPUs: ₱800-1,500 (cheap processors for basic tasks)
UPDATE components 
SET component_price = 800 
WHERE category_id = 1 AND LOWER(component_purpose) = 'academic' AND component_price = 5000;

-- Office CPUs: ₱1,200-2,000 (mid-range)
UPDATE components 
SET component_price = 1500 
WHERE category_id = 1 AND LOWER(component_purpose) = 'office' AND component_price = 5000;

-- Gaming CPUs: ₱2,500-5,000 (keep higher for performance)
UPDATE components 
SET component_price = 3000 
WHERE category_id = 1 AND LOWER(component_purpose) = 'gaming' AND component_price = 5000;

-- ==========================================
-- CATEGORY 2: MOTHERBOARD PRICES
-- ==========================================
-- Academic Motherboards: ₱900-1,200
UPDATE components 
SET component_price = 1000 
WHERE category_id = 2 AND LOWER(component_purpose) = 'academic' AND component_price = 5000;

-- Office Motherboards: ₱1,200-1,800
UPDATE components 
SET component_price = 1500 
WHERE category_id = 2 AND LOWER(component_purpose) = 'office' AND component_price = 5000;

-- Gaming Motherboards: ₱2,000-3,000
UPDATE components 
SET component_price = 2500 
WHERE category_id = 2 AND LOWER(component_purpose) = 'gaming' AND component_price = 5000;

-- ==========================================
-- CATEGORY 3: RAM PRICES (Based on capacity)
-- ==========================================
-- Academic RAM (usually 8GB): ₱600-800
UPDATE components 
SET component_price = 700 
WHERE category_id = 3 AND LOWER(component_purpose) = 'academic' AND component_price = 5000;

-- Office RAM (16GB): ₱1,000-1,200
UPDATE components 
SET component_price = 1100 
WHERE category_id = 3 AND LOWER(component_purpose) = 'office' AND component_price = 5000;

-- Gaming RAM (16GB-32GB): ₱1,500-2,000
UPDATE components 
SET component_price = 1800 
WHERE category_id = 3 AND LOWER(component_purpose) = 'gaming' AND component_price = 5000;

-- ==========================================
-- CATEGORY 4: STORAGE PRICES
-- ==========================================
-- Academic Storage (256GB-512GB): ₱500-800
UPDATE components 
SET component_price = 650 
WHERE category_id = 4 AND LOWER(component_purpose) = 'academic' AND component_price = 5000;

-- Office Storage (512GB-1TB): ₱900-1,200
UPDATE components 
SET component_price = 1000 
WHERE category_id = 4 AND LOWER(component_purpose) = 'office' AND component_price = 5000;

-- Gaming Storage (1TB-2TB): ₱1,500-2,000
UPDATE components 
SET component_price = 1800 
WHERE category_id = 4 AND LOWER(component_purpose) = 'gaming' AND component_price = 5000;

-- ==========================================
-- CATEGORY 5: GPU/VIDEO CARD PRICES
-- ==========================================
-- Academic GPU (GTX 1650): ₱1,500-2,000
UPDATE components 
SET component_price = 1800 
WHERE category_id = 5 AND LOWER(component_purpose) = 'academic' AND component_price = 5000;

-- Office GPU (GTX 1660): ₱2,500-3,000
UPDATE components 
SET component_price = 2800 
WHERE category_id = 5 AND LOWER(component_purpose) = 'office' AND component_price = 5000;

-- Gaming GPU (RTX 3060/4060): ₱4,000-6,000
UPDATE components 
SET component_price = 5000 
WHERE category_id = 5 AND LOWER(component_purpose) = 'gaming' AND component_price = 5000;

-- ==========================================
-- CATEGORY 6: POWER SUPPLY PRICES
-- ==========================================
-- Academic PSU (500W-600W): ₱800-1,000
UPDATE components 
SET component_price = 900 
WHERE category_id = 6 AND LOWER(component_purpose) = 'academic' AND component_price = 5000;

-- Office PSU (550W-650W): ₱1,000-1,200
UPDATE components 
SET component_price = 1100 
WHERE category_id = 6 AND LOWER(component_purpose) = 'office' AND component_price = 5000;

-- Gaming PSU (700W-1000W): ₱1,500-2,500
UPDATE components 
SET component_price = 2000 
WHERE category_id = 6 AND LOWER(component_purpose) = 'gaming' AND component_price = 5000;

-- ==========================================
-- CATEGORY 7: CASE PRICES
-- ==========================================
-- Academic Cases (Micro ATX): ₱600-800
UPDATE components 
SET component_price = 700 
WHERE category_id = 7 AND LOWER(component_purpose) = 'academic' AND component_price = 5000;

-- Office Cases: ₱800-1,000
UPDATE components 
SET component_price = 900 
WHERE category_id = 7 AND LOWER(component_purpose) = 'office' AND component_price = 5000;

-- Gaming Cases (ATX with RGB): ₱1,200-1,800
UPDATE components 
SET component_price = 1500 
WHERE category_id = 7 AND LOWER(component_purpose) = 'gaming' AND component_price = 5000;

-- ==========================================
-- CATEGORY 8: CPU COOLER PRICES
-- ==========================================
-- Academic Coolers (Basic): ₱400-600
UPDATE components 
SET component_price = 500 
WHERE category_id = 8 AND LOWER(component_purpose) = 'academic' AND component_price = 5000;

-- Office Coolers: ₱600-800
UPDATE components 
SET component_price = 700 
WHERE category_id = 8 AND LOWER(component_purpose) = 'office' AND component_price = 5000;

-- Gaming Coolers (AIO): ₱1,000-1,500
UPDATE components 
SET component_price = 1200 
WHERE category_id = 8 AND LOWER(component_purpose) = 'gaming' AND component_price = 5000;

-- ==========================================
-- Handle NULL component_purpose (default to mid-range)
-- ==========================================
UPDATE components SET component_price = 1200 WHERE category_id = 1 AND component_purpose IS NULL AND component_price = 5000;
UPDATE components SET component_price = 1200 WHERE category_id = 2 AND component_purpose IS NULL AND component_price = 5000;
UPDATE components SET component_price = 900 WHERE category_id = 3 AND component_purpose IS NULL AND component_price = 5000;
UPDATE components SET component_price = 800 WHERE category_id = 4 AND component_purpose IS NULL AND component_price = 5000;
UPDATE components SET component_price = 2500 WHERE category_id = 5 AND component_purpose IS NULL AND component_price = 5000;
UPDATE components SET component_price = 1000 WHERE category_id = 6 AND component_purpose IS NULL AND component_price = 5000;
UPDATE components SET component_price = 800 WHERE category_id = 7 AND component_purpose IS NULL AND component_price = 5000;
UPDATE components SET component_price = 600 WHERE category_id = 8 AND component_purpose IS NULL AND component_price = 5000;

-- ==========================================
-- VERIFY RESULTS
-- ==========================================
SELECT 
  COALESCE(component_purpose, 'NULL') as purpose,
  category_id,
  COUNT(*) as total,
  MIN(component_price) as min_price,
  MAX(component_price) as max_price,
  ROUND(AVG(component_price), 2) as avg_price
FROM components
GROUP BY component_purpose, category_id
ORDER BY category_id, component_purpose;

-- Summary
SELECT 
  'Components still at ₱5000' as description,
  COUNT(*) as count
FROM components
WHERE component_price = 5000;

COMMIT;



