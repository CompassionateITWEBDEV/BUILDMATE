-- Import 20 components per category from BuildCores OpenDB
-- Generated: 2025-11-28T14:47:35.337Z
-- Total: 160 components
-- Schema matches: component_name, component_price, compatibility_information (jsonb), category_id, component_purpose, retailer_id

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'Intel Xeon E5 1650 V3 OEM/Tray 3.5 GHz 6-Core LGA2011-3',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011-3","cpuSocket":"LGA2011-3","tdp":null,"tdpRating":null,"cores":6,"threads":12,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E5 1650 V3 OEM/Tray 3.5 GHz 6-Core LGA2011-3')
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
  'Intel Xeon E3 1245 V5 OEM/Tray 3.5 GHz 4-Core LGA1151',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E3 1245 V5 OEM/Tray 3.5 GHz 4-Core LGA1151')
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
  'Intel Xeon E5 2660 V4 2 GHz 14-Core LGA2011-3',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011-3","cpuSocket":"LGA2011-3","tdp":null,"tdpRating":null,"cores":14,"threads":28,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E5 2660 V4 2 GHz 14-Core LGA2011-3')
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
  'Intel Core i5 6400T 2.2 GHz 4-Core LGA1151 OEM/Tray',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i5 6400T 2.2 GHz 4-Core LGA1151 OEM/Tray')
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
  'Intel Core i9 13900T 1.1 GHz 24-Core LGA1700 OEM/Tray',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1700","cpuSocket":"LGA1700","tdp":null,"tdpRating":null,"cores":24,"threads":32,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i9 13900T 1.1 GHz 24-Core LGA1700 OEM/Tray')
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
  'Intel Core i5 7600T 2.8 GHz 4-Core LGA1151',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i5 7600T 2.8 GHz 4-Core LGA1151')
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
  'Intel Core i5 14400F 2.5 GHz 10-Core LGA1700',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1700","cpuSocket":"LGA1700","tdp":null,"tdpRating":null,"cores":10,"threads":16,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i5 14400F 2.5 GHz 10-Core LGA1700')
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
  'Intel Core i7 7700K 4.2 GHz 4-Core LGA1151',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i7 7700K 4.2 GHz 4-Core LGA1151')
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
  'AMD Threadripper 1900X 3.8 GHz 8-Core sTR4',
  5000,
  '{"manufacturer":"AMD","socket":"TR4","cpuSocket":"TR4","tdp":null,"tdpRating":null,"cores":8,"threads":16,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD Threadripper 1900X 3.8 GHz 8-Core sTR4')
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
  'Intel Core i7 Extreme 6950X 3 GHz 10-Core LGA2011-3',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011-3","cpuSocket":"LGA2011-3","tdp":null,"tdpRating":null,"cores":10,"threads":20,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i7 Extreme 6950X 3 GHz 10-Core LGA2011-3')
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
  'Intel Xeon E 2136 3.3 GHz 6-Core LGA1151',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":6,"threads":12,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E 2136 3.3 GHz 6-Core LGA1151')
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
  'AMD A6 7470K 3.7 GHz 2-Core FM2+ OEM/Tray',
  5000,
  '{"manufacturer":"AMD","socket":"FM2+","cpuSocket":"FM2+","tdp":null,"tdpRating":null,"cores":2,"threads":2,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD A6 7470K 3.7 GHz 2-Core FM2+ OEM/Tray')
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
  'AMD Opteron 6344 2.6 GHz 12-Core G34 OEM/Tray',
  5000,
  '{"manufacturer":"AMD","socket":"G34","cpuSocket":"G34","tdp":null,"tdpRating":null,"cores":12,"threads":12,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD Opteron 6344 2.6 GHz 12-Core G34 OEM/Tray')
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
  'AMD A8 7670K 3.6 GHz 4-Core FM2+',
  5000,
  '{"manufacturer":"AMD","socket":"FM2+","cpuSocket":"FM2+","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD A8 7670K 3.6 GHz 4-Core FM2+')
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
  'Intel Core i5 4460S 2.9 GHz 4-Core LGA1150',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1150","cpuSocket":"LGA1150","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i5 4460S 2.9 GHz 4-Core LGA1150')
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
  'Intel Core i9 13900K 3.0 GHz 24-Core LGA1700',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1700","cpuSocket":"LGA1700","tdp":null,"tdpRating":null,"cores":24,"threads":32,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i9 13900K 3.0 GHz 24-Core LGA1700')
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
  'Intel Core i5 3570S 3.1 GHz 4-Core LGA1155 OEM/Tray',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1155","cpuSocket":"LGA1155","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i5 3570S 3.1 GHz 4-Core LGA1155 OEM/Tray')
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
  'AMD Ryzen 5 5600 3.5 GHz 6-Core AM4',
  5000,
  '{"manufacturer":"AMD","socket":"AM4","cpuSocket":"AM4","tdp":null,"tdpRating":null,"cores":6,"threads":12,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD Ryzen 5 5600 3.5 GHz 6-Core AM4')
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
  'Intel Core i5 8400 2.8 GHz 6-Core LGA1151',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":6,"threads":6,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i5 8400 2.8 GHz 6-Core LGA1151')
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
  'Intel Core i7 4930K 3.4 GHz 6-Core LGA2011',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011","cpuSocket":"LGA2011","tdp":null,"tdpRating":null,"cores":6,"threads":12,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i7 4930K 3.4 GHz 6-Core LGA2011')
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
  'Asus B760 M-AYW WIFI D4 DDR4 Micro ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1700","cpuSocket":"LGA1700","formFactor":"Micro ATX","chipset":"Intel B760","memory":{"max":64,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9ba45865ad0c3553df768"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9ba45865ad0c3553df769"}],"wifi":true}'::jsonb,
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
  '{"manufacturer":"Gigabyte","socket":"LGA775","cpuSocket":"LGA775","formFactor":"Micro ATX","chipset":"Intel G41","memory":{"max":8,"ram_type":"DDR3","slots":2},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"0","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67d3100668a3131be6016a3c"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67d3100668a3131be6016a3d"}],"wifi":false}'::jsonb,
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
  '{"manufacturer":"MSI","socket":"AM5","cpuSocket":"AM5","formFactor":"Micro ATX","chipset":"AMD B850","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"5","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":4,"lanes":16,"_id":"68cb89dc9b67bc35527b4c6b"}],"wifi":true}'::jsonb,
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
  '{"manufacturer":"ASUS","socket":"LGA1150","cpuSocket":"LGA1150","formFactor":"Micro ATX","chipset":"Intel H81","memory":{"max":16,"ram_type":"DDR3","slots":2},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"0","sataPorts":"2","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9bb85865ad0c3553e19f3"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9bb85865ad0c3553e19f4"}],"wifi":false}'::jsonb,
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
  '{"manufacturer":"Gigabyte","socket":"LGA1155","cpuSocket":"LGA1155","formFactor":"Micro ATX","chipset":"Intel Z68","memory":{"max":32,"ram_type":"DDR3","slots":4},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"0","sataPorts":"2","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9b9c7865ad0c3553de99a"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9b9c7865ad0c3553de99b"}],"wifi":false}'::jsonb,
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
  '{"manufacturer":"ASUS","socket":"LGA1156","cpuSocket":"LGA1156","formFactor":"ATX","chipset":"Intel P55","memory":{"max":16,"ram_type":"DDR3","slots":4},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"0","sataPorts":"2","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b6ec865ad0c3553d98dd"},{"gen":"4.0","quantity":4,"lanes":1,"_id":"67f9b6ec865ad0c3553d98de"}],"wifi":false}'::jsonb,
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
  '{"manufacturer":"Gigabyte","socket":"LGA1851","cpuSocket":"LGA1851","formFactor":"Micro ATX","chipset":"Intel B860","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"4","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9baef865ad0c3553e09c8"}],"wifi":true}'::jsonb,
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
  '{"manufacturer":"Biostar","socket":"LGA1200","cpuSocket":"LGA1200","formFactor":"Micro ATX","chipset":"Intel B560","memory":{"max":128,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b896865ad0c3553dc757"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9b896865ad0c3553dc758"}],"wifi":false}'::jsonb,
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
  '{"manufacturer":"ASRock","socket":"LGA1200","cpuSocket":"LGA1200","formFactor":"Micro ATX","chipset":"Intel H410","memory":{"max":64,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b9b2865ad0c3553de73a"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9b9b2865ad0c3553de73b"}],"wifi":false}'::jsonb,
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
  '{"manufacturer":"ECS","socket":"LGA1150","cpuSocket":"LGA1150","formFactor":"Thin Mini-ITX","chipset":"Intel H81","memory":{"max":8,"ram_type":"DDR3","slots":1},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"0","sataPorts":"1","pcieSlots":[],"wifi":false}'::jsonb,
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
  '{"manufacturer":"ASUS","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"Micro ATX","chipset":"Intel H310","memory":{"max":32,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"0","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9bad2865ad0c3553e06f0"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9bad2865ad0c3553e06f1"}],"wifi":false}'::jsonb,
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
  '{"manufacturer":"ASRock","socket":"LGA1200","cpuSocket":"LGA1200","formFactor":"Micro ATX","chipset":"Intel B560","memory":{"max":128,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b74b865ad0c3553da365"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9b74b865ad0c3553da366"}],"wifi":false}'::jsonb,
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
  '{"manufacturer":"MSI","socket":"AM4","cpuSocket":"AM4","formFactor":"Micro ATX","chipset":"AMD A320","memory":{"max":32,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"0","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9bb2c865ad0c3553e1094"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9bb2c865ad0c3553e1095"}],"wifi":false}'::jsonb,
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
  '{"manufacturer":"Supermicro","socket":"LGA2011-3 Narrow","cpuSocket":"LGA2011-3 Narrow","formFactor":"Micro ATX","chipset":"Intel C612","memory":{"max":512,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"10","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b80f865ad0c3553db8b9"},{"gen":"4.0","quantity":2,"lanes":8,"_id":"67f9b80f865ad0c3553db8ba"}],"wifi":false}'::jsonb,
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
  '{"manufacturer":"ASRock","socket":"AM5","cpuSocket":"AM5","formFactor":"ATX","chipset":"AMD B850","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"6","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9ba01865ad0c3553defe6"}],"wifi":true}'::jsonb,
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
  '{"manufacturer":"ASRock","socket":"LGA1851","cpuSocket":"LGA1851","formFactor":"ATX","chipset":"Intel B860","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"6","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b941865ad0c3553ddad7"}],"wifi":true}'::jsonb,
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
  '{"manufacturer":"ASUS","socket":"AM5","cpuSocket":"AM5","formFactor":"ATX","chipset":"AMD X870","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"4","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":4,"lanes":16,"_id":"688ec9013ebf909c29b7bca3"}],"wifi":true}'::jsonb,
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
  '{"manufacturer":"MSI","socket":"AM4","cpuSocket":"AM4","formFactor":"ATX","chipset":"AMD B550","memory":{"max":128,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":4,"lanes":16,"_id":"67f9bb3f865ad0c3553e127e"}],"wifi":false}'::jsonb,
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
  '{"manufacturer":"MSI","socket":"AM4","cpuSocket":"AM4","formFactor":"ATX","chipset":"AMD B450","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"1","sataPorts":"6","pcieSlots":[{"gen":"3.0","quantity":2,"lanes":16,"_id":"67789fc43a92e47ebc980d1e"},{"gen":"2.0","quantity":1,"lanes":16,"_id":"67789fc43a92e47ebc980d1f"},{"gen":"2.0","quantity":4,"lanes":1,"_id":"67789fc43a92e47ebc980d20"}],"wifi":false}'::jsonb,
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
  '{"manufacturer":"Gigabyte","socket":"LGA2066","cpuSocket":"LGA2066","formFactor":"ATX","chipset":"Intel X299","memory":{"max":128,"ram_type":"DDR4","slots":8},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"8","pcieSlots":[{"gen":"4.0","quantity":5,"lanes":16,"_id":"67f9b771865ad0c3553da7a9"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte X299 AORUS Gaming 3 Pro LGA2066 DDR4 ATX')
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
  'TEAMGROUP T-Create Expert Black / Gold DDR5-6400 CL32 48GB (2x24GB)',
  2000,
  '{"manufacturer":"TEAMGROUP","memoryType":"DDR4","ram_type":"DDR4","capacity":48,"speed":"6400","speedMhz":"6400","modules":{"quantity":2,"capacity_gb":24},"casLatency":32}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('TEAMGROUP T-Create Expert Black / Gold DDR5-6400 CL32 48GB (2x24GB)')
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
  'TEAMGROUP T-Force Xtreem Pink DDR5-6800 CL34 48GB (2x24GB)',
  2000,
  '{"manufacturer":"TEAMGROUP","memoryType":"DDR4","ram_type":"DDR4","capacity":48,"speed":"6800","speedMhz":"6800","modules":{"quantity":2,"capacity_gb":24},"casLatency":34}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('TEAMGROUP T-Force Xtreem Pink DDR5-6800 CL34 48GB (2x24GB)')
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
  'Crucial CP2K64G56C46U5 Black DDR5-5600 CL46 128GB (2x64GB)',
  2000,
  '{"manufacturer":"Crucial","memoryType":"DDR4","ram_type":"DDR4","capacity":128,"speed":"5600","speedMhz":"5600","modules":{"quantity":2,"capacity_gb":64},"casLatency":46}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Crucial CP2K64G56C46U5 Black DDR5-5600 CL46 128GB (2x64GB)')
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
  'TEAMGROUP T-Force Delta RGB DDR4 16GB (1x16GB) 2666MHz CL16 WHITE',
  2000,
  '{"manufacturer":"TEAMGROUP","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"2666","speedMhz":"2666","modules":{"quantity":1,"capacity_gb":16},"casLatency":16}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('TEAMGROUP T-Force Delta RGB DDR4 16GB (1x16GB) 2666MHz CL16 WHITE')
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
  'Silicon Power XPOWER Storm RGB Black DDR5-7600 CL36 32GB (1x32GB)',
  2000,
  '{"manufacturer":"Silicon Power","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"7600","speedMhz":"7600","modules":{"quantity":1,"capacity_gb":32},"casLatency":36}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silicon Power XPOWER Storm RGB Black DDR5-7600 CL36 32GB (1x32GB)')
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
  'Lexar Hades OC Gray / Black DDR4-3200 CL18 16GB (1x16GB)',
  2000,
  '{"manufacturer":"Lexar","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"3200","speedMhz":"3200","modules":{"quantity":1,"capacity_gb":16},"casLatency":18}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Lexar Hades OC Gray / Black DDR4-3200 CL18 16GB (1x16GB)')
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
  'ADATA XPG LANCER RGB ROG CERTIFIED Black DDR5-7200 CL34 48GB (2x24GB)',
  2000,
  '{"manufacturer":"ADATA","memoryType":"DDR4","ram_type":"DDR4","capacity":48,"speed":"7200","speedMhz":"7200","modules":{"quantity":2,"capacity_gb":24},"casLatency":34}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ADATA XPG LANCER RGB ROG CERTIFIED Black DDR5-7200 CL34 48GB (2x24GB)')
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
  'TEAMGROUP T-Force Delta RGB Black DDR4-3200 CL16 32GB (2x16GB)',
  2000,
  '{"manufacturer":"TEAMGROUP","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"3200","speedMhz":"3200","modules":{"quantity":2,"capacity_gb":16},"casLatency":16}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('TEAMGROUP T-Force Delta RGB Black DDR4-3200 CL16 32GB (2x16GB)')
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
  'TEAMGROUP T-Create Expert Gray DDR4-3200 CL16 16GB (2x8GB)',
  2000,
  '{"manufacturer":"TEAMGROUP","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"3200","speedMhz":"3200","modules":{"quantity":2,"capacity_gb":8},"casLatency":16}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('TEAMGROUP T-Create Expert Gray DDR4-3200 CL16 16GB (2x8GB)')
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
  'Crucial Ballistix Sport Gray / Silver DDR4-2400 CL16 8GB (1x8GB)',
  2000,
  '{"manufacturer":"Crucial","memoryType":"DDR4","ram_type":"DDR4","capacity":8,"speed":"2400","speedMhz":"2400","modules":{"quantity":1,"capacity_gb":8},"casLatency":16}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Crucial Ballistix Sport Gray / Silver DDR4-2400 CL16 8GB (1x8GB)')
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
  'ADATA XPG LANCER RGB Black DDR5-5200 CL38 32GB (2x16GB)',
  2000,
  '{"manufacturer":"ADATA","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"5200","speedMhz":"5200","modules":{"quantity":2,"capacity_gb":16},"casLatency":38}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ADATA XPG LANCER RGB Black DDR5-5200 CL38 32GB (2x16GB)')
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
  'G.Skill Ripjaws S5 Black DDR5-6000 CL40 48GB (2x24GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":48,"speed":"6000","speedMhz":"6000","modules":{"quantity":2,"capacity_gb":24},"casLatency":40}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill Ripjaws S5 Black DDR5-6000 CL40 48GB (2x24GB)')
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
  'TEAMGROUP T-Create Expert Black DDR5-7200 CL34 32GB (2x16GB)',
  2000,
  '{"manufacturer":"TEAMGROUP","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"7200","speedMhz":"7200","modules":{"quantity":2,"capacity_gb":16},"casLatency":34}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('TEAMGROUP T-Create Expert Black DDR5-7200 CL34 32GB (2x16GB)')
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
  'G.Skill Trident Z White / Black DDR5-5600 CL30 64GB (2x32GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":64,"speed":"5600","speedMhz":"5600","modules":{"quantity":2,"capacity_gb":32},"casLatency":30}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill Trident Z White / Black DDR5-5600 CL30 64GB (2x32GB)')
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
  'G.Skill Trident Z5 RGB Black DDR5-6000 CL36 32GB (2x16GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6000","speedMhz":"6000","modules":{"quantity":2,"capacity_gb":16},"casLatency":36}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill Trident Z5 RGB Black DDR5-6000 CL36 32GB (2x16GB)')
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
  'GeIL EVO V RGB Black DDR5-6800 CL36 96GB (2x48GB)',
  2000,
  '{"manufacturer":"GeIL","memoryType":"DDR4","ram_type":"DDR4","capacity":96,"speed":"6800","speedMhz":"6800","modules":{"quantity":2,"capacity_gb":48},"casLatency":36}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('GeIL EVO V RGB Black DDR5-6800 CL36 96GB (2x48GB)')
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
  'Timetec PINNACLE Konduit RGB DDR4-3600 CL18 16GB (1x16GB)',
  2000,
  '{"manufacturer":"Timetec","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"3600","speedMhz":"3600","modules":{"quantity":1,"capacity_gb":16},"casLatency":18}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Timetec PINNACLE Konduit RGB DDR4-3600 CL18 16GB (1x16GB)')
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
  'TEAMGROUP Elite Plus Silver DDR5-5600 CL40 16GB (1x16GB)',
  2000,
  '{"manufacturer":"TEAMGROUP","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"5600","speedMhz":"5600","modules":{"quantity":1,"capacity_gb":16},"casLatency":40}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('TEAMGROUP Elite Plus Silver DDR5-5600 CL40 16GB (1x16GB)')
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
  'Corsair Dominator Platinum RGB Gray / Black DDR5-6000 CL30 32GB (2x16GB)',
  2000,
  '{"manufacturer":"Corsair","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6000","speedMhz":"6000","modules":{"quantity":2,"capacity_gb":16},"casLatency":30}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Dominator Platinum RGB Gray / Black DDR5-6000 CL30 32GB (2x16GB)')
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
  'Corsair Vengeance RGB Black / Gray DDR5-6600 CL32 64GB (4x16GB)',
  2000,
  '{"manufacturer":"Corsair","memoryType":"DDR4","ram_type":"DDR4","capacity":64,"speed":"6600","speedMhz":"6600","modules":{"quantity":4,"capacity_gb":16},"casLatency":32}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Vengeance RGB Black / Gray DDR5-6600 CL32 64GB (4x16GB)')
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
  'Inland Premium 512GB SSD M.2 2280 PCIe NVMe 3.0 x4 3D NAND Internal Solid State Drive, High-Speed Read/Write Speed up to 3100 MBps and 1900 MBps, N...',
  3000,
  '{"manufacturer":"Inland","interface":"PCIe Gen 3 x 4","capacity":512,"capacityGB":"512GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Inland Premium 512GB SSD M.2 2280 PCIe NVMe 3.0 x4 3D NAND Internal Solid State Drive, High-Speed Read/Write Speed up to 3100 MBps and 1900 MBps, N...')
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
  'MSI SPATIUM M480 HS 1TB SSD M.2-2280 PCIe 4.0 X4 NVMe',
  3000,
  '{"manufacturer":"MSI","interface":"M.2 PCIe 4.0 X4","capacity":1000,"capacityGB":"1000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI SPATIUM M480 HS 1TB SSD M.2-2280 PCIe 4.0 X4 NVMe')
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
  'OWC Aura Ultra IV 8TB SSD M.2-2280 PCIe 4.0 x4 NVMe',
  3000,
  '{"manufacturer":"OWC","interface":"M.2 PCIe 4.0 X4","capacity":8000,"capacityGB":"8000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('OWC Aura Ultra IV 8TB SSD M.2-2280 PCIe 4.0 x4 NVMe')
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
  'Seagate Barracuda Compute 2TB 3.5" HDD 5400RPM SATA 6.0 Gb/s',
  3000,
  '{"manufacturer":"Seagate","interface":"SATA 6.0 Gb/s","capacity":2000,"capacityGB":"2000GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Seagate Barracuda Compute 2TB 3.5" HDD 5400RPM SATA 6.0 Gb/s')
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
  'Western Digital Blue 250GB SSD M.2-2280 SATA',
  3000,
  '{"manufacturer":"Western Digital","interface":"M.2 SATA","capacity":250,"capacityGB":"250GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Western Digital Blue 250GB SSD M.2-2280 SATA')
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
  'Crucial T705 1TB PCIe Gen5 NVMe M.2 SSD with Heatsink',
  3000,
  '{"manufacturer":"Crucial","interface":"PCIe 5.0 X4","capacity":1000,"capacityGB":"1000GB","formFactor":"M.2","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Crucial T705 1TB PCIe Gen5 NVMe M.2 SSD with Heatsink')
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
  'FFF Smart Life Connected G-Storategy NV470 w/Heatsink 2TB SSD M.2-2280 PCIe 4.0 X4 NVMe',
  3000,
  '{"manufacturer":"FFF Smart Life Connected","interface":"M.2 PCIe 4.0 X4","capacity":2000,"capacityGB":"2000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('FFF Smart Life Connected G-Storategy NV470 w/Heatsink 2TB SSD M.2-2280 PCIe 4.0 X4 NVMe')
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
  'Seagate IronWolf Pro 8TB HDD 7200RPM 3.5" SATA Internal',
  3000,
  '{"manufacturer":"Seagate","interface":"SATA 6.0 Gb/s","capacity":8000,"capacityGB":"8000GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Seagate IronWolf Pro 8TB HDD 7200RPM 3.5" SATA Internal')
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
  'Western Digital Purple Pro 12TB HDD 3.5" SATA',
  3000,
  '{"manufacturer":"Western Digital","interface":"SATA 6.0 Gb/s","capacity":12000,"capacityGB":"12000GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Western Digital Purple Pro 12TB HDD 3.5" SATA')
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
  'PNY CS2140 2TB SSD M.2-2280 PCIe 4.0 x4 NVMe',
  3000,
  '{"manufacturer":"PNY","interface":"M.2 PCIe 4.0 X4","capacity":2000,"capacityGB":"2000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('PNY CS2140 2TB SSD M.2-2280 PCIe 4.0 x4 NVMe')
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
  'TEAMGROUP GX1 480GB SSD 2.5" SATA',
  3000,
  '{"manufacturer":"TEAMGROUP","interface":"SATA 6.0 Gb/s","capacity":480,"capacityGB":"480GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('TEAMGROUP GX1 480GB SSD 2.5" SATA')
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
  'Crucial P310 1TB SSD M.2 PCIe 4.0 NVMe',
  3000,
  '{"manufacturer":"Crucial","interface":"M.2 PCIe 4.0 X4","capacity":1000,"capacityGB":"1000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Crucial P310 1TB SSD M.2 PCIe 4.0 NVMe')
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
  'AMD RADEON-R7SSD-240G 240 GB SSD 2.5" SATA 6.0 Gb/s',
  3000,
  '{"manufacturer":"AMD","interface":"SATA 6.0 Gb/s","capacity":240,"capacityGB":"240GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD RADEON-R7SSD-240G 240 GB SSD 2.5" SATA 6.0 Gb/s')
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
  'Lexar NM600 240GB M.2-2280 SSD PCIe 3.0 x4 NVMe',
  3000,
  '{"manufacturer":"Lexar","interface":"M.2 PCIe 3.0 X4","capacity":240,"capacityGB":"240GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Lexar NM600 240GB M.2-2280 SSD PCIe 3.0 x4 NVMe')
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
  'ADATA LEGEND 970 2TB SSD M.2-2280 PCIe 5.0 X4 NVMe',
  3000,
  '{"manufacturer":"ADATA","interface":"M.2 PCIe 5.0 X4","capacity":2000,"capacityGB":"2000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ADATA LEGEND 970 2TB SSD M.2-2280 PCIe 5.0 X4 NVMe')
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
  'Seagate ST6000NM0104 6TB 3.5" HDD 7200RPM SATA 6.0 Gb/s',
  3000,
  '{"manufacturer":"Seagate","interface":"SATA 6.0 Gb/s","capacity":6000,"capacityGB":"6000GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Seagate ST6000NM0104 6TB 3.5" HDD 7200RPM SATA 6.0 Gb/s')
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
  'Western Digital Green 120GB SSD 2.5" SATA',
  3000,
  '{"manufacturer":"Western Digital","interface":"SATA 6.0 Gb/s","capacity":120,"capacityGB":"120GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Western Digital Green 120GB SSD 2.5" SATA')
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
  'Western Digital PC SN730 256GB SSD M.2-2280 PCIe 3.0 X4 NVMe',
  3000,
  '{"manufacturer":"Western Digital","interface":"M.2 PCIe 3.0 X4","capacity":256,"capacityGB":"256GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Western Digital PC SN730 256GB SSD M.2-2280 PCIe 3.0 X4 NVMe')
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
  'TEAMGROUP Cardea A440 2TB M.2-2280 SSD PCIe 4.0 X4 NVMe',
  3000,
  '{"manufacturer":"TEAMGROUP","interface":"M.2 PCIe 4.0 X4","capacity":2000,"capacityGB":"2000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('TEAMGROUP Cardea A440 2TB M.2-2280 SSD PCIe 4.0 X4 NVMe')
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
  'Kingston NV1 1TB M.2-2280 SSD PCIe 3.0 x4 NVMe',
  3000,
  '{"manufacturer":"Kingston","interface":"M.2 PCIe 3.0 X4","capacity":1000,"capacityGB":"1000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston NV1 1TB M.2-2280 SSD PCIe 3.0 x4 NVMe')
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
  'Asus ROG STRIX Radeon RX 570 4GB GDDR5 Black',
  15000,
  '{"manufacturer":"Asus","memory":4,"vram":4,"memoryType":"GDDR5","powerRequirement":150,"tdp":150,"tdpRating":"150W","length":240,"width":null,"height":null,"dimensions":{"length":240,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus ROG STRIX Radeon RX 570 4GB GDDR5 Black')
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
  'Radeon RX 570 ARMOR MK2 8G OC',
  15000,
  '{"manufacturer":"MSI","memory":8,"vram":8,"memoryType":"GDDR5","powerRequirement":150,"tdp":150,"tdpRating":"150W","length":270,"width":null,"height":null,"dimensions":{"length":270,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Radeon RX 570 ARMOR MK2 8G OC')
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
  'MSI VENTUS 2X OC GeForce RTX 4070 12GB GDDR6 White / Silver',
  15000,
  '{"manufacturer":"MSI","memory":12,"vram":12,"memoryType":"GDDR6","powerRequirement":200,"tdp":200,"tdpRating":"200W","length":242,"width":null,"height":null,"dimensions":{"length":242,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI VENTUS 2X OC GeForce RTX 4070 12GB GDDR6 White / Silver')
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
  'EVGA XC ULTRA GAMING GeForce RTX 2070 SUPER 8 GB',
  15000,
  '{"manufacturer":"EVGA","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":215,"tdp":215,"tdpRating":"215W","length":270,"width":null,"height":null,"dimensions":{"length":270,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('EVGA XC ULTRA GAMING GeForce RTX 2070 SUPER 8 GB')
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
  'Sapphire 21291-01-40G Radeon VII 16GB HBM2 Silver',
  15000,
  '{"manufacturer":"Sapphire","memory":16,"vram":16,"memoryType":"HBM2","powerRequirement":300,"tdp":300,"tdpRating":"300W","length":268,"width":null,"height":null,"dimensions":{"length":268,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Sapphire 21291-01-40G Radeon VII 16GB HBM2 Silver')
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
  'Asus STRIX GAMING Advanced GeForce RTX 2070 8GB GDDR6 Black',
  15000,
  '{"manufacturer":"Asus","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":185,"tdp":185,"tdpRating":"185W","length":300,"width":null,"height":null,"dimensions":{"length":300,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus STRIX GAMING Advanced GeForce RTX 2070 8GB GDDR6 Black')
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
  'EVGA GeForce GTX 1060 GAMING 6GB GDDR5 Black / Silver',
  15000,
  '{"manufacturer":"EVGA","memory":6,"vram":6,"memoryType":"GDDR5","powerRequirement":120,"tdp":120,"tdpRating":"120W","length":267,"width":null,"height":null,"dimensions":{"length":267,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('EVGA GeForce GTX 1060 GAMING 6GB GDDR5 Black / Silver')
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
  'XFX Quicksilver AMD Radeon RX 9070XT White Magnetic Air Edition',
  15000,
  '{"manufacturer":"XFX","memory":16,"vram":16,"memoryType":"GDDR6","powerRequirement":304,"tdp":304,"tdpRating":"304W","length":350,"width":null,"height":null,"dimensions":{"length":350,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('XFX Quicksilver AMD Radeon RX 9070XT White Magnetic Air Edition')
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
  'MSI SHADOW 2X OC GeForce RTX 5070 12 GB BLACK',
  15000,
  '{"manufacturer":"MSI","memory":12,"vram":12,"memoryType":"GDDR7","powerRequirement":250,"tdp":250,"tdpRating":"250W","length":231,"width":null,"height":null,"dimensions":{"length":231,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI SHADOW 2X OC GeForce RTX 5070 12 GB BLACK')
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
  'Gigabyte GAMING OC Radeon RX 9060 XT 16GB GDDR6 Black',
  15000,
  '{"manufacturer":"Gigabyte","memory":16,"vram":16,"memoryType":"GDDR6","powerRequirement":160,"tdp":160,"tdpRating":"160W","length":281,"width":null,"height":null,"dimensions":{"length":281,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte GAMING OC Radeon RX 9060 XT 16GB GDDR6 Black')
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
  'EVGA K|NGP|N ACX 2.0+ GeForce GTX 980 Ti 6GB GDDR5 Black',
  15000,
  '{"manufacturer":"EVGA","memory":6,"vram":6,"memoryType":"GDDR5","powerRequirement":250,"tdp":250,"tdpRating":"250W","length":280,"width":null,"height":null,"dimensions":{"length":280,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('EVGA K|NGP|N ACX 2.0+ GeForce GTX 980 Ti 6GB GDDR5 Black')
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
  'MSI GeForce RTX 4070 Ti VENTUS 3X E OC 12GB GDDR6X Silver / Black',
  15000,
  '{"manufacturer":"MSI","memory":12,"vram":12,"memoryType":"GDDR6X","powerRequirement":285,"tdp":285,"tdpRating":"285W","length":308,"width":null,"height":null,"dimensions":{"length":308,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI GeForce RTX 4070 Ti VENTUS 3X E OC 12GB GDDR6X Silver / Black')
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
  'Sapphire NITRO+ Radeon RX 480 8GB GDDR5 Black',
  15000,
  '{"manufacturer":"Sapphire","memory":8,"vram":8,"memoryType":"GDDR5","powerRequirement":225,"tdp":225,"tdpRating":"225W","length":240,"width":null,"height":null,"dimensions":{"length":240,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Sapphire NITRO+ Radeon RX 480 8GB GDDR5 Black')
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
  'XFX Speedster QICK 319 Core Radeon RX 6750 XT 12GB GDDR6 Black',
  15000,
  '{"manufacturer":"XFX","memory":12,"vram":12,"memoryType":"GDDR6","powerRequirement":250,"tdp":250,"tdpRating":"250W","length":323,"width":null,"height":null,"dimensions":{"length":323,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('XFX Speedster QICK 319 Core Radeon RX 6750 XT 12GB GDDR6 Black')
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
  'PNY VCNRTX6000ADA-PB RTX 6000 Ada Generation 48GB GDDR6 Black / Gold',
  15000,
  '{"manufacturer":"PNY","memory":48,"vram":48,"memoryType":"GDDR6","powerRequirement":300,"tdp":300,"tdpRating":"300W","length":267,"width":null,"height":null,"dimensions":{"length":267,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('PNY VCNRTX6000ADA-PB RTX 6000 Ada Generation 48GB GDDR6 Black / Gold')
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
  'Sapphire Radeon RX 7600 PULSE 8GB GDDR6 Black / Red',
  15000,
  '{"manufacturer":"Sapphire","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":185,"tdp":185,"tdpRating":"185W","length":240,"width":null,"height":null,"dimensions":{"length":240,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Sapphire Radeon RX 7600 PULSE 8GB GDDR6 Black / Red')
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
  'Gigabyte GAMING OC PRO Radeon RX 6600 XT 8GB GDDR6 Black / Silver',
  15000,
  '{"manufacturer":"Gigabyte","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":160,"tdp":160,"tdpRating":"160W","length":282,"width":null,"height":null,"dimensions":{"length":282,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte GAMING OC PRO Radeon RX 6600 XT 8GB GDDR6 Black / Silver')
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
  'EVGA GeForce GTX 1660 XC Ultra Gaming, 6GB GDDR5, HDB Fan, 06G-P4-1167-KR',
  15000,
  '{"manufacturer":"EVGA","memory":6,"vram":6,"memoryType":"GDDR5","powerRequirement":null,"tdp":null,"tdpRating":null,"length":267.97,"width":null,"height":null,"dimensions":{"length":267.97,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('EVGA GeForce GTX 1660 XC Ultra Gaming, 6GB GDDR5, HDB Fan, 06G-P4-1167-KR')
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
  'AMD 100-300000006 Radeon PRO W7700 16GB GDDR6',
  15000,
  '{"manufacturer":"AMD","memory":16,"vram":16,"memoryType":"GDDR6","powerRequirement":190,"tdp":190,"tdpRating":"190W","length":241,"width":null,"height":null,"dimensions":{"length":241,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD 100-300000006 Radeon PRO W7700 16GB GDDR6')
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
  'EVGA GeForce GTX 960 FTW ACX 2.0+ 4GB GDDR5 Black / Silver',
  15000,
  '{"manufacturer":"EVGA","memory":4,"vram":4,"memoryType":"GDDR5","powerRequirement":120,"tdp":120,"tdpRating":"120W","length":257,"width":null,"height":null,"dimensions":{"length":257,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('EVGA GeForce GTX 960 FTW ACX 2.0+ 4GB GDDR5 Black / Silver')
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
  'Antec Earthwatts 550W 80+ Bronze Certified Non-Modular',
  3000,
  '{"manufacturer":"Antec","wattage":550,"powerRequirement":550,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Antec Earthwatts 550W 80+ Bronze Certified Non-Modular')
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
  'Cougar GEX X2 Black 1000W Fully Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"Cougar","wattage":1000,"powerRequirement":1000,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cougar GEX X2 Black 1000W Fully Modular 80+ Gold Certified')
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
  'SeaSonic ATX3-FOCUS-GX White 850W Fully Modular 80+ Gold',
  3000,
  '{"manufacturer":"SeaSonic","wattage":850,"powerRequirement":850,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('SeaSonic ATX3-FOCUS-GX White 850W Fully Modular 80+ Gold')
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
  'Deepcool PF650 Black 230V ATX 650W Non-Modular 80+ Certified',
  3000,
  '{"manufacturer":"Deepcool","wattage":650,"powerRequirement":650,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool PF650 Black 230V ATX 650W Non-Modular 80+ Certified')
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
  'Enermax REVOLUTION X''t II 650W Semi-Modular 80+ Gold',
  3000,
  '{"manufacturer":"Enermax","wattage":650,"powerRequirement":650,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Enermax REVOLUTION X''t II 650W Semi-Modular 80+ Gold')
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
  'Zalman TeraMax II ATX 1200W Fully Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"Zalman","wattage":1200,"powerRequirement":1200,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Zalman TeraMax II ATX 1200W Fully Modular 80+ Gold Certified')
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
  'Corsair RM650e (2025) Black 650W Fully Modular',
  3000,
  '{"manufacturer":"Corsair","wattage":650,"powerRequirement":650,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair RM650e (2025) Black 650W Fully Modular')
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
  'Silverstone Triton 750Rx Black 750W Non-Modular',
  3000,
  '{"manufacturer":"Silverstone","wattage":750,"powerRequirement":750,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silverstone Triton 750Rx Black 750W Non-Modular')
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
  'CoolMax NW-650B ATX 650W Non-Modular',
  3000,
  '{"manufacturer":"CoolMax","wattage":650,"powerRequirement":650,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('CoolMax NW-650B ATX 650W Non-Modular')
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
  'Super Flower Leadex Platinum Black 750W Fully Modular 80+ Platinum',
  3000,
  '{"manufacturer":"Super Flower","wattage":750,"powerRequirement":750,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Super Flower Leadex Platinum Black 750W Fully Modular 80+ Platinum')
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
  'Cooler Master New GX 450W Non-Modular 80+ Bronze',
  3000,
  '{"manufacturer":"Cooler Master","wattage":450,"powerRequirement":450,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cooler Master New GX 450W Non-Modular 80+ Bronze')
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
  'Corsair VS600 ATX 600W Non-Modular 80+ Certified',
  3000,
  '{"manufacturer":"Corsair","wattage":600,"powerRequirement":600,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair VS600 ATX 600W Non-Modular 80+ Certified')
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
  'PowerSpec PSX Black 850W Fully Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"PowerSpec","wattage":850,"powerRequirement":850,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('PowerSpec PSX Black 850W Fully Modular 80+ Gold Certified')
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
  'SeaSonic PRIME TX-1600 Noctua Edition Brown / Black 1600W Fully Modular 80+ Titanium Certified',
  3000,
  '{"manufacturer":"SeaSonic","wattage":1600,"powerRequirement":1600,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('SeaSonic PRIME TX-1600 Noctua Edition Brown / Black 1600W Fully Modular 80+ Titanium Certified')
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
  'Rosewill SMG850 Black ATX 850W Fully Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"Rosewill","wattage":850,"powerRequirement":850,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Rosewill SMG850 Black ATX 850W Fully Modular 80+ Gold Certified')
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
  'Enermax Revolution D.F. X Black 1650W Fully Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"Enermax","wattage":1650,"powerRequirement":1650,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Enermax Revolution D.F. X Black 1650W Fully Modular 80+ Gold Certified')
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
  'Corsair SF1000L Black SFX 1000W Fully Modular 80+ Gold',
  3000,
  '{"manufacturer":"Corsair","wattage":1000,"powerRequirement":1000,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair SF1000L Black SFX 1000W Fully Modular 80+ Gold')
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
  'Thermaltake Toughpower DPS G 450W Fully Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"Thermaltake","wattage":450,"powerRequirement":450,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermaltake Toughpower DPS G 450W Fully Modular 80+ Gold Certified')
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
  'GAMDIAS ASTRAPE M1 Black Multicolor 550W Non-Modular 80+ Certified',
  3000,
  '{"manufacturer":"GAMDIAS","wattage":550,"powerRequirement":550,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('GAMDIAS ASTRAPE M1 Black Multicolor 550W Non-Modular 80+ Certified')
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
  'Silverstone DA700 ATX 700W Fully Modular',
  3000,
  '{"manufacturer":"Silverstone","wattage":700,"powerRequirement":700,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silverstone DA700 ATX 700W Fully Modular')
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
  'Fractal Design Meshify C ATX Mid Tower Black',
  2500,
  '{"manufacturer":"Fractal Design","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Fractal Design Meshify C ATX Mid Tower Black')
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
  'Deepcool CH510 MESH DIGITAL ATX Mid Tower Black Tempered Glass',
  2500,
  '{"manufacturer":"DeepCool","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool CH510 MESH DIGITAL ATX Mid Tower Black Tempered Glass')
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
  'Thermaltake View 380 XL WS ARGB Mid Tower Chassis Wood Edition Snow',
  2500,
  '{"manufacturer":"Thermaltake","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermaltake View 380 XL WS ARGB Mid Tower Chassis Wood Edition Snow')
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
  'Silverstone Sugo SG11 Micro ATX Mini Tower Black',
  2500,
  '{"manufacturer":"Silverstone","formFactor":"Micro ATX Mini Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silverstone Sugo SG11 Micro ATX Mini Tower Black')
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
  'Lian Li LANCOOL 216 ATX Mid Tower White Tinted Tempered Glass RGB w/Controller',
  2500,
  '{"manufacturer":"Lian Li","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Lian Li LANCOOL 216 ATX Mid Tower White Tinted Tempered Glass RGB w/Controller')
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
  'Cougar DarkBlader-G ATX Full Tower Black / Silver with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A Front Panel',
  2500,
  '{"manufacturer":"Cougar","formFactor":"ATX Full Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cougar DarkBlader-G ATX Full Tower Black / Silver with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A Front Panel')
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
  'HYTE Y40 ATX Mid Tower Red / Black with Tempered Glass Side Panel and USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"HYTE","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('HYTE Y40 ATX Mid Tower Red / Black with Tempered Glass Side Panel and USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A')
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
  'Fractal Design Define R4 ATX Mid Tower Black / Gray with Acrylic Side Panel and USB 3.2 Gen 1 Type-A, USB 2.0 Type-A',
  2500,
  '{"manufacturer":"Fractal Design","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Fractal Design Define R4 ATX Mid Tower Black / Gray with Acrylic Side Panel and USB 3.2 Gen 1 Type-A, USB 2.0 Type-A')
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
  'Antec AX67 ARGB ATX Mid Tower Tempered Glass',
  2500,
  '{"manufacturer":"Antec","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Antec AX67 ARGB ATX Mid Tower Tempered Glass')
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
  'Chieftec Chieftronic M2 MicroATX Mid Tower Tempered Glass Side Panel, Front USB 3.2 Gen 1 Type-A & USB 2.0 Type-A',
  2500,
  '{"manufacturer":"Chieftec","formFactor":"Micro ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Chieftec Chieftronic M2 MicroATX Mid Tower Tempered Glass Side Panel, Front USB 3.2 Gen 1 Type-A & USB 2.0 Type-A')
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
  'Silverstone Lucid 04 Micro ATX Mid Tower White Tempered Glass Side Panel, USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"Silverstone","formFactor":"Micro ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silverstone Lucid 04 Micro ATX Mid Tower White Tempered Glass Side Panel, USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A')
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
  'NZXT H7 Flow RGB (2024) ATX Mid Tower White Tempered Glass, USB 3.2 Gen 2x2 Type-C USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"NZXT","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('NZXT H7 Flow RGB (2024) ATX Mid Tower White Tempered Glass, USB 3.2 Gen 2x2 Type-C USB 3.2 Gen 1 Type-A')
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
  'Corsair 6500X ATX Mid Tower Black Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"Corsair","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair 6500X ATX Mid Tower Black Tempered Glass Side Panel')
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
  'Fractal Design Focus 2 ATX Mid Tower Black',
  2500,
  '{"manufacturer":"Fractal Design","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Fractal Design Focus 2 ATX Mid Tower Black')
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
  'Rosewill R379-M Micro ATX Slim Black / Silver w/300 W Power Supply',
  2500,
  '{"manufacturer":"Rosewill","formFactor":"Micro ATX Slim Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Rosewill R379-M Micro ATX Slim Black / Silver w/300 W Power Supply')
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
  'Corsair Carbide Series Air 240 Micro ATX Mid Tower White Acrylic Side Panel, USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"Corsair","formFactor":"Micro ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Carbide Series Air 240 Micro ATX Mid Tower White Acrylic Side Panel, USB 3.2 Gen 1 Type-A')
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
  'Silverstone RVZ03W-ARGB Mini-ITX Desktop White',
  2500,
  '{"manufacturer":"Silverstone","formFactor":"Mini-ITX Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silverstone RVZ03W-ARGB Mini-ITX Desktop White')
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
  'be quiet! Silent Base 601 ATX Mid Tower Black / Silver with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A USB 2.0 Type-A',
  2500,
  '{"manufacturer":"be quiet!","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('be quiet! Silent Base 601 ATX Mid Tower Black / Silver with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A USB 2.0 Type-A')
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
  'Corsair 2000D RGB AIRFLOW Mini-ITX Tower Black Mesh Side Panel, USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"Corsair","formFactor":"Mini-ITX Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair 2000D RGB AIRFLOW Mini-ITX Tower Black Mesh Side Panel, USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A')
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
  'Vetroo AL700 ATX Mid Tower Black with Tempered Glass Side Panel and Front Panel USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A, USB 2.0 Type-A',
  2500,
  '{"manufacturer":"Vetroo","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Vetroo AL700 ATX Mid Tower Black with Tempered Glass Side Panel and Front Panel USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A, USB 2.0 Type-A')
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
  'Gelid Solutions Liquid 240 Water 240mm Black',
  1500,
  '{"manufacturer":"Gelid Solutions","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":56,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gelid Solutions Liquid 240 Water 240mm Black')
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
  'Thermaltake UX 210 Air ARGB Black / Silver',
  1500,
  '{"manufacturer":"Thermaltake","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":153,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermaltake UX 210 Air ARGB Black / Silver')
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
  'Alphacool Eisbaer Aurora Water 240mm 61.5 CFM Black',
  1500,
  '{"manufacturer":"Alphacool","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Alphacool Eisbaer Aurora Water 240mm 61.5 CFM Black')
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
  'ID-COOLING IS-30 40 CFM Air 30mm',
  1500,
  '{"manufacturer":"ID-COOLING","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":30,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ID-COOLING IS-30 40 CFM Air 30mm')
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
  'Thermalright Frozen Warframe PRO Water 360mm Black',
  1500,
  '{"manufacturer":"Thermalright","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":60,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermalright Frozen Warframe PRO Water 360mm Black')
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
  'Jonsbo CR-3000 Standard 59.48 CFM Air 160mm Black / Silver',
  1500,
  '{"manufacturer":"Jonsbo","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":160,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Jonsbo CR-3000 Standard 59.48 CFM Air 160mm Black / Silver')
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
  'Lian Li Hydroshift II LCD-C CL 72 CFM Water 360mm Black',
  1500,
  '{"manufacturer":"Lian Li","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":69,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Lian Li Hydroshift II LCD-C CL 72 CFM Water 360mm Black')
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
  'Deepcool AK400 Air 155mm Black / Silver',
  1500,
  '{"manufacturer":"Deepcool","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":155,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool AK400 Air 155mm Black / Silver')
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
  'ARCTIC Alpine 11 GT Rev. 2 Air 64mm 28.6 CFM',
  1500,
  '{"manufacturer":"ARCTIC","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":64,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ARCTIC Alpine 11 GT Rev. 2 Air 64mm 28.6 CFM')
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
  'MSI MAG CORELIQUID C240 Water 240mm EVA e-PROJECT Black',
  1500,
  '{"manufacturer":"MSI","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI MAG CORELIQUID C240 Water 240mm EVA e-PROJECT Black')
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
  'Alpenföhn Brocken 2 Air 165mm 64.15 CFM',
  1500,
  '{"manufacturer":"Alpenföhn","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":165,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Alpenföhn Brocken 2 Air 165mm 64.15 CFM')
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
  'Deepcool CAPTAIN Water 240mm 91.12 CFM',
  1500,
  '{"manufacturer":"Deepcool","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool CAPTAIN Water 240mm 91.12 CFM')
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
  'Deepcool LQ240 Water 240mm Black',
  1500,
  '{"manufacturer":"Deepcool","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":64,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool LQ240 Water 240mm Black')
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
  'Thermaltake TH240 V2 ARGB Sync Water 240mm 57.05 CFM Black',
  1500,
  '{"manufacturer":"Thermaltake","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermaltake TH240 V2 ARGB Sync Water 240mm 57.05 CFM Black')
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
  'Thermaltake MAGFloe 360 Ultra ARGB Sync 57.11 CFM Water 360mm Black',
  1500,
  '{"manufacturer":"Thermaltake","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermaltake MAGFloe 360 Ultra ARGB Sync 57.11 CFM Water 360mm Black')
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
  'be quiet! Silent Loop 2 Water 240mm Black',
  1500,
  '{"manufacturer":"be quiet!","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('be quiet! Silent Loop 2 Water 240mm Black')
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
  'Cooler Master CHD-00008-01-GP Air 30.67 CFM Rifle Bearing',
  1500,
  '{"manufacturer":"Cooler Master","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cooler Master CHD-00008-01-GP Air 30.67 CFM Rifle Bearing')
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
  'Cooler Master Hyper 212 LED Air 160mm 66.3 CFM Rifle Bearing',
  1500,
  '{"manufacturer":"Cooler Master","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":160,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cooler Master Hyper 212 LED Air 160mm 66.3 CFM Rifle Bearing')
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
  'MSI MAG CORELIQUID R Water 78.73 CFM 360mm Black',
  1500,
  '{"manufacturer":"MSI","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI MAG CORELIQUID R Water 78.73 CFM 360mm Black')
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
  'NZXT Kraken X73 Water 360mm RGB 52.44 CFM Black',
  1500,
  '{"manufacturer":"NZXT","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('NZXT Kraken X73 Water 360mm RGB 52.44 CFM Black')
);

-- Summary:
-- CPU: 20 imported, 0 skipped
-- Motherboard: 20 imported, 0 skipped
-- RAM: 20 imported, 0 skipped
-- Storage: 20 imported, 0 skipped
-- GPU: 20 imported, 0 skipped
-- PSU: 20 imported, 0 skipped
-- PCCase: 20 imported, 0 skipped
-- CPUCooler: 20 imported, 0 skipped
