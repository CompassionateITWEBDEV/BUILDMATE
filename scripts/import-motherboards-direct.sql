-- Import 20+ Motherboards from BuildCores OpenDB
-- All motherboards include full compatibility information for CSP and compatibility checking
-- Run this in Supabase SQL Editor

-- Note: This is a template. You'll need to fetch actual data from BuildCores OpenDB
-- or run the Python script: python scripts/import_motherboards_buildcores.py

-- Example motherboard insert (you can duplicate and modify for more):
INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  availability_status
)
SELECT 
  'ASUS B760M-AYW WIFI D4 DDR4 Micro ATX',
  8500,
  '{"socket":"LGA1700","formFactor":"Micro ATX","chipset":"Intel B760","manufacturer":"ASUS","memory":{"max":64,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","memorySupport":"DDR4","storage_devices":{"sata_6_gb_s":4,"sata_3_gb_s":0},"sataPorts":"4","m2_slots":[{"size":"2242-2260","key":"M","interface":"PCIe 4.0 x4"},{"size":"2280","key":"M","interface":"PCIe 4.0 x4"}],"m2Slots":"4","pcie_slots":[{"gen":"4.0","quantity":1,"lanes":16}],"wifi":true,"raid_support":true,"ecc_support":false}',
  (SELECT category_id FROM component_categories WHERE LOWER(category_name) = 'motherboard' LIMIT 1),
  'gaming',
  'in_stock'
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASUS B760M-AYW WIFI D4 DDR4 Micro ATX')
);

-- To import more motherboards, run the Python script:
-- python scripts/import_motherboards_buildcores.py
-- This will generate a complete SQL file with 20+ motherboards

