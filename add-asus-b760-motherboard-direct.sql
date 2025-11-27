-- Direct SQL to add ASUS B760M-AYW WIFI D4 DDR4 Micro ATX Motherboard
-- Run this in Supabase SQL Editor

-- Insert the motherboard (update price as needed)
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
  8500, -- UPDATE THIS PRICE as needed
  '{"socket":"LGA1700","formFactor":"Micro ATX","chipset":"Intel B760","manufacturer":"ASUS","memory":{"max":64,"ram_type":"DDR4","slots":2},"storage_devices":{"sata_6_gb_s":4,"sata_3_gb_s":0,"u2":0},"m2_slots":[{"size":"2242-2260","key":"M","interface":"PCIe 4.0 x4"},{"size":"2280","key":"M","interface":"PCIe 4.0 x4"},{"size":"2242-2260","key":"M","interface":"PCIe 4.0 x4"},{"size":"2280","key":"M","interface":"PCIe 4.0 x4"}],"pcie_slots":[{"gen":"4.0","quantity":1,"lanes":16},{"gen":"4.0","quantity":2,"lanes":1}],"usb_headers":{"usb_2_0":1,"usb_3_2_gen_1":1,"usb_3_2_gen_2":0,"usb_3_2_gen_2x2":0,"usb_4":0},"onboard_ethernet":[{"speed":"2.5 Gb/s","controller":"Realtek"}],"audio":{"chipset":"Realtek","channels":"7.1"},"raid_support":true,"ecc_support":false,"wifi":true,"m2Slots":"4","sataPorts":"4","memoryType":"DDR4","memorySupport":"DDR4"}',
  (SELECT category_id FROM component_categories WHERE LOWER(category_name) = 'motherboard' LIMIT 1),
  'gaming',
  'in_stock'
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASUS B760M-AYW WIFI D4 DDR4 Micro ATX')
)
RETURNING component_id, component_name;

