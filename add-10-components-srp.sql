-- Add 10 Components with SRP Prices and Full Compatibility Information
-- These components are optimized for CSP recommendations and graph-based upgrade algorithms
-- All prices are in PHP (Philippine Peso) based on Suggested Retail Price (SRP)
--
-- IMPORTANT: Before running this script, ensure the component_purpose column exists.
-- Run: add-component-purpose-column.sql first if needed.

-- 1. CPU - Intel Core i5-12400F (Budget Gaming CPU)
INSERT INTO components (
  component_name,
  component_brand,
  component_price,
  component_description,
  compatibility_information,
  category_id,
  component_purpose,
  availability_status
)
SELECT 
  'Intel Core i5-12400F 6-Core 12-Thread Processor',
  'Intel',
  8995.00, -- SRP: ₱8,995
  '6-core, 12-thread CPU with base clock 2.5GHz, boost up to 4.4GHz. Perfect for gaming and productivity.',
  jsonb_build_object(
    'socket', 'LGA1700',
    'cpuSocket', 'LGA1700',
    'tdp', 65,
    'tdpRating', '65W',
    'cores', 6,
    'threads', 12,
    'baseClock', '2.5GHz',
    'boostClock', '4.4GHz',
    'memoryType', 'DDR4',
    'ramType', 'DDR4',
    'maxMemory', 128,
    'manufacturer', 'Intel',
    'generation', '12th Gen Alder Lake'
  )::text,
  (SELECT category_id FROM component_categories WHERE category_name = 'CPU' LIMIT 1),
  'gaming',
  'in_stock'
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE component_name = 'Intel Core i5-12400F 6-Core 12-Thread Processor'
);

-- 2. GPU - NVIDIA GeForce RTX 4060 8GB
INSERT INTO components (
  component_name,
  component_brand,
  component_price,
  component_description,
  compatibility_information,
  category_id,
  component_purpose,
  availability_status
)
SELECT 
  'NVIDIA GeForce RTX 4060 8GB GDDR6',
  'NVIDIA',
  24995.00, -- SRP: ₱24,995
  '8GB GDDR6 VRAM, 3072 CUDA cores. Excellent for 1080p and 1440p gaming with DLSS 3 support.',
  jsonb_build_object(
    'vram', 8,
    'memoryType', 'GDDR6',
    'cudaCores', 3072,
    'boostClock', '2460MHz',
    'tdp', 115,
    'tdpRating', '115W',
    'powerRequirement', 115,
    'length', 240,
    'height', 111,
    'width', 40,
    'pcieVersion', '4.0',
    'manufacturer', 'NVIDIA',
    'architecture', 'Ada Lovelace'
  )::text,
  (SELECT category_id FROM component_categories WHERE category_name = 'GPU' LIMIT 1),
  'gaming',
  'in_stock'
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE component_name = 'NVIDIA GeForce RTX 4060 8GB GDDR6'
);

-- 3. Motherboard - MSI B660M PRO-VDH DDR4
INSERT INTO components (
  component_name,
  component_brand,
  component_price,
  component_description,
  compatibility_information,
  category_id,
  component_purpose,
  availability_status
)
SELECT 
  'MSI B660M PRO-VDH DDR4 Micro ATX',
  'MSI',
  6995.00, -- SRP: ₱6,995
  'Micro ATX motherboard with LGA1700 socket, DDR4 support, PCIe 4.0, and M.2 slots.',
  jsonb_build_object(
    'socket', 'LGA1700',
    'cpuSocket', 'LGA1700',
    'formFactor', 'Micro ATX',
    'chipset', 'Intel B660',
    'manufacturer', 'MSI',
    'memory', jsonb_build_object(
      'max', 128,
      'ram_type', 'DDR4',
      'slots', 4,
      'maxSpeed', '3200MHz'
    ),
    'ram_type', 'DDR4',
    'memoryType', 'DDR4',
    'pcie_slots', jsonb_build_array(
      jsonb_build_object('gen', '4.0', 'quantity', 1, 'lanes', 16),
      jsonb_build_object('gen', '3.0', 'quantity', 1, 'lanes', 4)
    ),
    'm2_slots', jsonb_build_array(
      jsonb_build_object('size', '2280', 'key', 'M', 'interface', 'PCIe 4.0 x4'),
      jsonb_build_object('size', '2280', 'key', 'M', 'interface', 'PCIe 3.0 x4')
    ),
    'sataPorts', 4,
    'm2Slots', '2',
    'wifi', false,
    'onboard_ethernet', jsonb_build_array(
      jsonb_build_object('speed', '1 Gb/s', 'controller', 'Realtek')
    )
  )::text,
  (SELECT category_id FROM component_categories WHERE category_name = 'Motherboard' LIMIT 1),
  'gaming',
  'in_stock'
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE component_name = 'MSI B660M PRO-VDH DDR4 Micro ATX'
);

