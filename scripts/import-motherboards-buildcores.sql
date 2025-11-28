-- Import 20 Motherboard components from BuildCores OpenDB
-- Generated: 2025-11-28T15:30:58.180Z
-- Category: Motherboard (category_id: 2)
-- Total: 20 components
-- Schema matches: component_name, component_price, compatibility_information (jsonb), category_id, component_purpose, retailer_id
-- All components have default price of ₱4,000 to ensure they appear in the UI

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'Asus B760 M-AYW WIFI D4 DDR4 Micro ATX',
  4000,
  '{"socket":"LGA1700","cpuSocket":"LGA1700","formFactor":"Micro ATX","chipset":"Intel B760","memory":{"max":64,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","maxMemory":64,"memorySlots":2,"m2Slots":"4","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9ba45865ad0c3553df768"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9ba45865ad0c3553df769"}],"wifi":true,"manufacturer":"ASUS","color":["GREY","BLACK"]}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus B760 M-AYW WIFI D4 DDR4 Micro ATX')
);

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'Gigabyte GA-G41MT-S2PT Micro ATX LGA775',
  4000,
  '{"socket":"LGA775","cpuSocket":"LGA775","formFactor":"Micro ATX","chipset":"Intel G41","memory":{"max":8,"ram_type":"DDR3","slots":2},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","maxMemory":8,"memorySlots":2,"m2Slots":"0","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67d3100668a3131be6016a3c"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67d3100668a3131be6016a3d"}],"wifi":true,"manufacturer":"Gigabyte","color":[]}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte GA-G41MT-S2PT Micro ATX LGA775')
);

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'MSI B850 PRO B850M-VC WIFI6E AM5 DDR5 Micro ATX',
  4000,
  '{"socket":"AM5","cpuSocket":"AM5","formFactor":"Micro ATX","chipset":"AMD B850","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","maxMemory":256,"memorySlots":4,"m2Slots":"5","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":4,"lanes":16,"_id":"68cb89dc9b67bc35527b4c6b"}],"wifi":true,"manufacturer":"MSI","color":["BLACK"]}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI B850 PRO B850M-VC WIFI6E AM5 DDR5 Micro ATX')
);

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'Asus H81 H81M-C/CSM DDR3 Micro ATX',
  4000,
  '{"socket":"LGA1150","cpuSocket":"LGA1150","formFactor":"Micro ATX","chipset":"Intel H81","memory":{"max":16,"ram_type":"DDR3","slots":2},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","maxMemory":16,"memorySlots":2,"m2Slots":"0","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9bb85865ad0c3553e19f3"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9bb85865ad0c3553e19f4"}],"wifi":true,"manufacturer":"ASUS","color":["BLACK","GOLD"]}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus H81 H81M-C/CSM DDR3 Micro ATX')
);

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'Gigabyte Z68 GA-Z68MA-D2H-B3 DDR3 Micro ATX',
  4000,
  '{"socket":"LGA1155","cpuSocket":"LGA1155","formFactor":"Micro ATX","chipset":"Intel Z68","memory":{"max":32,"ram_type":"DDR3","slots":4},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","maxMemory":32,"memorySlots":4,"m2Slots":"0","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9b9c7865ad0c3553de99a"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9b9c7865ad0c3553de99b"}],"wifi":true,"manufacturer":"Gigabyte","color":["BLUE","WHITE"]}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte Z68 GA-Z68MA-D2H-B3 DDR3 Micro ATX')
);

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'Asus P55 P7P55D-E LX LGA1156 DDR3 ATX',
  4000,
  '{"socket":"LGA1156","cpuSocket":"LGA1156","formFactor":"ATX","chipset":"Intel P55","memory":{"max":16,"ram_type":"DDR3","slots":4},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","maxMemory":16,"memorySlots":4,"m2Slots":"0","sataPorts":"8","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b6ec865ad0c3553d98dd"},{"gen":"4.0","quantity":4,"lanes":1,"_id":"67f9b6ec865ad0c3553d98de"}],"wifi":true,"manufacturer":"ASUS","color":["BLUE","WHITE"]}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus P55 P7P55D-E LX LGA1156 DDR3 ATX')
);

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'Gigabyte B860M AORUS ELITE WIFI6E DDR5 Micro ATX',
  4000,
  '{"socket":"LGA1851","cpuSocket":"LGA1851","formFactor":"Micro ATX","chipset":"Intel B860","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","maxMemory":256,"memorySlots":4,"m2Slots":"4","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9baef865ad0c3553e09c8"}],"wifi":true,"manufacturer":"Gigabyte","color":["BLACK"]}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte B860M AORUS ELITE WIFI6E DDR5 Micro ATX')
);

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'Biostar B560 M-SILVER LGA1200 DDR4 Micro ATX',
  4000,
  '{"socket":"LGA1200","cpuSocket":"LGA1200","formFactor":"Micro ATX","chipset":"Intel B560","memory":{"max":128,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","maxMemory":128,"memorySlots":4,"m2Slots":"4","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b896865ad0c3553dc757"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9b896865ad0c3553dc758"}],"wifi":true,"manufacturer":"Biostar","color":["GREY","BLACK"]}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Biostar B560 M-SILVER LGA1200 DDR4 Micro ATX')
);

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'ASRock H410 M/ac DDR4 Micro ATX',
  4000,
  '{"socket":"LGA1200","cpuSocket":"LGA1200","formFactor":"Micro ATX","chipset":"Intel H410","memory":{"max":64,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","maxMemory":64,"memorySlots":2,"m2Slots":"2","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b9b2865ad0c3553de73a"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9b9b2865ad0c3553de73b"}],"wifi":true,"manufacturer":"ASRock","color":["BLACK"]}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock H410 M/ac DDR4 Micro ATX')
);

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'ECS H81 H81H3-TI2 LGA1150 DDR3 Thin Mini ITX',
  4000,
  '{"socket":"LGA1150","cpuSocket":"LGA1150","formFactor":"Thin Mini-ITX","chipset":"Intel H81","memory":{"max":8,"ram_type":"DDR3","slots":1},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","maxMemory":8,"memorySlots":1,"m2Slots":"0","sataPorts":"2","pcieSlots":[],"wifi":true,"manufacturer":"ECS","color":["BLACK"]}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ECS H81 H81H3-TI2 LGA1150 DDR3 Thin Mini ITX')
);

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'ASUS H310 PRIME H310M-R R2.0 LGA1151 DDR4 Micro ATX',
  4000,
  '{"socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"Micro ATX","chipset":"Intel H310","memory":{"max":32,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","maxMemory":32,"memorySlots":2,"m2Slots":"0","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9bad2865ad0c3553e06f0"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9bad2865ad0c3553e06f1"}],"wifi":true,"manufacturer":"ASUS","color":["BLACK"]}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASUS H310 PRIME H310M-R R2.0 LGA1151 DDR4 Micro ATX')
);

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'ASRock B560M Pro4 LGA1200 DDR4 Micro ATX',
  4000,
  '{"socket":"LGA1200","cpuSocket":"LGA1200","formFactor":"Micro ATX","chipset":"Intel B560","memory":{"max":128,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","maxMemory":128,"memorySlots":4,"m2Slots":"4","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b74b865ad0c3553da365"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9b74b865ad0c3553da366"}],"wifi":true,"manufacturer":"ASRock","color":["GREY","BLACK"]}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock B560M Pro4 LGA1200 DDR4 Micro ATX')
);

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'MSI A320M PRO-VD PLUS AM4 DDR4 Micro ATX',
  4000,
  '{"socket":"AM4","cpuSocket":"AM4","formFactor":"Micro ATX","chipset":"AMD A320","memory":{"max":32,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","maxMemory":32,"memorySlots":2,"m2Slots":"0","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9bb2c865ad0c3553e1094"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9bb2c865ad0c3553e1095"}],"wifi":true,"manufacturer":"MSI","color":["BROWN","BLACK"]}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI A320M PRO-VD PLUS AM4 DDR4 Micro ATX')
);

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'Supermicro Intel C612 X10SRM-F LGA2011-3 Narrow DDR4 Micro ATX',
  4000,
  '{"socket":"LGA2011-3 Narrow","cpuSocket":"LGA2011-3 Narrow","formFactor":"Micro ATX","chipset":"Intel C612","memory":{"max":512,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","maxMemory":512,"memorySlots":4,"m2Slots":"2","sataPorts":"10","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b80f865ad0c3553db8b9"},{"gen":"4.0","quantity":2,"lanes":8,"_id":"67f9b80f865ad0c3553db8ba"}],"wifi":true,"manufacturer":"Supermicro","color":["BLACK","GREEN"]}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Supermicro Intel C612 X10SRM-F LGA2011-3 Narrow DDR4 Micro ATX')
);

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'ASRock B850 Pro RS WiFi AM5 DDR5 ATX',
  4000,
  '{"socket":"AM5","cpuSocket":"AM5","formFactor":"ATX","chipset":"AMD B850","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","maxMemory":256,"memorySlots":4,"m2Slots":"6","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9ba01865ad0c3553defe6"}],"wifi":true,"manufacturer":"ASRock","color":["GREY","BLACK"]}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock B850 Pro RS WiFi AM5 DDR5 ATX')
);

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'ASRock B860 Lightning WiFi DDR5 ATX',
  4000,
  '{"socket":"LGA1851","cpuSocket":"LGA1851","formFactor":"ATX","chipset":"Intel B860","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","maxMemory":256,"memorySlots":4,"m2Slots":"6","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b941865ad0c3553ddad7"}],"wifi":true,"manufacturer":"ASRock","color":["BLACK"]}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock B860 Lightning WiFi DDR5 ATX')
);

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'ASUS X870 MAX GAMING WIFI7 W DDR5 ATX',
  4000,
  '{"socket":"AM5","cpuSocket":"AM5","formFactor":"ATX","chipset":"AMD X870","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","maxMemory":256,"memorySlots":4,"m2Slots":"4","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":4,"lanes":16,"_id":"688ec9013ebf909c29b7bca3"}],"wifi":true,"manufacturer":"ASUS","color":["WHITE"]}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASUS X870 MAX GAMING WIFI7 W DDR5 ATX')
);

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'MSI B550 A PRO (CEC) AM4 DDR4 ATX',
  4000,
  '{"socket":"AM4","cpuSocket":"AM4","formFactor":"ATX","chipset":"AMD B550","memory":{"max":128,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","maxMemory":128,"memorySlots":4,"m2Slots":"4","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":4,"lanes":16,"_id":"67f9bb3f865ad0c3553e127e"}],"wifi":true,"manufacturer":"MSI","color":["BLACK"]}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI B550 A PRO (CEC) AM4 DDR4 ATX')
);

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'MSI B450-A PRO MAX',
  4000,
  '{"socket":"AM4","cpuSocket":"AM4","formFactor":"ATX","chipset":"AMD B450","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","maxMemory":64,"memorySlots":4,"m2Slots":"1","sataPorts":"6","pcieSlots":[{"gen":"3.0","quantity":2,"lanes":16,"_id":"67789fc43a92e47ebc980d1e"},{"gen":"2.0","quantity":1,"lanes":16,"_id":"67789fc43a92e47ebc980d1f"},{"gen":"2.0","quantity":4,"lanes":1,"_id":"67789fc43a92e47ebc980d20"}],"wifi":true,"manufacturer":"MSI","color":[]}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI B450-A PRO MAX')
);

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'Gigabyte X299 AORUS Gaming 3 Pro LGA2066 DDR4 ATX',
  4000,
  '{"socket":"LGA2066","cpuSocket":"LGA2066","formFactor":"ATX","chipset":"Intel X299","memory":{"max":128,"ram_type":"DDR4","slots":8},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","maxMemory":128,"memorySlots":8,"m2Slots":"4","sataPorts":"8","pcieSlots":[{"gen":"4.0","quantity":5,"lanes":16,"_id":"67f9b771865ad0c3553da7a9"}],"wifi":true,"manufacturer":"Gigabyte","color":["BLACK"]}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte X299 AORUS Gaming 3 Pro LGA2066 DDR4 ATX')
);

-- Summary:
-- Motherboard: 20 imported, 0 skipped
