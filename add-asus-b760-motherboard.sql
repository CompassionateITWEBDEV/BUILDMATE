-- Add ASUS B760M-AYW WIFI D4 DDR4 Micro ATX Motherboard
-- This script adds the motherboard with full compatibility information

-- First, get the category_id for Motherboard (assuming it exists)
-- If not, you may need to insert it first

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
  0, -- Set price as needed
  jsonb_build_object(
    'socket', 'LGA1700',
    'formFactor', 'Micro ATX',
    'chipset', 'Intel B760',
    'manufacturer', 'ASUS',
    'memory', jsonb_build_object(
      'max', 64,
      'ram_type', 'DDR4',
      'slots', 2
    ),
    'storage_devices', jsonb_build_object(
      'sata_6_gb_s', 4,
      'sata_3_gb_s', 0,
      'u2', 0
    ),
    'm2_slots', jsonb_build_array(
      jsonb_build_object('size', '2242-2260', 'key', 'M', 'interface', 'PCIe 4.0 x4'),
      jsonb_build_object('size', '2280', 'key', 'M', 'interface', 'PCIe 4.0 x4'),
      jsonb_build_object('size', '2242-2260', 'key', 'M', 'interface', 'PCIe 4.0 x4'),
      jsonb_build_object('size', '2280', 'key', 'M', 'interface', 'PCIe 4.0 x4')
    ),
    'pcie_slots', jsonb_build_array(
      jsonb_build_object('gen', '4.0', 'quantity', 1, 'lanes', 16),
      jsonb_build_object('gen', '4.0', 'quantity', 2, 'lanes', 1)
    ),
    'usb_headers', jsonb_build_object(
      'usb_2_0', 1,
      'usb_3_2_gen_1', 1,
      'usb_3_2_gen_2', 0,
      'usb_3_2_gen_2x2', 0,
      'usb_4', 0
    ),
    'onboard_ethernet', jsonb_build_array(
      jsonb_build_object('speed', '2.5 Gb/s', 'controller', 'Realtek')
    ),
    'audio', jsonb_build_object(
      'chipset', 'Realtek',
      'channels', '7.1'
    ),
    'raid_support', true,
    'ecc_support', false,
    'wifi', true,
    'm2Slots', '4',
    'sataPorts', '4',
    'memoryType', 'DDR4',
    'memorySupport', 'DDR4'
  )::text,
  (SELECT category_id FROM component_categories WHERE category_name = 'Motherboard' LIMIT 1),
  'gaming', -- Set performance category (gaming, academic, office, or null)
  'in_stock'
)
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE component_name = 'ASUS B760M-AYW WIFI D4 DDR4 Micro ATX'
);

-- If you need to update an existing motherboard instead, use:
/*
UPDATE components
SET 
  compatibility_information = jsonb_build_object(
    'socket', 'LGA1700',
    'formFactor', 'Micro ATX',
    'chipset', 'Intel B760',
    'manufacturer', 'ASUS',
    'memory', jsonb_build_object(
      'max', 64,
      'ram_type', 'DDR4',
      'slots', 2
    ),
    'storage_devices', jsonb_build_object(
      'sata_6_gb_s', 4,
      'sata_3_gb_s', 0,
      'u2', 0
    ),
    'm2_slots', jsonb_build_array(
      jsonb_build_object('size', '2242-2260', 'key', 'M', 'interface', 'PCIe 4.0 x4'),
      jsonb_build_object('size', '2280', 'key', 'M', 'interface', 'PCIe 4.0 x4'),
      jsonb_build_object('size', '2242-2260', 'key', 'M', 'interface', 'PCIe 4.0 x4'),
      jsonb_build_object('size', '2280', 'key', 'M', 'interface', 'PCIe 4.0 x4')
    ),
    'pcie_slots', jsonb_build_array(
      jsonb_build_object('gen', '4.0', 'quantity', 1, 'lanes', 16),
      jsonb_build_object('gen', '4.0', 'quantity', 2, 'lanes', 1)
    ),
    'usb_headers', jsonb_build_object(
      'usb_2_0', 1,
      'usb_3_2_gen_1', 1,
      'usb_3_2_gen_2', 0,
      'usb_3_2_gen_2x2', 0,
      'usb_4', 0
    ),
    'onboard_ethernet', jsonb_build_array(
      jsonb_build_object('speed', '2.5 Gb/s', 'controller', 'Realtek')
    ),
    'audio', jsonb_build_object(
      'chipset', 'Realtek',
      'channels', '7.1'
    ),
    'raid_support', true,
    'ecc_support', false,
    'wifi', true,
    'm2Slots', '4',
    'sataPorts', '4',
    'memoryType', 'DDR4',
    'memorySupport', 'DDR4'
  )::text
WHERE component_name = 'ASUS B760M-AYW WIFI D4 DDR4 Micro ATX';
*/