-- 4. RAM - Corsair Vengeance LPX 16GB DDR4 3200MHz
INSERT INTO components (
  component_name,
  component_brand,
  component_price,
  component_description,
  compatibility_information,
  category_id,
  component_purpose,
  availability_status
)
SELECT 
  'Corsair Vengeance LPX 16GB (2x8GB) DDR4 3200MHz',
  'Corsair',
  3495.00, -- SRP: ₱3,495
  '16GB dual-channel DDR4 memory kit, 3200MHz speed, optimized for Intel and AMD platforms.',
  jsonb_build_object(
    'ram_type', 'DDR4',
    'memoryType', 'DDR4',
    'capacity', 16,
    'speed', 3200,
    'speedMhz', '3200MHz',
    'modules', 2,
    'sizePerModule', 8,
    'voltage', '1.35V',
    'casLatency', 16,
    'formFactor', 'DIMM',
    'manufacturer', 'Corsair',
    'series', 'Vengeance LPX'
  )::text,
  (SELECT category_id FROM component_categories WHERE category_name = 'RAM' LIMIT 1),
  'gaming',
  'in_stock'
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE component_name = 'Corsair Vengeance LPX 16GB (2x8GB) DDR4 3200MHz'
);

-- 5. Storage - Samsung 980 500GB NVMe SSD
INSERT INTO components (
  component_name,
  component_brand,
  component_price,
  component_description,
  compatibility_information,
  category_id,
  component_purpose,
  availability_status
)
SELECT 
  'Samsung 980 500GB NVMe PCIe 3.0 M.2 SSD',
  'Samsung',
  3295.00, -- SRP: ₱3,295
  '500GB NVMe SSD with read speeds up to 3,500MB/s, perfect for OS and games.',
  jsonb_build_object(
    'capacity', 500,
    'capacityGB', '500GB',
    'interface', 'PCIe 3.0 x4',
    'formFactor', 'M.2 2280',
    'readSpeed', 3500,
    'writeSpeed', 3000,
    'readSpeedMBs', '3500MB/s',
    'writeSpeedMBs', '3000MB/s',
    'nandType', 'TLC',
    'controller', 'Samsung',
    'manufacturer', 'Samsung',
    'model', '980'
  )::text,
  (SELECT category_id FROM component_categories WHERE category_name = 'Storage' LIMIT 1),
  'gaming',
  'in_stock'
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE component_name = 'Samsung 980 500GB NVMe PCIe 3.0 M.2 SSD'
);

-- 6. PSU - Corsair CV650 650W 80+ Bronze
INSERT INTO components (
  component_name,
  component_brand,
  component_price,
  component_description,
  compatibility_information,
  category_id,
  component_purpose,
  availability_status
)
SELECT 
  'Corsair CV650 650W 80+ Bronze Certified PSU',
  'Corsair',
  3995.00, -- SRP: ₱3,995
  '650W power supply with 80+ Bronze efficiency, fully modular cables, perfect for mid-range builds.',
  jsonb_build_object(
    'wattage', 650,
    'powerRequirement', 650,
    'efficiency', '80+ Bronze',
    'efficiencyRating', 'Bronze',
    'modular', true,
    'modularType', 'Fully Modular',
    'pcieConnectors', 2,
    'sataConnectors', 6,
    'cpuConnectors', 1,
    'manufacturer', 'Corsair',
    'series', 'CV Series',
    'formFactor', 'ATX'
  )::text,
  (SELECT category_id FROM component_categories WHERE category_name = 'PSU' LIMIT 1),
  'gaming',
  'in_stock'
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE component_name = 'Corsair CV650 650W 80+ Bronze Certified PSU'
);

-- 7. Case - NZXT H510 Flow Mid Tower
INSERT INTO components (
  component_name,
  component_brand,
  component_price,
  component_description,
  compatibility_information,
  category_id,
  component_purpose,
  availability_status
)
SELECT 
  'NZXT H510 Flow Mid Tower ATX Case',
  'NZXT',
  5495.00, -- SRP: ₱5,495
  'Mid-tower case with excellent airflow, supports ATX, Micro-ATX, and Mini-ITX motherboards.',
  jsonb_build_object(
    'formFactor', 'Mid Tower',
    'motherboardSupport', jsonb_build_array('ATX', 'Micro-ATX', 'Mini-ITX'),
    'maxGpuLength', 381,
    'max_gpu_length', 381,
    'maxCoolerHeight', 165,
    'max_cooler_height', 165,
    'maxPsuLength', 180,
    'fanSlots', jsonb_build_object(
      'front', 2,
      'top', 2,
      'rear', 1
    ),
    'radiatorSupport', jsonb_build_object(
      'front', '280mm',
      'top', '240mm'
    ),
    'driveBays', jsonb_build_object(
      'internal35', 2,
      'internal25', 2
    ),
    'manufacturer', 'NZXT',
    'series', 'H510',
    'color', 'Black'
  )::text,
  (SELECT category_id FROM component_categories WHERE category_name = 'Case' LIMIT 1),
  'gaming',
  'in_stock'
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE component_name = 'NZXT H510 Flow Mid Tower ATX Case'
);

