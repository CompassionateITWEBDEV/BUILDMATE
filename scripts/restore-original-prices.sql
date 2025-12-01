-- RESTORE ORIGINAL PRICES - Set all components back to ₱5,000
-- This reverts the budget-friendly price changes

BEGIN;

-- CPU (Category 1) - Restore to ₱5,000
UPDATE components SET component_price = 5000 WHERE category_id = 1;

-- Motherboard (Category 2) - Restore to ₱5,000
UPDATE components SET component_price = 5000 WHERE category_id = 2;

-- RAM (Category 3) - Restore to ₱5,000
UPDATE components SET component_price = 5000 WHERE category_id = 3;

-- Storage (Category 4) - Restore to ₱5,000
UPDATE components SET component_price = 5000 WHERE category_id = 4;

-- GPU (Category 5) - Restore to ₱5,000
UPDATE components SET component_price = 5000 WHERE category_id = 5;

-- PSU (Category 6) - Restore to ₱5,000
UPDATE components SET component_price = 5000 WHERE category_id = 6;

-- Case (Category 7) - Restore to ₱5,000
UPDATE components SET component_price = 5000 WHERE category_id = 7;

-- CPU Cooler (Category 8) - Restore to ₱5,000
UPDATE components SET component_price = 5000 WHERE category_id = 8;

-- Verify all prices are back to ₱5,000
SELECT 
  category_id,
  COUNT(*) as total_components,
  MIN(component_price) as min_price,
  MAX(component_price) as max_price,
  COUNT(CASE WHEN component_price = 5000 THEN 1 END) as components_at_5000
FROM components
GROUP BY category_id
ORDER BY category_id;

COMMIT;