-- 8. CPU Cooler - Cooler Master Hyper 212 RGB
INSERT INTO components (
  component_name,
  component_brand,
  component_price,
  component_description,
  compatibility_information,
  category_id,
  component_purpose,
  availability_status
)
SELECT 
  'Cooler Master Hyper 212 RGB CPU Air Cooler',
  'Cooler Master',
  2295.00, -- SRP: ₱2,295
  'Popular air cooler with RGB lighting, supports multiple sockets including LGA1700, AM4, AM5.',
  jsonb_build_object(
    'type', 'Air Cooler',
    'coolerType', 'Air',
    'height', 158,
    'supported_sockets', jsonb_build_array('LGA1700', 'LGA1200', 'LGA1151', 'AM4', 'AM5'),
    'supportedSockets', jsonb_build_array('LGA1700', 'LGA1200', 'LGA1151', 'AM4', 'AM5'),
    'sockets', jsonb_build_array('LGA1700', 'LGA1200', 'LGA1151', 'AM4', 'AM5'),
    'tdp', 150,
    'tdpRating', '150W',
    'fanSize', 120,
    'fanCount', 1,
    'noiseLevel', '27.5dB',
    'manufacturer', 'Cooler Master',
    'model', 'Hyper 212 RGB'
  )::text,
  (SELECT category_id FROM component_categories WHERE category_name = 'Cooling' LIMIT 1),
  'gaming',
  'in_stock'
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE component_name = 'Cooler Master Hyper 212 RGB CPU Air Cooler'
);

-- 9. GPU - AMD Radeon RX 6600 8GB (Alternative GPU)
INSERT INTO components (
  component_name,
  component_brand,
  component_price,
  component_description,
  compatibility_information,
  category_id,
  component_purpose,
  availability_status
)
SELECT 
  'AMD Radeon RX 6600 8GB GDDR6',
  'AMD',
  18995.00, -- SRP: ₱18,995
  '8GB GDDR6 VRAM, 1792 stream processors. Great value for 1080p gaming with AMD FSR support.',
  jsonb_build_object(
    'vram', 8,
    'memoryType', 'GDDR6',
    'streamProcessors', 1792,
    'boostClock', '2491MHz',
    'tdp', 132,
    'tdpRating', '132W',
    'powerRequirement', 132,
    'length', 242,
    'height', 112,
    'width', 40,
    'pcieVersion', '4.0',
    'manufacturer', 'AMD',
    'architecture', 'RDNA 2'
  )::text,
  (SELECT category_id FROM component_categories WHERE category_name = 'GPU' LIMIT 1),
  'gaming',
  'in_stock'
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE component_name = 'AMD Radeon RX 6600 8GB GDDR6'
);

-- 10. RAM - G.Skill Ripjaws V 32GB DDR4 3600MHz (High-end RAM)
INSERT INTO components (
  component_name,
  component_brand,
  component_price,
  component_description,
  compatibility_information,
  category_id,
  component_purpose,
  availability_status
)
SELECT 
  'G.Skill Ripjaws V 32GB (2x16GB) DDR4 3600MHz',
  'G.Skill',
  6995.00, -- SRP: ₱6,995
  '32GB dual-channel DDR4 memory kit, 3600MHz speed, optimized for high-performance gaming and content creation.',
  jsonb_build_object(
    'ram_type', 'DDR4',
    'memoryType', 'DDR4',
    'capacity', 32,
    'speed', 3600,
    'speedMhz', '3600MHz',
    'modules', 2,
    'sizePerModule', 16,
    'voltage', '1.35V',
    'casLatency', 18,
    'formFactor', 'DIMM',
    'manufacturer', 'G.Skill',
    'series', 'Ripjaws V'
  )::text,
  (SELECT category_id FROM component_categories WHERE category_name = 'RAM' LIMIT 1),
  'gaming',
  'in_stock'
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE component_name = 'G.Skill Ripjaws V 32GB (2x16GB) DDR4 3600MHz'
);

-- Summary of added components:
-- 1. Intel Core i5-12400F - ₱8,995
-- 2. NVIDIA RTX 4060 8GB - ₱24,995
-- 3. MSI B660M PRO-VDH DDR4 - ₱6,995
-- 4. Corsair Vengeance LPX 16GB DDR4 - ₱3,495
-- 5. Samsung 980 500GB NVMe - ₱3,295
-- 6. Corsair CV650 650W PSU - ₱3,995
-- 7. NZXT H510 Flow Case - ₱5,495
-- 8. Cooler Master Hyper 212 RGB - ₱2,295
-- 9. AMD RX 6600 8GB - ₱18,995
-- 10. G.Skill Ripjaws V 32GB DDR4 - ₱6,995
-- Total: ₱85,545

