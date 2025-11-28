-- Import 120 components per category from BuildCores OpenDB
-- Generated: 2025-11-28T16:19:03.355Z
-- Total: 960 components (120 per category)
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
  'Intel Xeon E3 1275 V5 3.6 GHz 4-Core LGA1151',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E3 1275 V5 3.6 GHz 4-Core LGA1151')
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
  'Intel Xeon E5 2623 V3 3 GHz 4-Core LGA2011-3',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011-3","cpuSocket":"LGA2011-3","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E5 2623 V3 3 GHz 4-Core LGA2011-3')
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
  'AMD Ryzen 5 3400G 3.7 GHz 4-Core AM4',
  5000,
  '{"manufacturer":"AMD","socket":"AM4","cpuSocket":"AM4","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD Ryzen 5 3400G 3.7 GHz 4-Core AM4')
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
  'Intel Xeon E5 2630 V3 2.4 GHz 8-Core LGA2011-3',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011-3","cpuSocket":"LGA2011-3","tdp":null,"tdpRating":null,"cores":8,"threads":16,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E5 2630 V3 2.4 GHz 8-Core LGA2011-3')
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
  'Intel Xeon E3 1220 V5 3 GHz 4-Core LGA1151 OEM/Tray',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E3 1220 V5 3 GHz 4-Core LGA1151 OEM/Tray')
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
  'Intel Xeon E3 1270 V3 3.5 GHz 4-Core LGA1150',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1150","cpuSocket":"LGA1150","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E3 1270 V3 3.5 GHz 4-Core LGA1150')
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
  'Intel Core i5 12600KF 3.7 GHz 10-Core LGA1700',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1700","cpuSocket":"LGA1700","tdp":null,"tdpRating":null,"cores":10,"threads":20,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i5 12600KF 3.7 GHz 10-Core LGA1700')
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
  'AMD A4 6300 3.7 GHz 2-Core FM2 OEM/Tray',
  5000,
  '{"manufacturer":"AMD","socket":"FM2","cpuSocket":"FM2","tdp":null,"tdpRating":null,"cores":2,"threads":2,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD A4 6300 3.7 GHz 2-Core FM2 OEM/Tray')
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
  'Intel Xeon E3 1271 V3 3.6 GHz 4-Core LGA1150',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1150","cpuSocket":"LGA1150","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E3 1271 V3 3.6 GHz 4-Core LGA1150')
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
  'Intel Core i7 5930K 3.5 GHz 6-Core LGA2011-3 OEM/Tray',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011-3","cpuSocket":"LGA2011-3","tdp":null,"tdpRating":null,"cores":6,"threads":12,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i7 5930K 3.5 GHz 6-Core LGA2011-3 OEM/Tray')
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
  'Intel Core i3 9100 3.6 GHz 4-Core LGA1151',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i3 9100 3.6 GHz 4-Core LGA1151')
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
  'AMD Threadripper 2920X 3.5 GHz 12-Core sTR4',
  5000,
  '{"manufacturer":"AMD","socket":"TR4","cpuSocket":"TR4","tdp":null,"tdpRating":null,"cores":12,"threads":24,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD Threadripper 2920X 3.5 GHz 12-Core sTR4')
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
  'Intel Xeon E5 2683 V4 2.1 GHz 16-Core LGA2011-3',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011-3","cpuSocket":"LGA2011-3","tdp":null,"tdpRating":null,"cores":16,"threads":32,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E5 2683 V4 2.1 GHz 16-Core LGA2011-3')
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
  'Intel Core i3 9320 3.7 GHz 4-Core LGA1151 OEM/Tray',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i3 9320 3.7 GHz 4-Core LGA1151 OEM/Tray')
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
  'AMD Ryzen 7 9700X 3.8 GHz 8-Core AM5',
  5000,
  '{"manufacturer":"AMD","socket":"AM5","cpuSocket":"AM5","tdp":null,"tdpRating":null,"cores":8,"threads":16,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD Ryzen 7 9700X 3.8 GHz 8-Core AM5')
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
  'Intel Xeon E5 2660 2.2 GHz 8-Core LGA2011 OEM/Tray',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011","cpuSocket":"LGA2011","tdp":null,"tdpRating":null,"cores":8,"threads":16,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E5 2660 2.2 GHz 8-Core LGA2011 OEM/Tray')
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
  'Intel Core i7 7820X 3.6 GHz 8-Core LGA2066',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2066","cpuSocket":"LGA2066","tdp":null,"tdpRating":null,"cores":8,"threads":16,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i7 7820X 3.6 GHz 8-Core LGA2066')
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
  'Intel Core i7 4790K 4 GHz 4-Core LGA1150 OEM/Tray',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1150","cpuSocket":"LGA1150","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i7 4790K 4 GHz 4-Core LGA1150 OEM/Tray')
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
  'AMD EPYC EPYC 4344P 3.8 GHz 8-Core AM5',
  5000,
  '{"manufacturer":"AMD","socket":"AM5","cpuSocket":"AM5","tdp":null,"tdpRating":null,"cores":8,"threads":16,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD EPYC EPYC 4344P 3.8 GHz 8-Core AM5')
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
  'Intel Xeon E 2126G 3.3 GHz 6-Core LGA1151 OEM/Tray',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":6,"threads":6,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E 2126G 3.3 GHz 6-Core LGA1151 OEM/Tray')
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
  'Intel Core i7 6850K 3.6 GHz 6-Core LGA2011-3 OEM/Tray',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011-3","cpuSocket":"LGA2011-3","tdp":null,"tdpRating":null,"cores":6,"threads":12,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i7 6850K 3.6 GHz 6-Core LGA2011-3 OEM/Tray')
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
  'Intel Xeon E5 2620 V3 2.4 GHz 6-Core LGA2011-3 OEM/Tray',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011-3","cpuSocket":"LGA2011-3","tdp":null,"tdpRating":null,"cores":6,"threads":12,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E5 2620 V3 2.4 GHz 6-Core LGA2011-3 OEM/Tray')
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
  'Intel Xeon E5 2680 2.7 GHz 8-Core LGA2011',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011","cpuSocket":"LGA2011","tdp":null,"tdpRating":null,"cores":8,"threads":16,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E5 2680 2.7 GHz 8-Core LGA2011')
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
  'AMD A-Series A12 9800E 3.1 GHz 4-Core AM4',
  5000,
  '{"manufacturer":"AMD","socket":"AM4","cpuSocket":"AM4","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD A-Series A12 9800E 3.1 GHz 4-Core AM4')
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
  'Intel Core i7 Extreme 5960X 3 GHz 8-Core LGA2011-3',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011-3","cpuSocket":"LGA2011-3","tdp":null,"tdpRating":null,"cores":8,"threads":16,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i7 Extreme 5960X 3 GHz 8-Core LGA2011-3')
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
  'AMD A10 A10-7700K 3.4 GHz 4-Core FM2+',
  5000,
  '{"manufacturer":"AMD","socket":"FM2+","cpuSocket":"FM2+","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD A10 A10-7700K 3.4 GHz 4-Core FM2+')
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
  'Intel Core i5 14500T 1.7 GHz 14-Core LGA1700 OEM/Tray',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1700","cpuSocket":"LGA1700","tdp":null,"tdpRating":null,"cores":14,"threads":20,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i5 14500T 1.7 GHz 14-Core LGA1700 OEM/Tray')
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
  'Intel Core i9-9920X',
  5000,
  '{"manufacturer":null,"socket":"LGA2066","cpuSocket":"LGA2066","tdp":null,"tdpRating":null,"cores":12,"threads":24,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i9-9920X')
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
  'Intel Celeron Processor G5920',
  5000,
  '{"manufacturer":null,"socket":"LGA1200","cpuSocket":"LGA1200","tdp":null,"tdpRating":null,"cores":2,"threads":2,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Celeron Processor G5920')
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
  'AMD A6 A6 6420K 4 GHz 2-Core FM2 OEM/Tray',
  5000,
  '{"manufacturer":"AMD","socket":"FM2","cpuSocket":"FM2","tdp":null,"tdpRating":null,"cores":2,"threads":2,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD A6 A6 6420K 4 GHz 2-Core FM2 OEM/Tray')
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
  'Intel Core i9 10850K 3.6 GHz 10-Core LGA1200',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1200","cpuSocket":"LGA1200","tdp":null,"tdpRating":null,"cores":10,"threads":20,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i9 10850K 3.6 GHz 10-Core LGA1200')
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
  'Intel Core i7 9800X 3.8 GHz 8-Core LGA2066',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2066","cpuSocket":"LGA2066","tdp":null,"tdpRating":null,"cores":8,"threads":16,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i7 9800X 3.8 GHz 8-Core LGA2066')
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
  'AMD A-Series A10 9700E 3 GHz 4-Core AM4',
  5000,
  '{"manufacturer":"AMD","socket":"AM4","cpuSocket":"AM4","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD A-Series A10 9700E 3 GHz 4-Core AM4')
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
  'Intel Core i7 Extreme 6950X 3.0 GHz 10-Core LGA2011-3',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011-3","cpuSocket":"LGA2011-3","tdp":null,"tdpRating":null,"cores":10,"threads":20,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i7 Extreme 6950X 3.0 GHz 10-Core LGA2011-3')
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
  'Intel Core i7 4771 3.5 GHz 4-Core LGA1150',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1150","cpuSocket":"LGA1150","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i7 4771 3.5 GHz 4-Core LGA1150')
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
  'Intel Core i9 7940X 3.1 GHz 14-Core LGA2066',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2066","cpuSocket":"LGA2066","tdp":null,"tdpRating":null,"cores":14,"threads":28,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i9 7940X 3.1 GHz 14-Core LGA2066')
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
  'AMD Ryzen 5 3600X 3.8 GHz 6-Core AM4',
  5000,
  '{"manufacturer":"AMD","socket":"AM4","cpuSocket":"AM4","tdp":null,"tdpRating":null,"cores":6,"threads":12,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD Ryzen 5 3600X 3.8 GHz 6-Core AM4')
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
  'Intel Core i9 10900F 2.8 GHz 10-Core LGA1200',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1200","cpuSocket":"LGA1200","tdp":null,"tdpRating":null,"cores":10,"threads":20,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i9 10900F 2.8 GHz 10-Core LGA1200')
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
  'Intel Xeon E5 1660 V3 3 GHz 8-Core LGA2011-3 OEM/Tray',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011-3","cpuSocket":"LGA2011-3","tdp":null,"tdpRating":null,"cores":8,"threads":16,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E5 1660 V3 3 GHz 8-Core LGA2011-3 OEM/Tray')
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
  'AMD Ryzen 5 9600 3.8 GHz 6-Core AM5',
  5000,
  '{"manufacturer":"AMD","socket":"AM5","cpuSocket":"AM5","tdp":null,"tdpRating":null,"cores":6,"threads":12,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD Ryzen 5 9600 3.8 GHz 6-Core AM5')
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
  'AMD Athlon X4 880K 4 GHz 4-Core FM2+',
  5000,
  '{"manufacturer":"AMD","socket":"FM2+","cpuSocket":"FM2+","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD Athlon X4 880K 4 GHz 4-Core FM2+')
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
  'Intel Core i5 9500 3.0 GHz 6-Core LGA1151',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":6,"threads":6,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i5 9500 3.0 GHz 6-Core LGA1151')
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
  'AMD A 10 7860k 3.6 GHz 4-Core FM2+ OEM/Tray',
  5000,
  '{"manufacturer":"AMD","socket":"FM2+","cpuSocket":"FM2+","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD A 10 7860k 3.6 GHz 4-Core FM2+ OEM/Tray')
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
  'Intel Xeon E5 2650 2 GHz 8-Core LGA2011',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011","cpuSocket":"LGA2011","tdp":null,"tdpRating":null,"cores":8,"threads":16,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E5 2650 2 GHz 8-Core LGA2011')
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
  'AMD FX FX-6120 3.5 GHz 6-Core AM3+ OEM/Tray',
  5000,
  '{"manufacturer":"AMD","socket":"AM3+","cpuSocket":"AM3+","tdp":null,"tdpRating":null,"cores":6,"threads":6,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD FX FX-6120 3.5 GHz 6-Core AM3+ OEM/Tray')
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
  'AMD Ryzen 5 7500F 3.7 GHz 6-Core AM5 OEM/Tray',
  5000,
  '{"manufacturer":"AMD","socket":"AM5","cpuSocket":"AM5","tdp":null,"tdpRating":null,"cores":6,"threads":12,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD Ryzen 5 7500F 3.7 GHz 6-Core AM5 OEM/Tray')
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
  'Intel Core i3 12100F 3.3 GHz 4-Core LGA1700',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1700","cpuSocket":"LGA1700","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i3 12100F 3.3 GHz 4-Core LGA1700')
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
  'Intel Core i9 14900F 2.0 GHz 24-Core LGA1700',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1700","cpuSocket":"LGA1700","tdp":null,"tdpRating":null,"cores":24,"threads":32,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i9 14900F 2.0 GHz 24-Core LGA1700')
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
  'AMD Ryzen 9 3900XT 3.8 GHz 12-Core AM4',
  5000,
  '{"manufacturer":"AMD","socket":"AM4","cpuSocket":"AM4","tdp":null,"tdpRating":null,"cores":12,"threads":24,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD Ryzen 9 3900XT 3.8 GHz 12-Core AM4')
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
  'Intel Core i5 7640X 4 GHz 4-Core LGA2066 OEM/Tray',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2066","cpuSocket":"LGA2066","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i5 7640X 4 GHz 4-Core LGA2066 OEM/Tray')
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
  'AMD Ryzen Threadripper 2990WX',
  5000,
  '{"manufacturer":null,"socket":"TR4","cpuSocket":"TR4","tdp":null,"tdpRating":null,"cores":32,"threads":64,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD Ryzen Threadripper 2990WX')
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
  'Intel Core i9 11900 2.5 GHz 8-Core LGA1200',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1200","cpuSocket":"LGA1200","tdp":null,"tdpRating":null,"cores":8,"threads":16,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i9 11900 2.5 GHz 8-Core LGA1200')
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
  'AMD Ryzen 5 4600G 3.7 GHz 6-Core AM4',
  5000,
  '{"manufacturer":"AMD","socket":"AM4","cpuSocket":"AM4","tdp":null,"tdpRating":null,"cores":6,"threads":12,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD Ryzen 5 4600G 3.7 GHz 6-Core AM4')
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
  'AMD FX FX FX-8370 4 GHz 8-Core AM3+',
  5000,
  '{"manufacturer":"AMD","socket":"AM3+","cpuSocket":"AM3+","tdp":null,"tdpRating":null,"cores":8,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD FX FX FX-8370 4 GHz 8-Core AM3+')
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
  'AMD EPYC 4584PX 4.2 GHz 16-Core AM5',
  5000,
  '{"manufacturer":"AMD","socket":"AM5","cpuSocket":"AM5","tdp":null,"tdpRating":null,"cores":16,"threads":32,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD EPYC 4584PX 4.2 GHz 16-Core AM5')
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
  'Intel Core i9 11900KF 3.5 GHz 8-Core LGA1200',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1200","cpuSocket":"LGA1200","tdp":null,"tdpRating":null,"cores":8,"threads":16,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i9 11900KF 3.5 GHz 8-Core LGA1200')
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
  'Intel Core i7 6700K 4 GHz 4-Core LGA1151',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i7 6700K 4 GHz 4-Core LGA1151')
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
  'Intel Core i9 14900 2 GHz 24-Core LGA1700',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1700","cpuSocket":"LGA1700","tdp":null,"tdpRating":null,"cores":24,"threads":32,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i9 14900 2 GHz 24-Core LGA1700')
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
  'Intel Xeon E5 1650 V4 3.6 GHz 6-Core LGA2011-3',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011-3","cpuSocket":"LGA2011-3","tdp":null,"tdpRating":null,"cores":6,"threads":12,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E5 1650 V4 3.6 GHz 6-Core LGA2011-3')
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
  'Intel Pentium Gold G5500',
  5000,
  '{"manufacturer":null,"socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":2,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Pentium Gold G5500')
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
  'Intel Xeon E 2134 3.5 GHz 4-Core LGA1151',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E 2134 3.5 GHz 4-Core LGA1151')
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
  'Intel Xeon E5-2697 V2 2.7 GHz 12-Core LGA2011',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011","cpuSocket":"LGA2011","tdp":null,"tdpRating":null,"cores":12,"threads":24,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E5-2697 V2 2.7 GHz 12-Core LGA2011')
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
  'Intel Core i5 9500F 3 GHz 6-Core LGA1151',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":6,"threads":6,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i5 9500F 3 GHz 6-Core LGA1151')
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
  'AMD Ryzen 3 1300X 3.5 GHz 4-Core AM4',
  5000,
  '{"manufacturer":"AMD","socket":"AM4","cpuSocket":"AM4","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD Ryzen 3 1300X 3.5 GHz 4-Core AM4')
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
  'AMD A10 A10-7870K 3.9 GHz 4-Core FM2+',
  5000,
  '{"manufacturer":"AMD","socket":"FM2+","cpuSocket":"FM2+","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD A10 A10-7870K 3.9 GHz 4-Core FM2+')
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
  'AMD Ryzen 5 2400G 3.6 GHz 4-Core AM4 OEM/Tray',
  5000,
  '{"manufacturer":"AMD","socket":"AM4","cpuSocket":"AM4","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD Ryzen 5 2400G 3.6 GHz 4-Core AM4 OEM/Tray')
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
  'Intel Xeon E3 1260L V5 OEM/Tray 2.9 GHz 4-Core LGA1151',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E3 1260L V5 OEM/Tray 2.9 GHz 4-Core LGA1151')
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
  'Intel Core i9-9820X X-series Processor (16.5M Cache, up to 4.20 GHz)',
  5000,
  '{"manufacturer":null,"socket":"LGA2066","cpuSocket":"LGA2066","tdp":null,"tdpRating":null,"cores":10,"threads":20,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i9-9820X X-series Processor (16.5M Cache, up to 4.20 GHz)')
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
  'Intel Core i7 6900K 3.2 GHz 8-Core OEM/Tray LGA2011-3',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011-3","cpuSocket":"LGA2011-3","tdp":null,"tdpRating":null,"cores":8,"threads":16,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i7 6900K 3.2 GHz 8-Core OEM/Tray LGA2011-3')
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
  'Intel Core i7 4790T 2.7 GHz 4-Core LGA1150 OEM/Tray',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1150","cpuSocket":"LGA1150","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i7 4790T 2.7 GHz 4-Core LGA1150 OEM/Tray')
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
  'Intel Core i5 12400F 2.5 GHz 6-Core LGA1700',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1700","cpuSocket":"LGA1700","tdp":null,"tdpRating":null,"cores":6,"threads":12,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i5 12400F 2.5 GHz 6-Core LGA1700')
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
  'Intel Xeon E3 1245 V6 3.7 GHz 4-Core LGA1151 OEM/Tray',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E3 1245 V6 3.7 GHz 4-Core LGA1151 OEM/Tray')
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
  'Intel Core i9 7900X 3.3 GHz 10-Core LGA2066 OEM/Tray',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2066","cpuSocket":"LGA2066","tdp":null,"tdpRating":null,"cores":10,"threads":20,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i9 7900X 3.3 GHz 10-Core LGA2066 OEM/Tray')
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
  'Intel Core i9 9900T 2.1 GHz 8-Core LGA1151',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":8,"threads":16,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i9 9900T 2.1 GHz 8-Core LGA1151')
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
  'Intel Core i9 10900KF 3.7 GHz 10-Core LGA1200',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1200","cpuSocket":"LGA1200","tdp":null,"tdpRating":null,"cores":10,"threads":20,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i9 10900KF 3.7 GHz 10-Core LGA1200')
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
  'AMD A-Series A12 9800 3.8 GHz 4-Core AM4',
  5000,
  '{"manufacturer":"AMD","socket":"AM4","cpuSocket":"AM4","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD A-Series A12 9800 3.8 GHz 4-Core AM4')
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
  'AMD A6 A6-9550 3.8 GHz 2-Core AM4',
  5000,
  '{"manufacturer":"AMD","socket":"AM4","cpuSocket":"AM4","tdp":null,"tdpRating":null,"cores":2,"threads":2,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD A6 A6-9550 3.8 GHz 2-Core AM4')
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
  'Intel Core i5 7500 OEM/Tray 3.4 GHz 4-Core LGA1151',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i5 7500 OEM/Tray 3.4 GHz 4-Core LGA1151')
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
  'Intel Core i5 4690K 3.5 GHz 4-Core LGA1150',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1150","cpuSocket":"LGA1150","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i5 4690K 3.5 GHz 4-Core LGA1150')
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
  'AMD FX FX-8310 3.4 GHz 8-Core AM3+ OEM/Tray',
  5000,
  '{"manufacturer":"AMD","socket":"AM3+","cpuSocket":"AM3+","tdp":null,"tdpRating":null,"cores":8,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD FX FX-8310 3.4 GHz 8-Core AM3+ OEM/Tray')
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
  'Intel Core i7 7700T 2.9 GHz 4-Core LGA1151',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i7 7700T 2.9 GHz 4-Core LGA1151')
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
  'Intel Core i3 9100F 3.6 GHz 4-Core LGA1151',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i3 9100F 3.6 GHz 4-Core LGA1151')
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
  'Intel Core i5 9400T 1.8 GHz 6-Core LGA1151 (OEM/Tray)',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":6,"threads":6,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i5 9400T 1.8 GHz 6-Core LGA1151 (OEM/Tray)')
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
  'Intel Core i9 10900 2.8 GHz 10-Core LGA1200',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1200","cpuSocket":"LGA1200","tdp":null,"tdpRating":null,"cores":10,"threads":20,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i9 10900 2.8 GHz 10-Core LGA1200')
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
  'AMD Pro A6 7400B 3.5 GHz 2-Core FM2+ OEM/Tray',
  5000,
  '{"manufacturer":"AMD","socket":"FM2+","cpuSocket":"FM2+","tdp":null,"tdpRating":null,"cores":2,"threads":2,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD Pro A6 7400B 3.5 GHz 2-Core FM2+ OEM/Tray')
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
  'Intel Xeon E 2274G 4 GHz 4-Core LGA1151 OEM/Tray',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E 2274G 4 GHz 4-Core LGA1151 OEM/Tray')
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
  'Intel Core i7 7700T 2.9 GHz 4-Core LGA1151 OEM/Tray',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i7 7700T 2.9 GHz 4-Core LGA1151 OEM/Tray')
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
  'AMD Ryzen 9 PRO 7945 3.7 GHz 12-Core AM5 OEM/Tray',
  5000,
  '{"manufacturer":"AMD","socket":"AM5","cpuSocket":"AM5","tdp":null,"tdpRating":null,"cores":12,"threads":24,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD Ryzen 9 PRO 7945 3.7 GHz 12-Core AM5 OEM/Tray')
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
  'AMD A-Series A10 Pro 7800B 3.5 GHz 4-Core FM2+',
  5000,
  '{"manufacturer":"AMD","socket":"FM2+","cpuSocket":"FM2+","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD A-Series A10 Pro 7800B 3.5 GHz 4-Core FM2+')
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
  'Intel Core i9 9980XE 3 GHz 18-Core LGA2066',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2066","cpuSocket":"LGA2066","tdp":null,"tdpRating":null,"cores":18,"threads":36,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i9 9980XE 3 GHz 18-Core LGA2066')
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
  'Intel Xeon E5 2620 V3 2.4 GHz 6-Core LGA2011-3',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011-3","cpuSocket":"LGA2011-3","tdp":null,"tdpRating":null,"cores":6,"threads":12,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E5 2620 V3 2.4 GHz 6-Core LGA2011-3')
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
  'Intel Core i7 4790K 4 GHz 4-Core LGA1150',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1150","cpuSocket":"LGA1150","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i7 4790K 4 GHz 4-Core LGA1150')
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
  'Intel Core i3 10300 3.7 GHz 4-Core LGA1200',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1200","cpuSocket":"LGA1200","tdp":null,"tdpRating":null,"cores":4,"threads":8,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i3 10300 3.7 GHz 4-Core LGA1200')
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
  'Intel Core i5 7400 3 GHz 4-Core LGA1151',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1151","cpuSocket":"LGA1151","tdp":null,"tdpRating":null,"cores":4,"threads":4,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i5 7400 3 GHz 4-Core LGA1151')
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
  'Intel Core i5 13400F 2.5 GHz 10-Core LGA1700',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1700","cpuSocket":"LGA1700","tdp":null,"tdpRating":null,"cores":10,"threads":16,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i5 13400F 2.5 GHz 10-Core LGA1700')
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
  'Intel Core i7 6850K 3.6 GHz 6-Core LGA2011-3',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011-3","cpuSocket":"LGA2011-3","tdp":null,"tdpRating":null,"cores":6,"threads":12,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Core i7 6850K 3.6 GHz 6-Core LGA2011-3')
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
  'AMD Ryzen 7 1700X 3.4 GHz 8-Core AM4',
  5000,
  '{"manufacturer":"AMD","socket":"AM4","cpuSocket":"AM4","tdp":null,"tdpRating":null,"cores":8,"threads":16,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD Ryzen 7 1700X 3.4 GHz 8-Core AM4')
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
  'Intel Xeon E5 1650 V2 OEM/Tray 3.5 GHz 6-Core LGA2011',
  5000,
  '{"manufacturer":"Intel","socket":"LGA2011","cpuSocket":"LGA2011","tdp":null,"tdpRating":null,"cores":6,"threads":12,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E5 1650 V2 OEM/Tray 3.5 GHz 6-Core LGA2011')
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
  'Intel Xeon E5 2470V2 2.4 GHz 10-Core LGA1356',
  5000,
  '{"manufacturer":"Intel","socket":"LGA1356","cpuSocket":"LGA1356","tdp":null,"tdpRating":null,"cores":10,"threads":20,"baseClock":null,"boostClock":null,"memoryType":"DDR4","ramType":"DDR4"}'::jsonb,
  1,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Xeon E5 2470V2 2.4 GHz 10-Core LGA1356')
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
  'Asus B85 PLUS LGA1150 DDR3 ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1150","cpuSocket":"LGA1150","formFactor":"ATX","chipset":"Intel B85","memory":{"max":32,"ram_type":"DDR3","slots":4},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"0","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9bb1d865ad0c3553e0ee0"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9bb1d865ad0c3553e0ee1"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus B85 PLUS LGA1150 DDR3 ATX')
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
  'Asus X79 Deluxe LGA2011 DDR3 ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA2011","cpuSocket":"LGA2011","formFactor":"ATX","chipset":"Intel X79","memory":{"max":64,"ram_type":"DDR3","slots":8},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"0","sataPorts":"8","pcieSlots":[{"gen":"4.0","quantity":4,"lanes":16,"_id":"67f9b765865ad0c3553da645"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b765865ad0c3553da646"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus X79 Deluxe LGA2011 DDR3 ATX')
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
  'Gigabyte B650M C AM5 DDR5 Micro ATX',
  4000,
  '{"manufacturer":"Gigabyte","socket":"AM5","cpuSocket":"AM5","formFactor":"Micro ATX","chipset":"AMD B650","memory":{"max":192,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"5","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":4,"lanes":16,"_id":"67f99e95865ad0c3553c43e1"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte B650M C AM5 DDR5 Micro ATX')
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
  'MAXSUN B760 iCraft B760M CROSS LGA1700 DDR5 Micro ATX',
  4000,
  '{"manufacturer":"MAXSUN","socket":"LGA1700","cpuSocket":"LGA1700","formFactor":"Micro ATX","chipset":"Intel B760","memory":{"max":192,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"7","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b7c8865ad0c3553db043"},{"gen":"4.0","quantity":1,"lanes":4,"_id":"67f9b7c8865ad0c3553db044"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9b7c8865ad0c3553db045"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MAXSUN B760 iCraft B760M CROSS LGA1700 DDR5 Micro ATX')
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
  'Asus B560 PRIME B560M-A AC LGA1200 DDR4 Micro ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1200","cpuSocket":"LGA1200","formFactor":"Micro ATX","chipset":"Intel B560","memory":{"max":128,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b824865ad0c3553dbae8"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9b824865ad0c3553dbae9"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus B560 PRIME B560M-A AC LGA1200 DDR4 Micro ATX')
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
  'Asus B650 PRIME B650-PLUS WIFI AM5 DDR5 ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"AM5","cpuSocket":"AM5","formFactor":"ATX","chipset":"AMD B650","memory":{"max":192,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"4","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b844865ad0c3553dbe45"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b844865ad0c3553dbe46"}],"wifi":true}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus B650 PRIME B650-PLUS WIFI AM5 DDR5 ATX')
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
  'Gigabyte A520 M H AM4 DDR4 Micro ATX',
  4000,
  '{"manufacturer":"Gigabyte","socket":"AM4","cpuSocket":"AM4","formFactor":"Micro ATX","chipset":"AMD A520","memory":{"max":64,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b8a0865ad0c3553dc88c"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b8a0865ad0c3553dc88d"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte A520 M H AM4 DDR4 Micro ATX')
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
  'Asus Z370 ROG Strix Z370-H Gaming DDR4 ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"ATX","chipset":"Intel Z370","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9b75c865ad0c3553da53e"},{"gen":"4.0","quantity":3,"lanes":1,"_id":"67f9b75c865ad0c3553da53f"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus Z370 ROG Strix Z370-H Gaming DDR4 ATX')
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
  'Gigabyte B850 AI TOP AM5 DDR5 ATX',
  4000,
  '{"manufacturer":"Gigabyte","socket":"AM5","cpuSocket":"AM5","formFactor":"ATX","chipset":"AMD B850","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"6","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9ba51865ad0c3553df885"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte B850 AI TOP AM5 DDR5 ATX')
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
  'Asus Z890 MAX GAMING WIFI7 DDR5 ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1851","cpuSocket":"LGA1851","formFactor":"ATX","chipset":"Intel Z890","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"7","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":4,"lanes":16,"_id":"67f9bafb865ad0c3553e0b45"}],"wifi":true}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus Z890 MAX GAMING WIFI7 DDR5 ATX')
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
  'Asus B650 PRIME B650M-A II-CSM DDR5 Micro ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"AM5","cpuSocket":"AM5","formFactor":"Micro ATX","chipset":"AMD B650","memory":{"max":192,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"4","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f99e84865ad0c3553c4278"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus B650 PRIME B650M-A II-CSM DDR5 Micro ATX')
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
  'ASRock B360M ITX/ac DDR4 Mini ITX',
  4000,
  '{"manufacturer":"ASRock","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"Mini-ITX","chipset":"Intel B360","memory":{"max":32,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9ba02865ad0c3553df010"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock B360M ITX/ac DDR4 Mini ITX')
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
  'Gigabyte Z390 AORUS ULTRA ATX LGA1151',
  4000,
  '{"manufacturer":"Gigabyte","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"ATX","chipset":"Intel Z390","memory":{"max":128,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67d30ffe68a3131be60127a0"},{"gen":"4.0","quantity":3,"lanes":1,"_id":"67d30ffe68a3131be60127a1"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte Z390 AORUS ULTRA ATX LGA1151')
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
  'Asus B150 M-A/M.2 LGA1151 DDR4 Micro ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"Micro ATX","chipset":"Intel B150","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b781865ad0c3553da968"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b781865ad0c3553da969"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus B150 M-A/M.2 LGA1151 DDR4 Micro ATX')
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
  'Supermicro Intel C602 X9SRA LGA2011 DDR3 ATX',
  4000,
  '{"manufacturer":"Supermicro","socket":"LGA2011","cpuSocket":"LGA2011","formFactor":"ATX","chipset":"Intel C602","memory":{"max":64,"ram_type":"DDR3","slots":8},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"0","sataPorts":"2","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b7bb865ad0c3553daf40"},{"gen":"4.0","quantity":2,"lanes":8,"_id":"67f9b7bb865ad0c3553daf41"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Supermicro Intel C602 X9SRA LGA2011 DDR3 ATX')
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
  'Gigabyte AMD 970 GA-970A-DS3 AM3+ DDR3 ATX',
  4000,
  '{"manufacturer":"Gigabyte","socket":"AM3+","cpuSocket":"AM3+","formFactor":"ATX","chipset":"AMD 970","memory":{"max":32,"ram_type":"DDR3","slots":4},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"0","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9bb7f865ad0c3553e1982"},{"gen":"4.0","quantity":3,"lanes":1,"_id":"67f9bb7f865ad0c3553e1983"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte AMD 970 GA-970A-DS3 AM3+ DDR3 ATX')
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
  'Biostar Z590 MHP DDR4 Micro ATX',
  4000,
  '{"manufacturer":"Biostar","socket":"LGA1200","cpuSocket":"LGA1200","formFactor":"Micro ATX","chipset":"Intel Z590","memory":{"max":64,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"68cb89d09b67bc35527b4639"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"68cb89d09b67bc35527b463a"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Biostar Z590 MHP DDR4 Micro ATX')
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
  'Asus Z270 TUF MARK 1 DDR4 ATX LGA1151',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"ATX","chipset":"Intel Z270","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9ba15865ad0c3553df210"},{"gen":"4.0","quantity":3,"lanes":1,"_id":"67f9ba15865ad0c3553df211"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus Z270 TUF MARK 1 DDR4 ATX LGA1151')
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
  'MSI Z270 GAMING M5 DDR4 ATX',
  4000,
  '{"manufacturer":"MSI","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"ATX","chipset":"Intel Z270","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9b7a2865ad0c3553dacb2"},{"gen":"4.0","quantity":3,"lanes":1,"_id":"67f9b7a2865ad0c3553dacb3"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI Z270 GAMING M5 DDR4 ATX')
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
  'MSI Z790 MPG EDGE MONSTER HUNTER EDITION DDR5 ATX',
  4000,
  '{"manufacturer":"MSI","socket":"LGA1700","cpuSocket":"LGA1700","formFactor":"ATX","chipset":"Intel Z790","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"10","sataPorts":"8","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b76f865ad0c3553da763"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9b76f865ad0c3553da764"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI Z790 MPG EDGE MONSTER HUNTER EDITION DDR5 ATX')
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
  'Asus Z270 MAXIMUS IX APEX LGA1151 DDR4 EATX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"EATX","chipset":"Intel Z270","memory":{"max":32,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":4,"lanes":16,"_id":"67f9b901865ad0c3553dd3df"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b901865ad0c3553dd3e0"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus Z270 MAXIMUS IX APEX LGA1151 DDR4 EATX')
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
  'Asus B850 TUF GAMING B850-BTF WIFI W AM5 DDR5 ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"AM5","cpuSocket":"AM5","formFactor":"ATX","chipset":"AMD B850","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"4","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"680e7d0f53adf782a1c6fd16"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"680e7d0f53adf782a1c6fd17"}],"wifi":true}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus B850 TUF GAMING B850-BTF WIFI W AM5 DDR5 ATX')
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
  'Gigabyte B760 DS3H AX DDR5 ATX',
  4000,
  '{"manufacturer":"Gigabyte","socket":"LGA1700","cpuSocket":"LGA1700","formFactor":"ATX","chipset":"Intel B760","memory":{"max":192,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"3","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":5,"lanes":16,"_id":"67f9ba9d865ad0c3553e00fd"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte B760 DS3H AX DDR5 ATX')
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
  'MSI B650 GAMING PLUS WIFI DDR5 ATX',
  4000,
  '{"manufacturer":"MSI","socket":"AM5","cpuSocket":"AM5","formFactor":"ATX","chipset":"AMD B650","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"2","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f99e94865ad0c3553c4386"},{"gen":"4.0","quantity":1,"lanes":4,"_id":"67f99e94865ad0c3553c4387"},{"gen":"3.0","quantity":1,"lanes":1,"_id":"68ee43a668f24615d9ad8822"}],"wifi":true}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI B650 GAMING PLUS WIFI DDR5 ATX')
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
  'MSI Z890 MAG TOMAHAWK WIFI DDR5 ATX LGA1851',
  4000,
  '{"manufacturer":"MSI","socket":"LGA1851","cpuSocket":"LGA1851","formFactor":"ATX","chipset":"Intel Z890","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"8","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9b774865ad0c3553da7bd"}],"wifi":true}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI Z890 MAG TOMAHAWK WIFI DDR5 ATX LGA1851')
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
  'ASRock 990FX Killer/3.1 DDR3 ATX',
  4000,
  '{"manufacturer":"ASRock","socket":"AM3+","cpuSocket":"AM3+","formFactor":"ATX","chipset":"AMD 990FX","memory":{"max":64,"ram_type":"DDR3","slots":4},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"2","sataPorts":"5","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9b85d865ad0c3553dc131"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b85d865ad0c3553dc132"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock 990FX Killer/3.1 DDR3 ATX')
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
  'Gigabyte B360M HD3 DDR4 Micro ATX LGA1151',
  4000,
  '{"manufacturer":"Gigabyte","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"Micro ATX","chipset":"Intel B360","memory":{"max":32,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b81e865ad0c3553dba37"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b81e865ad0c3553dba38"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte B360M HD3 DDR4 Micro ATX LGA1151')
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
  'MSI X299 TOMAHAWK ARCTIC DDR4 ATX',
  4000,
  '{"manufacturer":"MSI","socket":"LGA2066","cpuSocket":"LGA2066","formFactor":"ATX","chipset":"Intel X299","memory":{"max":256,"ram_type":"DDR4","slots":8},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"8","pcieSlots":[{"gen":"4.0","quantity":4,"lanes":16,"_id":"67f9ba97865ad0c3553e0083"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9ba97865ad0c3553e0084"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI X299 TOMAHAWK ARCTIC DDR4 ATX')
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
  'ASRock Z890 Phantom Gaming Nova WiFi DDR5 ATX',
  4000,
  '{"manufacturer":"ASRock","socket":"LGA1851","cpuSocket":"LGA1851","formFactor":"ATX","chipset":"Intel Z890","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"12","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b6f0865ad0c3553d9951"}],"wifi":true}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock Z890 Phantom Gaming Nova WiFi DDR5 ATX')
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
  'Asus A520 PRIME M-R-CSM AM4 DDR4 Micro ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"AM4","cpuSocket":"AM4","formFactor":"Micro ATX","chipset":"AMD A520","memory":{"max":64,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9bb16865ad0c3553e0e17"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9bb16865ad0c3553e0e18"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus A520 PRIME M-R-CSM AM4 DDR4 Micro ATX')
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
  'Asus Z68 P8 DDR3 ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1155","cpuSocket":"LGA1155","formFactor":"ATX","chipset":"Intel Z68","memory":{"max":32,"ram_type":"DDR3","slots":4},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"0","sataPorts":"2","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9b841865ad0c3553dbdbb"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b841865ad0c3553dbdbc"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus Z68 P8 DDR3 ATX')
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
  'MSI B460M MAG BAZOOKA DDR4 Micro ATX',
  4000,
  '{"manufacturer":"MSI","socket":"LGA1200","cpuSocket":"LGA1200","formFactor":"Micro ATX","chipset":"Intel B460","memory":{"max":128,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b744865ad0c3553da297"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b744865ad0c3553da298"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI B460M MAG BAZOOKA DDR4 Micro ATX')
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
  'Gigabyte GA-Z77-D3H ATX LGA1155',
  4000,
  '{"manufacturer":"Gigabyte","socket":"LGA1155","cpuSocket":"LGA1155","formFactor":"ATX","chipset":"Intel Z77","memory":{"max":32,"ram_type":"DDR3","slots":4},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"0","sataPorts":"2","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67d3100568a3131be6015f69"},{"gen":"4.0","quantity":3,"lanes":1,"_id":"67d3100568a3131be6015f6a"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte GA-Z77-D3H ATX LGA1155')
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
  'ASRock X99 Taichi LGA2011-3 DDR4 ATX',
  4000,
  '{"manufacturer":"ASRock","socket":"LGA2011-3","cpuSocket":"LGA2011-3","formFactor":"ATX","chipset":"Intel X99","memory":{"max":128,"ram_type":"DDR4","slots":8},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"10","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9b7c5865ad0c3553daff3"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b7c5865ad0c3553daff4"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock X99 Taichi LGA2011-3 DDR4 ATX')
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
  'Asus B450 PRIME B450-PLUS AM4 DDR4 ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"AM4","cpuSocket":"AM4","formFactor":"ATX","chipset":"AMD B450","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b7d0865ad0c3553db168"},{"gen":"4.0","quantity":3,"lanes":1,"_id":"67f9b7d0865ad0c3553db169"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus B450 PRIME B450-PLUS AM4 DDR4 ATX')
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
  'Gigabyte Z890 AORUS ELITE X ICE DDR5 ATX',
  4000,
  '{"manufacturer":"Gigabyte","socket":"LGA1851","cpuSocket":"LGA1851","formFactor":"ATX","chipset":"Intel Z890","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"8","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9babc865ad0c3553e048e"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte Z890 AORUS ELITE X ICE DDR5 ATX')
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
  'Gigabyte GA-H87-HD3 ATX LGA1150',
  4000,
  '{"manufacturer":"Gigabyte","socket":"LGA1150","cpuSocket":"LGA1150","formFactor":"ATX","chipset":"Intel H87","memory":{"max":32,"ram_type":"DDR3","slots":4},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"0","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67d30ffe68a3131be60124ea"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67d30ffe68a3131be60124eb"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte GA-H87-HD3 ATX LGA1150')
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
  'ASRock A520 A520M-HDVP/DASH AM4 DDR4 Micro ATX',
  4000,
  '{"manufacturer":"ASRock","socket":"AM4","cpuSocket":"AM4","formFactor":"Micro ATX","chipset":"AMD A520","memory":{"max":64,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"1","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b76a865ad0c3553da705"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b76a865ad0c3553da706"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock A520 A520M-HDVP/DASH AM4 DDR4 Micro ATX')
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
  'Asus Z270 ROG STRIX Z270G GAMING DDR4 Micro ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"Micro ATX","chipset":"Intel Z270","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b927865ad0c3553dd7b8"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b927865ad0c3553dd7b9"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus Z270 ROG STRIX Z270G GAMING DDR4 Micro ATX')
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
  'Asus H610 PRIME H610M-K LGA1700 DDR5 Micro ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1700","cpuSocket":"LGA1700","formFactor":"Micro ATX","chipset":"Intel H610","memory":{"max":96,"ram_type":"DDR5","slots":2},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"2","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9bb33865ad0c3553e1134"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9bb33865ad0c3553e1135"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus H610 PRIME H610M-K LGA1700 DDR5 Micro ATX')
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
  'MSI Intel Z77 Z77A-G45 Thunderbolt LGA1155 DDR3 ATX',
  4000,
  '{"manufacturer":"MSI","socket":"LGA1155","cpuSocket":"LGA1155","formFactor":"ATX","chipset":"Intel Z77","memory":{"max":32,"ram_type":"DDR3","slots":4},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"0","sataPorts":"2","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9b825865ad0c3553dbb07"},{"gen":"4.0","quantity":4,"lanes":1,"_id":"67f9b825865ad0c3553dbb08"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI Intel Z77 Z77A-G45 Thunderbolt LGA1155 DDR3 ATX')
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
  'Asus 990FX TUF SABERTOOTH R3.0 DDR3 ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"AM3+","cpuSocket":"AM3+","formFactor":"ATX","chipset":"AMD 990FX","memory":{"max":32,"ram_type":"DDR3","slots":4},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"2","sataPorts":"5","pcieSlots":[{"gen":"4.0","quantity":4,"lanes":16,"_id":"67f9b7f6865ad0c3553db5cb"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b7f6865ad0c3553db5cc"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus 990FX TUF SABERTOOTH R3.0 DDR3 ATX')
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
  'ASRock AMD A88X FM2A88M PRO3+ FM2+ DDR3 Micro ATX',
  4000,
  '{"manufacturer":"ASRock","socket":"FM2+","cpuSocket":"FM2+","formFactor":"Micro ATX","chipset":"AMD A88X","memory":{"max":64,"ram_type":"DDR3","slots":4},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"0","sataPorts":"8","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b730865ad0c3553da091"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b730865ad0c3553da092"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock AMD A88X FM2A88M PRO3+ FM2+ DDR3 Micro ATX')
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
  'ASRock Z390 STEEL LEGEND DDR4 ATX',
  4000,
  '{"manufacturer":"ASRock","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"ATX","chipset":"Intel Z390","memory":{"max":128,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"5","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b75a865ad0c3553da4dd"},{"gen":"4.0","quantity":3,"lanes":1,"_id":"67f9b75a865ad0c3553da4de"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock Z390 STEEL LEGEND DDR4 ATX')
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
  'Asus H510 PRIME H510M-A R2.0 DDR4 Micro ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1200","cpuSocket":"LGA1200","formFactor":"Micro ATX","chipset":"Intel H470","memory":{"max":64,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b9e5865ad0c3553decd7"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b9e5865ad0c3553decd8"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus H510 PRIME H510M-A R2.0 DDR4 Micro ATX')
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
  'Asus B250F STRIX GAMING DDR4 ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"ATX","chipset":"Intel B250","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9ba38865ad0c3553df595"},{"gen":"4.0","quantity":4,"lanes":1,"_id":"67f9ba38865ad0c3553df596"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus B250F STRIX GAMING DDR4 ATX')
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
  'Asus PRIME B550M-A WI-FI DDR4 Micro ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"AM4","cpuSocket":"AM4","formFactor":"Micro ATX","chipset":"AMD B550","memory":{"max":128,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b918865ad0c3553dd67e"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b918865ad0c3553dd67f"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus PRIME B550M-A WI-FI DDR4 Micro ATX')
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
  'MSI B560M PRO DDR4 Micro ATX',
  4000,
  '{"manufacturer":"MSI","socket":"LGA1200","cpuSocket":"LGA1200","formFactor":"Micro ATX","chipset":"Intel B560","memory":{"max":64,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b814865ad0c3553db8ec"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b814865ad0c3553db8ed"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI B560M PRO DDR4 Micro ATX')
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
  'ASRock A620 AM Pro RS WiFi AM5 DDR5 Micro ATX',
  4000,
  '{"manufacturer":"ASRock","socket":"AM5","cpuSocket":"AM5","formFactor":"Micro ATX","chipset":"AMD A620","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"7","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"68cb89d99b67bc35527b49ea"},{"gen":"4.0","quantity":1,"lanes":4,"_id":"68cb89d99b67bc35527b49eb"}],"wifi":true}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock A620 AM Pro RS WiFi AM5 DDR5 Micro ATX')
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
  'MSI Z170A MPOWER GAMING TITANIUM DDR4 ATX',
  4000,
  '{"manufacturer":"MSI","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"ATX","chipset":"Intel Z170","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9b963865ad0c3553dde67"},{"gen":"4.0","quantity":3,"lanes":1,"_id":"67f9b963865ad0c3553dde68"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI Z170A MPOWER GAMING TITANIUM DDR4 ATX')
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
  'ASRock Z590 Phantom Gaming-ITX/TB4 DDR4 Mini ITX',
  4000,
  '{"manufacturer":"ASRock","socket":"LGA1200","cpuSocket":"LGA1200","formFactor":"Mini-ITX","chipset":"Intel Z590","memory":{"max":64,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"3","sataPorts":"3","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b74e865ad0c3553da39e"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock Z590 Phantom Gaming-ITX/TB4 DDR4 Mini ITX')
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
  'MSI Z590 MPG Z590M GAMING EDGE WIFI LGA1200 DDR4 Micro ATX',
  4000,
  '{"manufacturer":"MSI","socket":"LGA1200","cpuSocket":"LGA1200","formFactor":"Micro ATX","chipset":"Intel Z590","memory":{"max":128,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"5","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b920865ad0c3553dd748"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9b920865ad0c3553dd749"}],"wifi":true}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI Z590 MPG Z590M GAMING EDGE WIFI LGA1200 DDR4 Micro ATX')
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
  'MSI B850M MAG MORTAR WIFI AM5 DDR5 Micro ATX',
  4000,
  '{"manufacturer":"MSI","socket":"AM5","cpuSocket":"AM5","formFactor":"Micro ATX","chipset":"AMD B850","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"6","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9ba45865ad0c3553df75a"},{"gen":"4.0","quantity":1,"lanes":8,"_id":"67f9ba45865ad0c3553df75b"}],"wifi":true}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI B850M MAG MORTAR WIFI AM5 DDR5 Micro ATX')
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
  'Asus H610 PRIME M-D D4 LGA1700 DDR4 Micro ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1700","cpuSocket":"LGA1700","formFactor":"Micro ATX","chipset":"Intel H610","memory":{"max":64,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b881865ad0c3553dc535"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9b881865ad0c3553dc536"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus H610 PRIME M-D D4 LGA1700 DDR4 Micro ATX')
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
  'ASRock Z590M-ITX/ax LGA 1200 Mini ITX Intel Motherboard',
  4000,
  '{"manufacturer":"ASRock","socket":"LGA1200","cpuSocket":"LGA1200","formFactor":"Mini-ITX","chipset":"Intel Z590","memory":{"max":64,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"3","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67bd1f60ffe635ea35f9713e"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock Z590M-ITX/ax LGA 1200 Mini ITX Intel Motherboard')
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
  'ASRock Z590 Extreme LGA1200 DDR4 ATX',
  4000,
  '{"manufacturer":"ASRock","socket":"LGA1200","cpuSocket":"LGA1200","formFactor":"ATX","chipset":"Intel Z590","memory":{"max":128,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"7","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9bae6865ad0c3553e091b"},{"gen":"4.0","quantity":3,"lanes":1,"_id":"67f9bae6865ad0c3553e091c"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock Z590 Extreme LGA1200 DDR4 ATX')
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
  'ASRock X470 Taichi ATX AM4',
  4000,
  '{"manufacturer":"ASRock","socket":"AM4","cpuSocket":"AM4","formFactor":"ATX","chipset":"AMD X470","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"5","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67e0a42cdeff7733a73faf72"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67e0a42cdeff7733a73faf73"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock X470 Taichi ATX AM4')
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
  'MSI H110 H110M PRO-D DDR4 Micro ATX',
  4000,
  '{"manufacturer":"MSI","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"Micro ATX","chipset":"Intel H110","memory":{"max":32,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"0","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b6d3865ad0c3553d9608"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b6d3865ad0c3553d9609"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI H110 H110M PRO-D DDR4 Micro ATX')
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
  'Gigabyte AMD X370 GA-AX370-GAMING 5 DDR4 ATX',
  4000,
  '{"manufacturer":"Gigabyte","socket":"AM4","cpuSocket":"AM4","formFactor":"ATX","chipset":"AMD X370","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"8","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9b97b865ad0c3553de137"},{"gen":"4.0","quantity":3,"lanes":1,"_id":"67f9b97b865ad0c3553de138"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte AMD X370 GA-AX370-GAMING 5 DDR4 ATX')
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
  'Asus H610 PRIME H610I-PLUS D4-CSM DDR4 Mini ITX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1700","cpuSocket":"LGA1700","formFactor":"Mini-ITX","chipset":"Intel H610","memory":{"max":64,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"3","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b860865ad0c3553dc192"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus H610 PRIME H610I-PLUS D4-CSM DDR4 Mini ITX')
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
  'Asus B75 P8B75-M/CSM LGA1155 DDR3 Micro ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1155","cpuSocket":"LGA1155","formFactor":"Micro ATX","chipset":"Intel B75","memory":{"max":32,"ram_type":"DDR3","slots":4},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"0","sataPorts":"1","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b754865ad0c3553da468"},{"gen":"4.0","quantity":1,"lanes":4,"_id":"67f9b754865ad0c3553da469"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus B75 P8B75-M/CSM LGA1155 DDR3 Micro ATX')
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
  'Gigabyte Z270 GA-Z270XP-SLI DDR4 ATX',
  4000,
  '{"manufacturer":"Gigabyte","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"ATX","chipset":"Intel Z270","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9b769865ad0c3553da6e8"},{"gen":"4.0","quantity":3,"lanes":1,"_id":"67f9b769865ad0c3553da6e9"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte Z270 GA-Z270XP-SLI DDR4 ATX')
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
  'B460M D3H',
  4000,
  '{"manufacturer":"Gigabyte","socket":"LGA1200","cpuSocket":"LGA1200","formFactor":"Micro ATX","chipset":"Intel B460","memory":{"max":128,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"6","pcieSlots":[{"gen":"3.0","quantity":1,"lanes":16,"_id":"67bbaca0656a333a9fdf7090"},{"gen":"3.0","quantity":1,"lanes":4,"_id":"67bbaca0656a333a9fdf7091"},{"gen":"3.0","quantity":1,"lanes":1,"_id":"67bbaca0656a333a9fdf7092"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('B460M D3H')
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
  'Biostar B550 MXC PRO DDR4 Micro ATX',
  4000,
  '{"manufacturer":"Biostar","socket":"AM4","cpuSocket":"AM4","formFactor":"Micro ATX","chipset":"AMD B550","memory":{"max":128,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"8","pcieSlots":[{"gen":"4.0","quantity":4,"lanes":16,"_id":"67f9b716865ad0c3553d9d85"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Biostar B550 MXC PRO DDR4 Micro ATX')
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
  'MSI B350I PRO AC AM4 DDR4 Mini ITX',
  4000,
  '{"manufacturer":"MSI","socket":"AM4","cpuSocket":"AM4","formFactor":"Mini-ITX","chipset":"AMD B350","memory":{"max":32,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9bb43865ad0c3553e12f1"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI B350I PRO AC AM4 DDR4 Mini ITX')
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
  'Colorful X570M CVN GAMING FROZEN V14 AM4 DDR4 Micro ATX',
  4000,
  '{"manufacturer":"Colorful","socket":"AM4","cpuSocket":"AM4","formFactor":"Micro ATX","chipset":"AMD X570","memory":{"max":128,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b7d0865ad0c3553db153"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9b7d0865ad0c3553db154"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Colorful X570M CVN GAMING FROZEN V14 AM4 DDR4 Micro ATX')
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
  'Gigabyte H110M GA-H110M-S2H GSM DDR4 Micro ATX',
  4000,
  '{"manufacturer":"Gigabyte","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"Micro ATX","chipset":"Intel H110","memory":{"max":32,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"0","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b86f865ad0c3553dc33e"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b86f865ad0c3553dc33f"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte H110M GA-H110M-S2H GSM DDR4 Micro ATX')
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
  'Asus Z270 PRIME AR DDR4 ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"ATX","chipset":"Intel Z270","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9b900865ad0c3553dd3be"},{"gen":"4.0","quantity":4,"lanes":1,"_id":"67f9b900865ad0c3553dd3bf"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus Z270 PRIME AR DDR4 ATX')
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
  'ASUS TUF Gaming Z590-PLUS WIFI DDR4 ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1200","cpuSocket":"LGA1200","formFactor":"ATX","chipset":"Intel Z590","memory":{"max":128,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"6","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b9f6865ad0c3553deec8"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b9f6865ad0c3553deec9"}],"wifi":true}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASUS TUF Gaming Z590-PLUS WIFI DDR4 ATX')
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
  'ASRock Z690M PG RIPTIDE/D5 DDR5 Micro ATX',
  4000,
  '{"manufacturer":"ASRock","socket":"LGA1700","cpuSocket":"LGA1700","formFactor":"Micro ATX","chipset":"Intel Z690","memory":{"max":192,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"5","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9ba21865ad0c3553df35e"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9ba21865ad0c3553df35f"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock Z690M PG RIPTIDE/D5 DDR5 Micro ATX')
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
  'MSI X299 GAMING PRO CARBON LGA2066 DDR4 ATX',
  4000,
  '{"manufacturer":"MSI","socket":"LGA2066","cpuSocket":"LGA2066","formFactor":"ATX","chipset":"Intel X299","memory":{"max":128,"ram_type":"DDR4","slots":8},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"8","pcieSlots":[{"gen":"4.0","quantity":4,"lanes":16,"_id":"67f9b6e8865ad0c3553d986c"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b6e8865ad0c3553d986d"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI X299 GAMING PRO CARBON LGA2066 DDR4 ATX')
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
  'Supermicro Intel C612 MBD-X10DAX Dual-CPU LGA2011-3 DDR4 EATX',
  4000,
  '{"manufacturer":"Supermicro","socket":"2 x LGA2011-3","cpuSocket":"2 x LGA2011-3","formFactor":"EATX","chipset":"Intel C612","memory":{"max":2048,"ram_type":"DDR4","slots":16},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"0","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9baf8865ad0c3553e0add"},{"gen":"4.0","quantity":3,"lanes":8,"_id":"67f9baf8865ad0c3553e0ade"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Supermicro Intel C612 MBD-X10DAX Dual-CPU LGA2011-3 DDR4 EATX')
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
  'ASRock B350 AB350M-HDV DDR4 Micro ATX',
  4000,
  '{"manufacturer":"ASRock","socket":"AM4","cpuSocket":"AM4","formFactor":"Micro ATX","chipset":"AMD B350","memory":{"max":32,"ram_type":"DDR4","slots":2},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b998865ad0c3553de473"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9b998865ad0c3553de474"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock B350 AB350M-HDV DDR4 Micro ATX')
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
  'MSI X99 X99A Raider LGA2011-3 DDR4 ATX',
  4000,
  '{"manufacturer":"MSI","socket":"LGA2011-3","cpuSocket":"LGA2011-3","formFactor":"ATX","chipset":"Intel X99","memory":{"max":128,"ram_type":"DDR4","slots":8},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"10","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9bb4a865ad0c3553e1398"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9bb4a865ad0c3553e1399"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI X99 X99A Raider LGA2011-3 DDR4 ATX')
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
  'Asus B760 TUF GAMING B760M-PLUS WIFI II LGA1700 DDR5 Micro ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1700","cpuSocket":"LGA1700","formFactor":"Micro ATX","chipset":"Intel B760","memory":{"max":192,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"6","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b92c865ad0c3553dd883"},{"gen":"4.0","quantity":1,"lanes":4,"_id":"67f9b92c865ad0c3553dd884"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9b92c865ad0c3553dd885"}],"wifi":true}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus B760 TUF GAMING B760M-PLUS WIFI II LGA1700 DDR5 Micro ATX')
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
  'MSI X470 GAMING M7 AC AM4 DDR4 ATX',
  4000,
  '{"manufacturer":"MSI","socket":"AM4","cpuSocket":"AM4","formFactor":"ATX","chipset":"AMD X470","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9b947865ad0c3553ddb9a"},{"gen":"4.0","quantity":3,"lanes":1,"_id":"67f9b947865ad0c3553ddb9b"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI X470 GAMING M7 AC AM4 DDR4 ATX')
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
  'Asus Z890 ROG MAXIMUS HERO BTF LGA1851 DDR5 ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1851","cpuSocket":"LGA1851","formFactor":"ATX","chipset":"Intel Z890","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"10","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":4,"_id":"67f9b934865ad0c3553dd955"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9b934865ad0c3553dd956"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus Z890 ROG MAXIMUS HERO BTF LGA1851 DDR5 ATX')
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
  'MSI B365 PRO-VDH DDR4 Micro ATX',
  4000,
  '{"manufacturer":"MSI","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"Micro ATX","chipset":"Intel B365","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b71b865ad0c3553d9e1f"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b71b865ad0c3553d9e20"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI B365 PRO-VDH DDR4 Micro ATX')
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
  'Asus TUF GAMING B550-PLUS ATX AM4',
  4000,
  '{"manufacturer":"ASUS","socket":"AM4","cpuSocket":"AM4","formFactor":"ATX","chipset":"AMD B550","memory":{"max":128,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"5","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67e0a431deff7733a73fe4d2"},{"gen":"4.0","quantity":3,"lanes":1,"_id":"67e0a431deff7733a73fe4d3"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus TUF GAMING B550-PLUS ATX AM4')
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
  'Asus B650 TUF GAMING E WIFI DDR5 ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"AM5","cpuSocket":"AM5","formFactor":"ATX","chipset":"AMD B650","memory":{"max":192,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"6","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b754865ad0c3553da459"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9b754865ad0c3553da45a"}],"wifi":true}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus B650 TUF GAMING E WIFI DDR5 ATX')
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
  'MSI B150M BAZOOKA LGA1151 DDR4 Micro ATX',
  4000,
  '{"manufacturer":"MSI","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"Micro ATX","chipset":"Intel B150","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"0","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b73b865ad0c3553da190"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b73b865ad0c3553da191"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI B150M BAZOOKA LGA1151 DDR4 Micro ATX')
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
  'Asus A88X A88XM-A/USB 3.1 FM2+ DDR3 Micro ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"FM2+","cpuSocket":"FM2+","formFactor":"Micro ATX","chipset":"AMD A88X","memory":{"max":64,"ram_type":"DDR3","slots":4},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"0","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b8eb865ad0c3553dd15e"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9b8eb865ad0c3553dd15f"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus A88X A88XM-A/USB 3.1 FM2+ DDR3 Micro ATX')
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
  'ASRock Z890M Riptide WiFi DDR5 Micro ATX',
  4000,
  '{"manufacturer":"ASRock","socket":"LGA1851","cpuSocket":"LGA1851","formFactor":"Micro ATX","chipset":"Intel Z890","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"4","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b854865ad0c3553dbfd4"}],"wifi":true}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock Z890M Riptide WiFi DDR5 Micro ATX')
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
  'MSI Z690 MEG UNIFY-X DDR5 ATX',
  4000,
  '{"manufacturer":"MSI","socket":"LGA1700","cpuSocket":"LGA1700","formFactor":"ATX","chipset":"Intel Z690","memory":{"max":96,"ram_type":"DDR5","slots":2},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"11","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b897865ad0c3553dc76d"},{"gen":"4.0","quantity":1,"lanes":4,"_id":"67f9b897865ad0c3553dc76e"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI Z690 MEG UNIFY-X DDR5 ATX')
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
  'Gigabyte Z77 GA-Z77X-UD5H LGA1155 DDR3 ATX',
  4000,
  '{"manufacturer":"Gigabyte","socket":"LGA1155","cpuSocket":"LGA1155","formFactor":"ATX","chipset":"Intel Z77","memory":{"max":32,"ram_type":"DDR3","slots":4},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"0","sataPorts":"5","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9b704865ad0c3553d9bb2"},{"gen":"4.0","quantity":3,"lanes":1,"_id":"67f9b704865ad0c3553d9bb3"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte Z77 GA-Z77X-UD5H LGA1155 DDR3 ATX')
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
  'Gigabyte B650E AORUS TACHYON DDR5 ATX',
  4000,
  '{"manufacturer":"Gigabyte","socket":"AM5","cpuSocket":"AM5","formFactor":"ATX","chipset":"AMD B650E","memory":{"max":96,"ram_type":"DDR5","slots":2},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"6","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b789865ad0c3553daa02"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte B650E AORUS TACHYON DDR5 ATX')
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
  'EVGA P55 P55V LGA1156 DDR3 Micro ATX',
  4000,
  '{"manufacturer":"EVGA","socket":"LGA1156","cpuSocket":"LGA1156","formFactor":"Micro ATX","chipset":"Intel P55","memory":{"max":16,"ram_type":"DDR3","slots":4},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"0","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"688ec9193ebf909c29b7cb74"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"688ec9193ebf909c29b7cb75"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('EVGA P55 P55V LGA1156 DDR3 Micro ATX')
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
  'Gigabyte Z97 GA-Z97M-D3H LGA1150 DDR3 Micro ATX',
  4000,
  '{"manufacturer":"Gigabyte","socket":"LGA1150","cpuSocket":"LGA1150","formFactor":"Micro ATX","chipset":"Intel Z97","memory":{"max":32,"ram_type":"DDR3","slots":4},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"0","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9bae3865ad0c3553e08ad"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte Z97 GA-Z97M-D3H LGA1150 DDR3 Micro ATX')
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
  'MSI X99 X99S SLI Plus LGA2011-3 DDR4 ATX',
  4000,
  '{"manufacturer":"MSI","socket":"LGA2011-3","cpuSocket":"LGA2011-3","formFactor":"ATX","chipset":"Intel X99","memory":{"max":128,"ram_type":"DDR4","slots":8},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"10","pcieSlots":[{"gen":"4.0","quantity":4,"lanes":16,"_id":"67f9b6d7865ad0c3553d9681"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b6d7865ad0c3553d9682"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI X99 X99S SLI Plus LGA2011-3 DDR4 ATX')
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
  'MSI A520 A520M PRO-VDH DDR4 Micro ATX',
  4000,
  '{"manufacturer":"MSI","socket":"AM4","cpuSocket":"AM4","formFactor":"Micro ATX","chipset":"AMD A520","memory":{"max":128,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"4","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b6bd865ad0c3553d93ad"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b6bd865ad0c3553d93ae"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI A520 A520M PRO-VDH DDR4 Micro ATX')
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
  'PRO Z690-A WIFI DDR4',
  4000,
  '{"manufacturer":"MSI","socket":"LGA1700","cpuSocket":"LGA1700","formFactor":"ATX","chipset":"Intel Z690","memory":{"max":128,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"6","pcieSlots":[{"gen":"5.0","quantity":1,"lanes":16,"_id":"67742be90332ee368188e31c"},{"gen":"3.0","quantity":2,"lanes":4,"_id":"67742be90332ee368188e31d"},{"gen":"3.0","quantity":1,"lanes":1,"_id":"67742be90332ee368188e31e"}],"wifi":true}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('PRO Z690-A WIFI DDR4')
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
  'Gigabyte AMD 785G GA-MA785GM-US2H AM3/AM2+/AM2 DDR2 Micro ATX',
  4000,
  '{"manufacturer":"Gigabyte","socket":"AM3","cpuSocket":"AM3","formFactor":"Micro ATX","chipset":"AMD 785G","memory":{"max":16,"ram_type":"DDR2","slots":4},"memoryType":"DDR2","ram_type":"DDR2","memorySupport":"DDR2","m2Slots":"0","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":1,"lanes":16,"_id":"67f9b8ab865ad0c3553dc983"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9b8ab865ad0c3553dc984"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte AMD 785G GA-MA785GM-US2H AM3/AM2+/AM2 DDR2 Micro ATX')
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
  'Asus AMD X370 ROG CROSSHAIR VI EXTREME AM4 DDR4 EATX',
  4000,
  '{"manufacturer":"ASUS","socket":"AM4","cpuSocket":"AM4","formFactor":"EATX","chipset":"AMD X370","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"8","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9b7f1865ad0c3553db503"},{"gen":"4.0","quantity":3,"lanes":1,"_id":"67f9b7f1865ad0c3553db504"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus AMD X370 ROG CROSSHAIR VI EXTREME AM4 DDR4 EATX')
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
  'Gigabyte Z170X UD3 DDR4 ATX',
  4000,
  '{"manufacturer":"Gigabyte","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"ATX","chipset":"Intel Z170","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":3,"lanes":16,"_id":"67f9bb54865ad0c3553e1487"},{"gen":"4.0","quantity":3,"lanes":1,"_id":"67f9bb54865ad0c3553e1488"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte Z170X UD3 DDR4 ATX')
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
  'Asus H87 PLUS LGA1150 DDR3 ATX',
  4000,
  '{"manufacturer":"ASUS","socket":"LGA1150","cpuSocket":"LGA1150","formFactor":"ATX","chipset":"Intel H87","memory":{"max":32,"ram_type":"DDR3","slots":4},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"0","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9ba73865ad0c3553dfc43"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9ba73865ad0c3553dfc44"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus H87 PLUS LGA1150 DDR3 ATX')
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
  'Gigabyte H370M DS3H DDR4 Micro ATX',
  4000,
  '{"manufacturer":"Gigabyte","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"Micro ATX","chipset":"Intel H370","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9ba3d865ad0c3553df639"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9ba3d865ad0c3553df63a"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte H370M DS3H DDR4 Micro ATX')
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
  'Gigabyte H170 GA-H170-D3HP LGA1151 DDR4 ATX',
  4000,
  '{"manufacturer":"Gigabyte","socket":"LGA1151","cpuSocket":"LGA1151","formFactor":"ATX","chipset":"Intel H170","memory":{"max":64,"ram_type":"DDR4","slots":4},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"2","sataPorts":"6","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b6c8865ad0c3553d94e0"},{"gen":"4.0","quantity":2,"lanes":1,"_id":"67f9b6c8865ad0c3553d94e1"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte H170 GA-H170-D3HP LGA1151 DDR4 ATX')
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
  'Gigabyte TRX40 AORUS PRO WIFI sTRX4 DDR4 ATX',
  4000,
  '{"manufacturer":"Gigabyte","socket":"sTRX4","cpuSocket":"sTRX4","formFactor":"ATX","chipset":"AMD TRX40","memory":{"max":256,"ram_type":"DDR4","slots":8},"memoryType":"DDR4","ram_type":"DDR4","memorySupport":"DDR4","m2Slots":"4","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":4,"lanes":16,"_id":"67f9ba15865ad0c3553df230"},{"gen":"4.0","quantity":1,"lanes":1,"_id":"67f9ba15865ad0c3553df231"}],"wifi":true}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte TRX40 AORUS PRO WIFI sTRX4 DDR4 ATX')
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
  'MSI B850 PRO B850-VC WIFI6E AM5 DDR5 ATX',
  4000,
  '{"manufacturer":"MSI","socket":"AM5","cpuSocket":"AM5","formFactor":"ATX","chipset":"AMD B850","memory":{"max":256,"ram_type":"DDR5","slots":4},"memoryType":"DDR5","ram_type":"DDR5","memorySupport":"DDR5","m2Slots":"7","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":4,"lanes":16,"_id":"68cb89ce9b67bc35527b4540"}],"wifi":true}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI B850 PRO B850-VC WIFI6E AM5 DDR5 ATX')
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
  'MSI AMD 970 970A GAMING PRO CARBON AM3+/AM3 DDR3 ATX',
  4000,
  '{"manufacturer":"MSI","socket":"AM3+","cpuSocket":"AM3+","formFactor":"ATX","chipset":"AMD 970","memory":{"max":32,"ram_type":"DDR3","slots":4},"memoryType":"DDR3","ram_type":"DDR3","memorySupport":"DDR3","m2Slots":"2","sataPorts":"0","pcieSlots":[{"gen":"4.0","quantity":2,"lanes":16,"_id":"67f9b6e7865ad0c3553d9857"},{"gen":"4.0","quantity":3,"lanes":1,"_id":"67f9b6e7865ad0c3553d9858"}],"wifi":false}'::jsonb,
  2,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI AMD 970 970A GAMING PRO CARBON AM3+/AM3 DDR3 ATX')
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
  'Klevv CRAS X RGB Black DDR4-3200 CL16 8GB (1x8GB)',
  2000,
  '{"manufacturer":"Klevv","memoryType":"DDR4","ram_type":"DDR4","capacity":8,"speed":"3200","speedMhz":"3200","modules":{"quantity":1,"capacity_gb":8},"casLatency":16}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Klevv CRAS X RGB Black DDR4-3200 CL16 8GB (1x8GB)')
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
  'Kingston FURY Renegade Pro Registered Black DDR5-6400 CL32 128GB (4x32GB)',
  2000,
  '{"manufacturer":"Kingston","memoryType":"DDR4","ram_type":"DDR4","capacity":128,"speed":"6400","speedMhz":"6400","modules":{"quantity":4,"capacity_gb":32},"casLatency":32}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston FURY Renegade Pro Registered Black DDR5-6400 CL32 128GB (4x32GB)')
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
  'Kingston FURY White DDR5-5600 CL40 64GB (2x32GB)',
  2000,
  '{"manufacturer":"Kingston","memoryType":"DDR4","ram_type":"DDR4","capacity":64,"speed":"5600","speedMhz":"5600","modules":{"quantity":2,"capacity_gb":32},"casLatency":40}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston FURY White DDR5-5600 CL40 64GB (2x32GB)')
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
  'Kingston FURY Beast Black DDR5-6000 CL30 32GB (1x32GB)',
  2000,
  '{"manufacturer":"Kingston","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6000","speedMhz":"6000","modules":{"quantity":1,"capacity_gb":32},"casLatency":30}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston FURY Beast Black DDR5-6000 CL30 32GB (1x32GB)')
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
  'Corsair Vengeance Black / Silver DDR5-6200 CL32 32GB (2x16GB)',
  2000,
  '{"manufacturer":"Corsair","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6200","speedMhz":"6200","modules":{"quantity":2,"capacity_gb":16},"casLatency":32}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Vengeance Black / Silver DDR5-6200 CL32 32GB (2x16GB)')
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
  'Corsair Dominator Platinum RGB Black DDR4-3600 CL18 16GB (2x8GB)',
  2000,
  '{"manufacturer":"Corsair","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"3600","speedMhz":"3600","modules":{"quantity":2,"capacity_gb":8},"casLatency":18}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Dominator Platinum RGB Black DDR4-3600 CL18 16GB (2x8GB)')
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
  'Crucial CT2K16G52C42U5 Black DDR5-5200 CL42 32GB (2x16GB)',
  2000,
  '{"manufacturer":"Crucial","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"5200","speedMhz":"5200","modules":{"quantity":2,"capacity_gb":16},"casLatency":42}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Crucial CT2K16G52C42U5 Black DDR5-5200 CL42 32GB (2x16GB)')
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
  'G.Skill Trident Z5 Silver / Black DDR5-5600 CL36 32GB (2x16GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"5600","speedMhz":"5600","modules":{"quantity":2,"capacity_gb":16},"casLatency":36}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill Trident Z5 Silver / Black DDR5-5600 CL36 32GB (2x16GB)')
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
  'Kingston HyperX Fury Black DDR4-2666 CL16 8GB (1x8GB)',
  2000,
  '{"manufacturer":"Kingston","memoryType":"DDR4","ram_type":"DDR4","capacity":8,"speed":"2666","speedMhz":"2666","modules":{"quantity":1,"capacity_gb":8},"casLatency":16}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston HyperX Fury Black DDR4-2666 CL16 8GB (1x8GB)')
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
  'Crucial CT24G56C46S5 Black SODIMM DDR5-5600 CL46 24GB (1x24GB)',
  2000,
  '{"manufacturer":"Crucial","memoryType":"DDR4","ram_type":"DDR4","capacity":24,"speed":"5600","speedMhz":"5600","modules":{"quantity":1,"capacity_gb":24},"casLatency":46}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Crucial CT24G56C46S5 Black SODIMM DDR5-5600 CL46 24GB (1x24GB)')
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
  'ADATA AD3U1600W8G11-R Black / Green DDR3-1600 CL11 8GB (1x8GB)',
  2000,
  '{"manufacturer":"ADATA","memoryType":"DDR4","ram_type":"DDR4","capacity":8,"speed":"1600","speedMhz":"1600","modules":{"quantity":1,"capacity_gb":8},"casLatency":11}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ADATA AD3U1600W8G11-R Black / Green DDR3-1600 CL11 8GB (1x8GB)')
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
  'VisionTek 901513 DDR5-4800 CL40 32GB (1x32GB)',
  2000,
  '{"manufacturer":"VisionTek","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"4800","speedMhz":"4800","modules":{"quantity":1,"capacity_gb":32},"casLatency":40}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('VisionTek 901513 DDR5-4800 CL40 32GB (1x32GB)')
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
  'Corsair Vengeance LPX Black DDR4-4000 CL18 64GB (2x32GB)',
  2000,
  '{"manufacturer":"Corsair","memoryType":"DDR4","ram_type":"DDR4","capacity":64,"speed":"4000","speedMhz":"4000","modules":{"quantity":2,"capacity_gb":32},"casLatency":18}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Vengeance LPX Black DDR4-4000 CL18 64GB (2x32GB)')
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
  'TEAMGROUP T-Force Delta RGB Black DDR5-6000 CL38 16GB (1x16GB)',
  2000,
  '{"manufacturer":"TEAMGROUP","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"6000","speedMhz":"6000","modules":{"quantity":1,"capacity_gb":16},"casLatency":38}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('TEAMGROUP T-Force Delta RGB Black DDR5-6000 CL38 16GB (1x16GB)')
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
  'G.Skill Trident Z Royal Silver DDR4-3200 CL14 256GB (8x32GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":256,"speed":"3200","speedMhz":"3200","modules":{"quantity":8,"capacity_gb":32},"casLatency":14}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill Trident Z Royal Silver DDR4-3200 CL14 256GB (8x32GB)')
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
  'TEAMGROUP T-Force Delta RGB Black DDR5-7200 CL34 48GB (2x24GB)',
  2000,
  '{"manufacturer":"TEAMGROUP","memoryType":"DDR4","ram_type":"DDR4","capacity":48,"speed":"7200","speedMhz":"7200","modules":{"quantity":2,"capacity_gb":24},"casLatency":34}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('TEAMGROUP T-Force Delta RGB Black DDR5-7200 CL34 48GB (2x24GB)')
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
  'Kingston HyperX Fury Black DDR4-2666 CL16 16GB (2x8GB)',
  2000,
  '{"manufacturer":"Kingston","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"2666","speedMhz":"2666","modules":{"quantity":2,"capacity_gb":8},"casLatency":16}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston HyperX Fury Black DDR4-2666 CL16 16GB (2x8GB)')
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
  'GOODRAM IRDM Black DDR5-6400 CL32 32GB (2x16GB)',
  2000,
  '{"manufacturer":"GOODRAM","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6400","speedMhz":"6400","modules":{"quantity":2,"capacity_gb":16},"casLatency":32}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('GOODRAM IRDM Black DDR5-6400 CL32 32GB (2x16GB)')
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
  'Kingston FURY Renegade Pro Registered Black DDR5-4800 CL36 32GB (1x32GB)',
  2000,
  '{"manufacturer":"Kingston","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"4800","speedMhz":"4800","modules":{"quantity":1,"capacity_gb":32},"casLatency":36}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston FURY Renegade Pro Registered Black DDR5-4800 CL36 32GB (1x32GB)')
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
  'Corsair Vengeance LPX Black / Yellow DDR4-4000 CL19 32GB (4x8GB)',
  2000,
  '{"manufacturer":"Corsair","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"4000","speedMhz":"4000","modules":{"quantity":4,"capacity_gb":8},"casLatency":19}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Vengeance LPX Black / Yellow DDR4-4000 CL19 32GB (4x8GB)')
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
  'G.Skill Ripjaws S5 White DDR5-5200 CL40 96GB (2x48GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":96,"speed":"5200","speedMhz":"5200","modules":{"quantity":2,"capacity_gb":48},"casLatency":40}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill Ripjaws S5 White DDR5-5200 CL40 96GB (2x48GB)')
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
  'Patriot Viper Xtreme 5 RGB Black DDR5-7600 CL36 32GB (2x16GB)',
  2000,
  '{"manufacturer":"Patriot","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"7600","speedMhz":"7600","modules":{"quantity":2,"capacity_gb":16},"casLatency":36}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Patriot Viper Xtreme 5 RGB Black DDR5-7600 CL36 32GB (2x16GB)')
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
  'G.Skill Trident Z Black DDR5-6400 CL32 32GB (2x16GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6400","speedMhz":"6400","modules":{"quantity":2,"capacity_gb":16},"casLatency":32}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill Trident Z Black DDR5-6400 CL32 32GB (2x16GB)')
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
  'G.Skill Ripjaws V Black DDR4-3600 CL14 32GB (2x16GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"3600","speedMhz":"3600","modules":{"quantity":2,"capacity_gb":16},"casLatency":14}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill Ripjaws V Black DDR4-3600 CL14 32GB (2x16GB)')
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
  'G.Skill Value Black DDR4-2666 CL19 8GB (1x8GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":8,"speed":"2666","speedMhz":"2666","modules":{"quantity":1,"capacity_gb":8},"casLatency":19}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill Value Black DDR4-2666 CL19 8GB (1x8GB)')
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
  'Silicon Power XPOWER Zenith RGB Gaming White DDR5-6400 CL40 32GB (2x16GB)',
  2000,
  '{"manufacturer":"Silicon Power","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6400","speedMhz":"6400","modules":{"quantity":2,"capacity_gb":16},"casLatency":32}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silicon Power XPOWER Zenith RGB Gaming White DDR5-6400 CL40 32GB (2x16GB)')
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
  'G.Skill Flare X Black DDR4-2400 CL15 16GB (2x8GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"2400","speedMhz":"2400","modules":{"quantity":2,"capacity_gb":8},"casLatency":15}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill Flare X Black DDR4-2400 CL15 16GB (2x8GB)')
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
  'Kingston FURY Beast RGB Black DDR5-5600 CL36 128GB (2x64GB)',
  2000,
  '{"manufacturer":"Kingston","memoryType":"DDR4","ram_type":"DDR4","capacity":128,"speed":"5600","speedMhz":"5600","modules":{"quantity":2,"capacity_gb":64},"casLatency":36}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston FURY Beast RGB Black DDR5-5600 CL36 128GB (2x64GB)')
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
  'Corsair Dominator Platinum RGB White DDR5-5200 CL38 32GB (2x16GB)',
  2000,
  '{"manufacturer":"Corsair","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"5200","speedMhz":"5200","modules":{"quantity":2,"capacity_gb":16},"casLatency":38}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Dominator Platinum RGB White DDR5-5200 CL38 32GB (2x16GB)')
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
  'Silicon Power XPOWER Storm RGB White DDR5-8000 CL38 32GB (1x32GB)',
  2000,
  '{"manufacturer":"Silicon Power","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"8000","speedMhz":"8000","modules":{"quantity":1,"capacity_gb":32},"casLatency":38}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silicon Power XPOWER Storm RGB White DDR5-8000 CL38 32GB (1x32GB)')
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
  'GeIL ORION V Red DDR5-5200 CL42 16GB (1x16GB)',
  2000,
  '{"manufacturer":"GeIL","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"5200","speedMhz":"5200","modules":{"quantity":1,"capacity_gb":16},"casLatency":42}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('GeIL ORION V Red DDR5-5200 CL42 16GB (1x16GB)')
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
  'Kingston FURY Renegade White / Silver DDR5-6000 CL32 64GB (2x32GB)',
  2000,
  '{"manufacturer":"Kingston","memoryType":"DDR4","ram_type":"DDR4","capacity":64,"speed":"6000","speedMhz":"6000","modules":{"quantity":2,"capacity_gb":32},"casLatency":32}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston FURY Renegade White / Silver DDR5-6000 CL32 64GB (2x32GB)')
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
  'Crucial Ballistix Black DDR4-3600 CL16 32GB (2x16GB)',
  2000,
  '{"manufacturer":"Crucial","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"3600","speedMhz":"3600","modules":{"quantity":2,"capacity_gb":16},"casLatency":16}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Crucial Ballistix Black DDR4-3600 CL16 32GB (2x16GB)')
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
  'Kingston FURY Renegade Black DDR4-3200 CL16 16GB (2x8GB)',
  2000,
  '{"manufacturer":"Kingston","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"3200","speedMhz":"3200","modules":{"quantity":2,"capacity_gb":8},"casLatency":16}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston FURY Renegade Black DDR4-3200 CL16 16GB (2x8GB)')
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
  'TEAMGROUP Xtreem Black DDR5-6000 CL30 32GB (2x16GB)',
  2000,
  '{"manufacturer":"TEAMGROUP","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6000","speedMhz":"6000","modules":{"quantity":2,"capacity_gb":16},"casLatency":30}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('TEAMGROUP Xtreem Black DDR5-6000 CL30 32GB (2x16GB)')
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
  'Patriot Viper Venom RGB Black / White DDR5-6000 CL30 32GB (1x32GB)',
  2000,
  '{"manufacturer":"Patriot","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6000","speedMhz":"6000","modules":{"quantity":1,"capacity_gb":32},"casLatency":30}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Patriot Viper Venom RGB Black / White DDR5-6000 CL30 32GB (1x32GB)')
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
  'G.Skill Trident Z5 RGB White / Black DDR5-6400 CL32 96GB (2x48GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":96,"speed":"6400","speedMhz":"6400","modules":{"quantity":2,"capacity_gb":48},"casLatency":32}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill Trident Z5 RGB White / Black DDR5-6400 CL32 96GB (2x48GB)')
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
  'IBM 00D4968 Registered Black / Green DDR3-1600 CL11 16GB (1x16GB)',
  2000,
  '{"manufacturer":"IBM","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"1600","speedMhz":"1600","modules":{"quantity":1,"capacity_gb":16},"casLatency":11}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('IBM 00D4968 Registered Black / Green DDR3-1600 CL11 16GB (1x16GB)')
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
  'Corsair Dominator Platinum RGB Black DDR5-6800 CL40 64GB (2x32GB)',
  2000,
  '{"manufacturer":"Corsair","memoryType":"DDR4","ram_type":"DDR4","capacity":64,"speed":"6800","speedMhz":"6800","modules":{"quantity":2,"capacity_gb":32},"casLatency":40}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Dominator Platinum RGB Black DDR5-6800 CL40 64GB (2x32GB)')
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
  'G.Skill Trident Z White / Black DDR5-6000 CL36 32GB (2x16GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6000","speedMhz":"6000","modules":{"quantity":2,"capacity_gb":16},"casLatency":36}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill Trident Z White / Black DDR5-6000 CL36 32GB (2x16GB)')
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
  'Mushkin Redline Lumina White DDR4-3600 CL16 32GB (2x16GB)',
  2000,
  '{"manufacturer":"Mushkin","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"3600","speedMhz":"3600","modules":{"quantity":2,"capacity_gb":16},"casLatency":16}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Mushkin Redline Lumina White DDR4-3600 CL16 32GB (2x16GB)')
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
  'G.Skill Trident Z5 RGB Royal Neo Gold DDR5-6000 CL28 32GB (2x16GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6000","speedMhz":"6000","modules":{"quantity":2,"capacity_gb":16},"casLatency":28}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill Trident Z5 RGB Royal Neo Gold DDR5-6000 CL28 32GB (2x16GB)')
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
  'TEAMGROUP T-Force Delta RGB White DDR5-6400 CL32 32GB (2x16GB)',
  2000,
  '{"manufacturer":"TEAMGROUP","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6400","speedMhz":"6400","modules":{"quantity":2,"capacity_gb":16},"casLatency":32}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('TEAMGROUP T-Force Delta RGB White DDR5-6400 CL32 32GB (2x16GB)')
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
  'Kingston FURY Beast RGB DDR5-6400 CL32 64GB (2x32GB)',
  2000,
  '{"manufacturer":"Kingston","memoryType":"DDR4","ram_type":"DDR4","capacity":64,"speed":"6400","speedMhz":"6400","modules":{"quantity":2,"capacity_gb":32},"casLatency":32}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston FURY Beast RGB DDR5-6400 CL32 64GB (2x32GB)')
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
  'G.Skill Ripjaws M5 RGB DDR5-6000 CL36 32GB (2x16GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6000","speedMhz":"6000","modules":{"quantity":2,"capacity_gb":16},"casLatency":36}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill Ripjaws M5 RGB DDR5-6000 CL36 32GB (2x16GB)')
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
  'PNY XLR8 Gaming EPIC-X RGB Black DDR4-3200 CL16 8GB (1x8GB)',
  2000,
  '{"manufacturer":"PNY","memoryType":"DDR4","ram_type":"DDR4","capacity":8,"speed":"3200","speedMhz":"3200","modules":{"quantity":1,"capacity_gb":8},"casLatency":16}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('PNY XLR8 Gaming EPIC-X RGB Black DDR4-3200 CL16 8GB (1x8GB)')
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
  'G.Skill RipJaws S5 Series (Intel XMP) 32GB (2 x 16GB) 288-Pin SDRAM DDR5 5600 CL30-36-36-89 1.25V Dual Channel Desktop Memory F5-5600J3036D16GA2-RS5K',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"5600","speedMhz":"5600","modules":{"quantity":2,"capacity_gb":16},"casLatency":30}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill RipJaws S5 Series (Intel XMP) 32GB (2 x 16GB) 288-Pin SDRAM DDR5 5600 CL30-36-36-89 1.25V Dual Channel Desktop Memory F5-5600J3036D16GA2-RS5K')
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
  'Corsair Vengeance LPX Black / Yellow DDR4-4000 CL19 128GB (8x16GB)',
  2000,
  '{"manufacturer":"Corsair","memoryType":"DDR4","ram_type":"DDR4","capacity":128,"speed":"4000","speedMhz":"4000","modules":{"quantity":8,"capacity_gb":16},"casLatency":19}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Vengeance LPX Black / Yellow DDR4-4000 CL19 128GB (8x16GB)')
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
  'Corsair Dominator Platinum RGB Black DDR5-5600 CL40 64GB (2x32GB)',
  2000,
  '{"manufacturer":"Corsair","memoryType":"DDR4","ram_type":"DDR4","capacity":64,"speed":"5600","speedMhz":"5600","modules":{"quantity":2,"capacity_gb":32},"casLatency":40}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Dominator Platinum RGB Black DDR5-5600 CL40 64GB (2x32GB)')
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
  'Corsair Vengeance RGB Black DDR5-5200 CL40 32GB (2x16GB)',
  2000,
  '{"manufacturer":"Corsair","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"5200","speedMhz":"5200","modules":{"quantity":2,"capacity_gb":16},"casLatency":40}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Vengeance RGB Black DDR5-5200 CL40 32GB (2x16GB)')
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
  'Klevv CRAS X RGB Black DDR4-3200 CL16 32GB (2x16GB)',
  2000,
  '{"manufacturer":"Klevv","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"3200","speedMhz":"3200","modules":{"quantity":2,"capacity_gb":16},"casLatency":16}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Klevv CRAS X RGB Black DDR4-3200 CL16 32GB (2x16GB)')
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
  'Patriot Viper Steel Silver / Black DDR4-3600 CL17 16GB (2x8GB)',
  2000,
  '{"manufacturer":"Patriot","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"3600","speedMhz":"3600","modules":{"quantity":2,"capacity_gb":8},"casLatency":17}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Patriot Viper Steel Silver / Black DDR4-3600 CL17 16GB (2x8GB)')
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
  'Crucial CT8G4DFS8213 Black / Green DDR4-2133 CL15 8GB (1x8GB)',
  2000,
  '{"manufacturer":"Crucial","memoryType":"DDR4","ram_type":"DDR4","capacity":8,"speed":"2133","speedMhz":"2133","modules":{"quantity":1,"capacity_gb":8},"casLatency":15}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Crucial CT8G4DFS8213 Black / Green DDR4-2133 CL15 8GB (1x8GB)')
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
  'G.Skill Ripjaws Red DDR4-2133 CL15 32GB (4x8GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"2133","speedMhz":"2133","modules":{"quantity":4,"capacity_gb":8},"casLatency":15}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill Ripjaws Red DDR4-2133 CL15 32GB (4x8GB)')
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
  'Silicon Power XPOWER Zenith Gaming Black DDR5-6000 CL30 16GB (1x16GB)',
  2000,
  '{"manufacturer":"Silicon Power","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"6000","speedMhz":"6000","modules":{"quantity":1,"capacity_gb":16},"casLatency":30}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silicon Power XPOWER Zenith Gaming Black DDR5-6000 CL30 16GB (1x16GB)')
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
  'Patriot Viper Elite 5 RGB DDR5-6000 CL42 32GB (1x32GB)',
  2000,
  '{"manufacturer":"Patriot","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6000","speedMhz":"6000","modules":{"quantity":1,"capacity_gb":32},"casLatency":42}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Patriot Viper Elite 5 RGB DDR5-6000 CL42 32GB (1x32GB)')
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
  'CORSAIR Dominator Titanium RGB 64GB (2 x 32GB) DDR5 6600 (PC5 52800) Desktop Memory Model CMP64GX5M2X6600C32W',
  2000,
  '{"manufacturer":"Corsair","memoryType":"DDR4","ram_type":"DDR4","capacity":64,"speed":"6600","speedMhz":"6600","modules":{"quantity":2,"capacity_gb":32},"casLatency":32}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('CORSAIR Dominator Titanium RGB 64GB (2 x 32GB) DDR5 6600 (PC5 52800) Desktop Memory Model CMP64GX5M2X6600C32W')
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
  'Kingston FURY Beast Black DDR5-6000 CL30 8GB (1x8GB)',
  2000,
  '{"manufacturer":"Kingston","memoryType":"DDR4","ram_type":"DDR4","capacity":8,"speed":"6000","speedMhz":"6000","modules":{"quantity":1,"capacity_gb":8},"casLatency":30}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston FURY Beast Black DDR5-6000 CL30 8GB (1x8GB)')
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
  'Patriot Signature Premium Black DDR4-2666 CL19 16GB (2x8GB)',
  2000,
  '{"manufacturer":"Patriot","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"2666","speedMhz":"2666","modules":{"quantity":2,"capacity_gb":8},"casLatency":19}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Patriot Signature Premium Black DDR4-2666 CL19 16GB (2x8GB)')
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
  'Kingston FURY Beast RGB Black DDR5-6000 CL30 32GB (2x16GB)',
  2000,
  '{"manufacturer":"Kingston","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6000","speedMhz":"6000","modules":{"quantity":2,"capacity_gb":16},"casLatency":30}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston FURY Beast RGB Black DDR5-6000 CL30 32GB (2x16GB)')
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
  'Mushkin Redline Lumina Black DDR4-4133 CL19 32GB (2x16GB)',
  2000,
  '{"manufacturer":"Mushkin","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"4133","speedMhz":"4133","modules":{"quantity":2,"capacity_gb":16},"casLatency":19}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Mushkin Redline Lumina Black DDR4-4133 CL19 32GB (2x16GB)')
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
  'G.Skill Trident Z Red / Silver DDR4-3200 CL16 32GB (2x16GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"3200","speedMhz":"3200","modules":{"quantity":2,"capacity_gb":16},"casLatency":16}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill Trident Z Red / Silver DDR4-3200 CL16 32GB (2x16GB)')
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
  'Corsair Vengeance RGB Pro SL White DDR4-3200 CL16 64GB (4x16GB)',
  2000,
  '{"manufacturer":"Corsair","memoryType":"DDR4","ram_type":"DDR4","capacity":64,"speed":"3200","speedMhz":"3200","modules":{"quantity":4,"capacity_gb":16},"casLatency":16}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Vengeance RGB Pro SL White DDR4-3200 CL16 64GB (4x16GB)')
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
  'Patriot Viper Steel RGB Black DDR4-3600 CL20 8GB (1x8GB)',
  2000,
  '{"manufacturer":"Patriot","memoryType":"DDR4","ram_type":"DDR4","capacity":8,"speed":"3600","speedMhz":"3600","modules":{"quantity":1,"capacity_gb":8},"casLatency":20}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Patriot Viper Steel RGB Black DDR4-3600 CL20 8GB (1x8GB)')
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
  'ADATA XPG Lancer Blade Black DDR5-6000 CL30 64GB (2x32GB)',
  2000,
  '{"manufacturer":"ADATA","memoryType":"DDR4","ram_type":"DDR4","capacity":64,"speed":"6000","speedMhz":"6000","modules":{"quantity":2,"capacity_gb":32},"casLatency":30}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ADATA XPG Lancer Blade Black DDR5-6000 CL30 64GB (2x32GB)')
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
  'Crucial CT32G56C46U5 Black DDR5-5600 CL46 32GB (1x32GB)',
  2000,
  '{"manufacturer":"Crucial","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"5600","speedMhz":"5600","modules":{"quantity":1,"capacity_gb":32},"casLatency":46}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Crucial CT32G56C46U5 Black DDR5-5600 CL46 32GB (1x32GB)')
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
  'Corsair Vengeance RGB Black DDR5-6200 CL36 32GB (2x16GB)',
  2000,
  '{"manufacturer":"Corsair","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6200","speedMhz":"6200","modules":{"quantity":2,"capacity_gb":16},"casLatency":36}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Vengeance RGB Black DDR5-6200 CL36 32GB (2x16GB)')
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
  'Mushkin Redline Lumina Black DDR5-6800 CL32 32GB (2x16GB)',
  2000,
  '{"manufacturer":"Mushkin","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6800","speedMhz":"6800","modules":{"quantity":2,"capacity_gb":16},"casLatency":32}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Mushkin Redline Lumina Black DDR5-6800 CL32 32GB (2x16GB)')
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
  'Silicon Power DDR5 32GB (2x16GB) Zenith RGB 6000MHz CL40 WHITE',
  2000,
  '{"manufacturer":"Silicon Power","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6000","speedMhz":"6000","modules":{"quantity":2,"capacity_gb":16},"casLatency":40}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silicon Power DDR5 32GB (2x16GB) Zenith RGB 6000MHz CL40 WHITE')
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
  'GeIL EVO X II AMD Black DDR4-3200 CL16 16GB (2x8GB)',
  2000,
  '{"manufacturer":"GeIL","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"3200","speedMhz":"3200","modules":{"quantity":2,"capacity_gb":8},"casLatency":16}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('GeIL EVO X II AMD Black DDR4-3200 CL16 16GB (2x8GB)')
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
  'Corsair Vengeance RGB Black DDR5-6400 CL36 48GB (2x24GB)',
  2000,
  '{"manufacturer":"Corsair","memoryType":"DDR4","ram_type":"DDR4","capacity":48,"speed":"6400","speedMhz":"6400","modules":{"quantity":2,"capacity_gb":24},"casLatency":36}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Vengeance RGB Black DDR5-6400 CL36 48GB (2x24GB)')
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
  'Kingston FURY Beast Black / Silver DDR5-6000 CL40 32GB (1x32GB)',
  2000,
  '{"manufacturer":"Kingston","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6000","speedMhz":"6000","modules":{"quantity":1,"capacity_gb":32},"casLatency":40}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston FURY Beast Black / Silver DDR5-6000 CL40 32GB (1x32GB)')
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
  'TEAMGROUP Elite Plus Red / Black DDR4-2400 CL16 16GB (2x8GB)',
  2000,
  '{"manufacturer":"TEAMGROUP","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"2400","speedMhz":"2400","modules":{"quantity":2,"capacity_gb":8},"casLatency":16}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('TEAMGROUP Elite Plus Red / Black DDR4-2400 CL16 16GB (2x8GB)')
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
  'Crucial Pro Black / Green DDR4-3200 CL22 64GB (2x32GB)',
  2000,
  '{"manufacturer":"Crucial","memoryType":"DDR4","ram_type":"DDR4","capacity":64,"speed":"3200","speedMhz":"3200","modules":{"quantity":2,"capacity_gb":32},"casLatency":22}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Crucial Pro Black / Green DDR4-3200 CL22 64GB (2x32GB)')
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
  'G.Skill NT Black DDR4-2133 CL15 16GB (2x8GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"2133","speedMhz":"2133","modules":{"quantity":2,"capacity_gb":8},"casLatency":15}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill NT Black DDR4-2133 CL15 16GB (2x8GB)')
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
  'Corsair Vengeance LPX DDR4-2666 CL15 8GB (2x4GB)',
  2000,
  '{"manufacturer":"Corsair","memoryType":"DDR4","ram_type":"DDR4","capacity":8,"speed":"2666","speedMhz":"2666","modules":{"quantity":2,"capacity_gb":4},"casLatency":15}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Vengeance LPX DDR4-2666 CL15 8GB (2x4GB)')
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
  'Kingston FURY Beast RGB White 128GB (4x32GB) 5600MT/s CL40 DDR5 XMP DIMM | Overclocking | Plug N Play | Intel XMP 3.0 | Kit of 4 | KF556C40BWAK4-128',
  2000,
  '{"manufacturer":"Kingston","memoryType":"DDR4","ram_type":"DDR4","capacity":128,"speed":"5600","speedMhz":"5600","modules":{"quantity":4,"capacity_gb":32},"casLatency":40}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston FURY Beast RGB White 128GB (4x32GB) 5600MT/s CL40 DDR5 XMP DIMM | Overclocking | Plug N Play | Intel XMP 3.0 | Kit of 4 | KF556C40BWAK4-128')
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
  'TEAMGROUP Elite Black DDR5-6400 CL52 16GB (1x16GB)',
  2000,
  '{"manufacturer":"TEAMGROUP","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"6400","speedMhz":"6400","modules":{"quantity":1,"capacity_gb":16},"casLatency":52}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('TEAMGROUP Elite Black DDR5-6400 CL52 16GB (1x16GB)')
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
  'Klevv KD5AGU880-60A320Q White DDR5-6000 CL32 16GB (1x16GB)',
  2000,
  '{"manufacturer":"Klevv","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"6000","speedMhz":"6000","modules":{"quantity":1,"capacity_gb":16},"casLatency":32}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Klevv KD5AGU880-60A320Q White DDR5-6000 CL32 16GB (1x16GB)')
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
  'Kingston FURY Beast RGB Black DDR5-6000 CL40 16GB (2x8GB)',
  2000,
  '{"manufacturer":"Kingston","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"6000","speedMhz":"6000","modules":{"quantity":2,"capacity_gb":8},"casLatency":40}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston FURY Beast RGB Black DDR5-6000 CL40 16GB (2x8GB)')
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
  'TEAMGROUP T-Force Vulcan Black DDR5-5600 CL32 16GB (1x16GB)',
  2000,
  '{"manufacturer":"TEAMGROUP","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"5600","speedMhz":"5600","modules":{"quantity":1,"capacity_gb":16},"casLatency":32}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('TEAMGROUP T-Force Vulcan Black DDR5-5600 CL32 16GB (1x16GB)')
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
  'Corsair Vengeance LPX White DDR4-3000 CL15 16GB (2x8GB)',
  2000,
  '{"manufacturer":"Corsair","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"3000","speedMhz":"3000","modules":{"quantity":2,"capacity_gb":8},"casLatency":15}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Vengeance LPX White DDR4-3000 CL15 16GB (2x8GB)')
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
  'Corsair Vengeance LPX Black DDR4-3600 CL18 64GB (2x32GB)',
  2000,
  '{"manufacturer":"Corsair","memoryType":"DDR4","ram_type":"DDR4","capacity":64,"speed":"3600","speedMhz":"3600","modules":{"quantity":2,"capacity_gb":32},"casLatency":18}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Vengeance LPX Black DDR4-3600 CL18 64GB (2x32GB)')
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
  'Silicon Power XPOWER Storm RGB DDR5-8000 CL38 64GB (2x32GB)',
  2000,
  '{"manufacturer":"Silicon Power","memoryType":"DDR4","ram_type":"DDR4","capacity":64,"speed":"8000","speedMhz":"8000","modules":{"quantity":2,"capacity_gb":32},"casLatency":38}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silicon Power XPOWER Storm RGB DDR5-8000 CL38 64GB (2x32GB)')
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
  'Corsair Vengeance RGB Pro Black DDR4-3600 CL18 32GB (4x8GB)',
  2000,
  '{"manufacturer":"Corsair","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"3600","speedMhz":"3600","modules":{"quantity":4,"capacity_gb":8},"casLatency":18}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Vengeance RGB Pro Black DDR4-3600 CL18 32GB (4x8GB)')
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
  'G.Skill Trident Z5 Neo RGB Black DDR5-5600 CL28 32GB (2x16GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"5600","speedMhz":"5600","modules":{"quantity":2,"capacity_gb":16},"casLatency":28}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill Trident Z5 Neo RGB Black DDR5-5600 CL28 32GB (2x16GB)')
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
  'G.Skill Ripjaws S5 Black DDR5-6000 CL30 64GB (2x32GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":64,"speed":"6000","speedMhz":"6000","modules":{"quantity":2,"capacity_gb":32},"casLatency":30}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill Ripjaws S5 Black DDR5-6000 CL30 64GB (2x32GB)')
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
  'Gigabyte AORUS RGB DDR4-3200 CL16 16GB (2x8GB)',
  2000,
  '{"manufacturer":"GIGABYTE","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"3200","speedMhz":"3200","modules":{"quantity":2,"capacity_gb":8},"casLatency":16}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte AORUS RGB DDR4-3200 CL16 16GB (2x8GB)')
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
  'Kingston HyperX Predator Black / Silver DDR4-3200 CL16 16GB (2x8GB)',
  2000,
  '{"manufacturer":"Kingston","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"3200","speedMhz":"3200","modules":{"quantity":2,"capacity_gb":8},"casLatency":16}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston HyperX Predator Black / Silver DDR4-3200 CL16 16GB (2x8GB)')
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
  'Thermaltake TOUGHRAM XG RGB Black / Silver DDR4-4400 CL19 16GB (2x8GB)',
  2000,
  '{"manufacturer":"Thermaltake","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"4400","speedMhz":"4400","modules":{"quantity":2,"capacity_gb":8},"casLatency":19}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermaltake TOUGHRAM XG RGB Black / Silver DDR4-4400 CL19 16GB (2x8GB)')
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
  'OLOy Blade RGB Black DDR5-5600 CL40 16GB (2x8GB)',
  2000,
  '{"manufacturer":"OLOy","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"5600","speedMhz":"5600","modules":{"quantity":2,"capacity_gb":8},"casLatency":40}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('OLOy Blade RGB Black DDR5-5600 CL40 16GB (2x8GB)')
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
  'Apacer Panther Silver / Black DDR5-6400 CL32 32GB (2x16GB)',
  2000,
  '{"manufacturer":"Apacer","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6400","speedMhz":"6400","modules":{"quantity":2,"capacity_gb":16},"casLatency":32}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Apacer Panther Silver / Black DDR5-6400 CL32 32GB (2x16GB)')
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
  'Corsair Vengeance LPX Black / Yellow DDR4-4600 CL18 32GB (4x8GB)',
  2000,
  '{"manufacturer":"Corsair","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"4600","speedMhz":"4600","modules":{"quantity":4,"capacity_gb":8},"casLatency":18}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Vengeance LPX Black / Yellow DDR4-4600 CL18 32GB (4x8GB)')
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
  'TEAMGROUP T-Force DELTAα RGB Black DDR5-6400 CL40 16GB (2x8GB)',
  2000,
  '{"manufacturer":"TEAMGROUP","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"6400","speedMhz":"6400","modules":{"quantity":2,"capacity_gb":8},"casLatency":40}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('TEAMGROUP T-Force DELTAα RGB Black DDR5-6400 CL40 16GB (2x8GB)')
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
  'Silicon Power XPOWER Zenith Gaming White DDR5-6000 CL30 16GB (1x16GB)',
  2000,
  '{"manufacturer":"Silicon Power","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"6000","speedMhz":"6000","modules":{"quantity":1,"capacity_gb":16},"casLatency":30}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silicon Power XPOWER Zenith Gaming White DDR5-6000 CL30 16GB (1x16GB)')
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
  'ADATA XPG GAMMIX D10 Black DDR4-3600 CL18 16GB (2x8GB)',
  2000,
  '{"manufacturer":"ADATA","memoryType":"DDR4","ram_type":"DDR4","capacity":16,"speed":"3600","speedMhz":"3600","modules":{"quantity":2,"capacity_gb":8},"casLatency":18}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ADATA XPG GAMMIX D10 Black DDR4-3600 CL18 16GB (2x8GB)')
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
  'G.Skill Ripjaws M5 RGB Black DDR5-6400 CL32 96GB (2x48GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":96,"speed":"6400","speedMhz":"6400","modules":{"quantity":2,"capacity_gb":48},"casLatency":32}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill Ripjaws M5 RGB Black DDR5-6400 CL32 96GB (2x48GB)')
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
  'Acer Predator Pallas II Black DDR5-6400 CL32 32GB (2x16GB)',
  2000,
  '{"manufacturer":"Acer","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6400","speedMhz":"6400","modules":{"quantity":2,"capacity_gb":16},"casLatency":32}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Acer Predator Pallas II Black DDR5-6400 CL32 32GB (2x16GB)')
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
  'TEAMGROUP T-Force Vulcan Eco Silver DDR5-6000 CL30 32GB (2x16GB)',
  2000,
  '{"manufacturer":"TEAMGROUP","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"6000","speedMhz":"6000","modules":{"quantity":2,"capacity_gb":16},"casLatency":30}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('TEAMGROUP T-Force Vulcan Eco Silver DDR5-6000 CL30 32GB (2x16GB)')
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
  'G.Skill Trident Z5 RGB Black DDR5-5600 CL30 32GB (2x16GB)',
  2000,
  '{"manufacturer":"G.SKILL","memoryType":"DDR4","ram_type":"DDR4","capacity":32,"speed":"5600","speedMhz":"5600","modules":{"quantity":2,"capacity_gb":16},"casLatency":30}'::jsonb,
  3,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill Trident Z5 RGB Black DDR5-5600 CL30 32GB (2x16GB)')
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
  'ADATA XPG GAMMIX S70 1TB SSD M.2-2280 PCIe 4.0 X4 NVMe',
  3000,
  '{"manufacturer":"ADATA","interface":"M.2 PCIe 4.0 X4","capacity":1000,"capacityGB":"1000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ADATA XPG GAMMIX S70 1TB SSD M.2-2280 PCIe 4.0 X4 NVMe')
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
  'Kingston SSDNow KC400 256GB SSD 2.5" SATA',
  3000,
  '{"manufacturer":"Kingston","interface":"SATA 6.0 Gb/s","capacity":256,"capacityGB":"256GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston SSDNow KC400 256GB SSD 2.5" SATA')
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
  'Mushkin MKNSSDED500GB-D8 500GB M.2-2280 SSD PCIe 4.0 x4 NVMe',
  3000,
  '{"manufacturer":"Mushkin","interface":"M.2 PCIe 4.0 X4","capacity":500,"capacityGB":"500GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Mushkin MKNSSDED500GB-D8 500GB M.2-2280 SSD PCIe 4.0 x4 NVMe')
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
  'Kingston HyperX 3K 240GB SSD 2.5" SATA 6.0 Gb/s',
  3000,
  '{"manufacturer":"Kingston","interface":"SATA 6.0 Gb/s","capacity":240,"capacityGB":"240GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston HyperX 3K 240GB SSD 2.5" SATA 6.0 Gb/s')
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
  'Transcend SSD230S 512GB SSD 2.5" SATA',
  3000,
  '{"manufacturer":"Transcend","interface":"SATA 6.0 Gb/s","capacity":512,"capacityGB":"512GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Transcend SSD230S 512GB SSD 2.5" SATA')
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
  'Samsung 970 Evo 500 GB M.2-2280 SSD PCIe 3.0 X4 NVMe',
  3000,
  '{"manufacturer":"Samsung","interface":"M.2 PCIe 3.0 X4","capacity":500,"capacityGB":"500GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Samsung 970 Evo 500 GB M.2-2280 SSD PCIe 3.0 X4 NVMe')
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
  'Hitachi Travelstar 320 GB 2.5" HDD 5400 RPM SATA 3.0 Gb/s',
  3000,
  '{"manufacturer":"Hitachi","interface":"SATA 3.0 Gb/s","capacity":320,"capacityGB":"320GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Hitachi Travelstar 320 GB 2.5" HDD 5400 RPM SATA 3.0 Gb/s')
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
  'Corsair MP600 Force Series Gen4 1TB M.2-2280 SSD NVMe PCIe 3.0 X4',
  3000,
  '{"manufacturer":"Corsair","interface":"M.2 PCIe 3.0 X4","capacity":1000,"capacityGB":"1000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair MP600 Force Series Gen4 1TB M.2-2280 SSD NVMe PCIe 3.0 X4')
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
  'Western Digital Scorpio Blue 320GB HDD 2.5" 5400RPM SATA',
  3000,
  '{"manufacturer":"Western Digital","interface":"SATA 3.0 Gb/s","capacity":320,"capacityGB":"320GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Western Digital Scorpio Blue 320GB HDD 2.5" 5400RPM SATA')
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
  'Seagate BarraCuda 750 GB 3.5" HDD 7200RPM SATA Internal',
  3000,
  '{"manufacturer":"Seagate","interface":"SATA 3.0 Gb/s","capacity":750,"capacityGB":"750GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Seagate BarraCuda 750 GB 3.5" HDD 7200RPM SATA Internal')
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
  'Western Digital AV-25 320GB HDD 5400RPM 2.5" SATA',
  3000,
  '{"manufacturer":"Western Digital","interface":"SATA 3.0 Gb/s","capacity":320,"capacityGB":"320GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Western Digital AV-25 320GB HDD 5400RPM 2.5" SATA')
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
  'PNY CS1211 240GB SSD 2.5" SATA 6.0 Gb/s',
  3000,
  '{"manufacturer":"PNY","interface":"SATA 6.0 Gb/s","capacity":240,"capacityGB":"240GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('PNY CS1211 240GB SSD 2.5" SATA 6.0 Gb/s')
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
  'Hitachi 0F27406 8TB HDD 3.5" 7200RPM SAS 12.0 Gb/s Internal',
  3000,
  '{"manufacturer":"Hitachi","interface":"SAS 12.0 Gb/s","capacity":8000,"capacityGB":"8000GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Hitachi 0F27406 8TB HDD 3.5" 7200RPM SAS 12.0 Gb/s Internal')
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
  'TEAMGROUP L3 EVO 240GB SSD 2.5" SATA',
  3000,
  '{"manufacturer":"TEAMGROUP","interface":"SATA 6.0 Gb/s","capacity":240,"capacityGB":"240GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('TEAMGROUP L3 EVO 240GB SSD 2.5" SATA')
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
  'Western Digital Black SN850X 8TB M.2 SSD PCIe 4.0 NVMe',
  3000,
  '{"manufacturer":"Western Digital","interface":"M.2 PCIe 4.0 X4","capacity":8000,"capacityGB":"8000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Western Digital Black SN850X 8TB M.2 SSD PCIe 4.0 NVMe')
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
  'SanDisk Ultra 3D 1 TB SSD 2.5" SATA 6.0 Gb/s',
  3000,
  '{"manufacturer":"SanDisk","interface":"SATA 6.0 Gb/s","capacity":1000,"capacityGB":"1000GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('SanDisk Ultra 3D 1 TB SSD 2.5" SATA 6.0 Gb/s')
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
  'Timetec 35TTQNM2SATA 1TB SSD M.2-2280 SATA',
  3000,
  '{"manufacturer":"Timetec","interface":"M.2 SATA","capacity":1000,"capacityGB":"1000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Timetec 35TTQNM2SATA 1TB SSD M.2-2280 SATA')
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
  'Mushkin Vortex Redline 2TB SSD M.2 PCIe 4.0 NVMe',
  3000,
  '{"manufacturer":"Mushkin","interface":"M.2 PCIe 4.0 X4","capacity":2000,"capacityGB":"2000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Mushkin Vortex Redline 2TB SSD M.2 PCIe 4.0 NVMe')
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
  'Kingston NV3 PCIe 4.0 NVMe SSD',
  3000,
  '{"manufacturer":"Kingston Technology","interface":"PCIe 4.0 X4 NVMe","capacity":1000,"capacityGB":"1000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston NV3 PCIe 4.0 NVMe SSD')
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
  'Seagate Exos 10TB HDD 7200RPM 3.5" SAS 12.0 Gb/s',
  3000,
  '{"manufacturer":"Seagate","interface":"SAS 12.0 Gb/s","capacity":10000,"capacityGB":"10000GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Seagate Exos 10TB HDD 7200RPM 3.5" SAS 12.0 Gb/s')
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
  'Corsair MP600 ELITE PS5 1TB M.2 SSD PCIe 4.0 NVMe',
  3000,
  '{"manufacturer":"Corsair","interface":"M.2 PCIe 4.0 X4","capacity":1000,"capacityGB":"1000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair MP600 ELITE PS5 1TB M.2 SSD PCIe 4.0 NVMe')
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
  'Addlink G55H 2TB SSD M.2 PCIe 5.0 NVMe',
  3000,
  '{"manufacturer":"Addlink","interface":"M.2 PCIe 5.0 X4","capacity":2000,"capacityGB":"2000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Addlink G55H 2TB SSD M.2 PCIe 5.0 NVMe')
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
  'Seagate Exos X18 12TB 3.5" HDD 7200RPM SATA 6.0 Gb/s',
  3000,
  '{"manufacturer":"Seagate","interface":"SATA 6.0 Gb/s","capacity":12000,"capacityGB":"12000GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Seagate Exos X18 12TB 3.5" HDD 7200RPM SATA 6.0 Gb/s')
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
  'Inland Gaming Performance Plus 4TB SSD M.2-2280 PCIe 4.0 X4 NVMe',
  3000,
  '{"manufacturer":"Inland","interface":"M.2 PCIe 4.0 X4","capacity":4000,"capacityGB":"4000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Inland Gaming Performance Plus 4TB SSD M.2-2280 PCIe 4.0 X4 NVMe')
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
  'Crucial T500 1 TB SSD M.2-2280 PCIe 4.0 x4 NVMe',
  3000,
  '{"manufacturer":"Crucial","interface":"M.2 PCIe 4.0 X4","capacity":1000,"capacityGB":"1000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Crucial T500 1 TB SSD M.2-2280 PCIe 4.0 x4 NVMe')
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
  'Toshiba RC100 240GB SSD M.2-2242 PCIe 3.0 X2 NVMe',
  3000,
  '{"manufacturer":"Toshiba","interface":"M.2 PCIe 3.0 X2","capacity":240,"capacityGB":"240GB","formFactor":"M.2-2242","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Toshiba RC100 240GB SSD M.2-2242 PCIe 3.0 X2 NVMe')
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
  'Western Digital WD_BLACK SN8100 w/Heatsink 1TB SSD M.2-2280 PCIe 5.0 x4 NVMe',
  3000,
  '{"manufacturer":"Western Digital","interface":"M.2 PCIe 5.0 X4","capacity":1000,"capacityGB":"1000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Western Digital WD_BLACK SN8100 w/Heatsink 1TB SSD M.2-2280 PCIe 5.0 x4 NVMe')
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
  'Addlink S95 4TB SSD M.2-2280 PCIe 4.0 NVMe',
  3000,
  '{"manufacturer":"Addlink","interface":"M.2 PCIe 4.0 X4","capacity":4000,"capacityGB":"4000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Addlink S95 4TB SSD M.2-2280 PCIe 4.0 NVMe')
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
  'Silicon Power A58 1TB SSD 2.5" SATA 6.0 Gb/s',
  3000,
  '{"manufacturer":"Silicon Power","interface":"SATA 6.0 Gb/s","capacity":1000,"capacityGB":"1000GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silicon Power A58 1TB SSD 2.5" SATA 6.0 Gb/s')
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
  'Intel 710 200GB 2.5" SSD SATA 3.0 Gb/s',
  3000,
  '{"manufacturer":"Intel","interface":"SATA 3.0 Gb/s","capacity":200,"capacityGB":"200GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel 710 200GB 2.5" SSD SATA 3.0 Gb/s')
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
  'Samsung 860 Pro 512GB SSD 2.5" SATA',
  3000,
  '{"manufacturer":"Samsung","interface":"SATA 6.0 Gb/s","capacity":512,"capacityGB":"512GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Samsung 860 Pro 512GB SSD 2.5" SATA')
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
  'Intel 750 1.2TB SSD PCIe NVMe',
  3000,
  '{"manufacturer":"Intel","interface":"PCIe x4","capacity":1000,"capacityGB":"1000GB","formFactor":"PCIe","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel 750 1.2TB SSD PCIe NVMe')
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
  'Intel 320 40GB SSD 2.5" SATA 3.0 Gb/s',
  3000,
  '{"manufacturer":"Intel","interface":"SATA 3.0 Gb/s","capacity":40,"capacityGB":"40GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel 320 40GB SSD 2.5" SATA 3.0 Gb/s')
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
  'Timetec 30TTQNS3SATA-2TB 2TB SSD 2.5" SATA 6.0 Gb/s',
  3000,
  '{"manufacturer":"Timetec","interface":"SATA 6.0 Gb/s","capacity":2000,"capacityGB":"2000GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Timetec 30TTQNS3SATA-2TB 2TB SSD 2.5" SATA 6.0 Gb/s')
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
  'SK Hynix SH910A 128GB SSD 2.5" SATA',
  3000,
  '{"manufacturer":"SK Hynix","interface":"SATA 6.0 Gb/s","capacity":128,"capacityGB":"128GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('SK Hynix SH910A 128GB SSD 2.5" SATA')
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
  'Western Digital Red 10TB HDD 3.5" SATA',
  3000,
  '{"manufacturer":"Western Digital","interface":"SATA 6.0 Gb/s","capacity":10000,"capacityGB":"10000GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Western Digital Red 10TB HDD 3.5" SATA')
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
  'Western Digital WD_BLACK SN8100 2TB M.2-2280 SSD PCIe 5.0 X4 NVME',
  3000,
  '{"manufacturer":"Western Digital","interface":"M.2 PCIe 5.0 X4","capacity":2000,"capacityGB":"2000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Western Digital WD_BLACK SN8100 2TB M.2-2280 SSD PCIe 5.0 X4 NVME')
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
  'Seagate Constellation.2 1TB HDD 7200RPM 2.5" SAS',
  3000,
  '{"manufacturer":"Seagate","interface":"SAS 6.0 Gb/s","capacity":1000,"capacityGB":"1000GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Seagate Constellation.2 1TB HDD 7200RPM 2.5" SAS')
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
  'Samsung 870 Evo 2TB SSD 2.5" SATA 6.0 Gb/s',
  3000,
  '{"manufacturer":"Samsung","interface":"SATA 6.0 Gb/s","capacity":2000,"capacityGB":"2000GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Samsung 870 Evo 2TB SSD 2.5" SATA 6.0 Gb/s')
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
  'Klevv NEO N400 240GB SSD 2.5" SATA 6.0 Gb/s',
  3000,
  '{"manufacturer":"Klevv","interface":"SATA 6.0 Gb/s","capacity":240,"capacityGB":"240GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Klevv NEO N400 240GB SSD 2.5" SATA 6.0 Gb/s')
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
  'Western Digital Purple 3TB HDD 3.5" 5400RPM SATA 6.0 Gb/s',
  3000,
  '{"manufacturer":"Western Digital","interface":"SATA 6.0 Gb/s","capacity":3000,"capacityGB":"3000GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Western Digital Purple 3TB HDD 3.5" 5400RPM SATA 6.0 Gb/s')
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
  'Seagate BarraCuda 500GB HDD 3.5" 7200RPM SATA',
  3000,
  '{"manufacturer":"Seagate","interface":"SATA 6.0 Gb/s","capacity":500,"capacityGB":"500GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Seagate BarraCuda 500GB HDD 3.5" 7200RPM SATA')
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
  'Western Digital WD Green 120GB SSD M.2-2280 SATA',
  3000,
  '{"manufacturer":"Western Digital","interface":"M.2 SATA","capacity":120,"capacityGB":"120GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Western Digital WD Green 120GB SSD M.2-2280 SATA')
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
  'KIOXIA EXCERIA 480GB SSD 2.5" SATA 6.0 Gb/s',
  3000,
  '{"manufacturer":"KIOXIA","interface":"SATA 6.0 Gb/s","capacity":480,"capacityGB":"480GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('KIOXIA EXCERIA 480GB SSD 2.5" SATA 6.0 Gb/s')
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
  'Western Digital Red Pro 2TB HDD 7200RPM 3.5" SATA',
  3000,
  '{"manufacturer":"Western Digital","interface":"SATA 6.0 Gb/s","capacity":2000,"capacityGB":"2000GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Western Digital Red Pro 2TB HDD 7200RPM 3.5" SATA')
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
  'Lexar NM710 1TB SSD M.2-2280 PCIe 4.0 x4 NVMe',
  3000,
  '{"manufacturer":"Lexar","interface":"M.2 PCIe 4.0 X4","capacity":1000,"capacityGB":"1000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Lexar NM710 1TB SSD M.2-2280 PCIe 4.0 x4 NVMe')
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
  'Intel 545s 512GB SSD 2.5" SATA',
  3000,
  '{"manufacturer":"Intel","interface":"SATA 6.0 Gb/s","capacity":512,"capacityGB":"512GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel 545s 512GB SSD 2.5" SATA')
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
  'Seagate Momentus 5400.6 500GB 5400 RPM HDD 2.5" SATA',
  3000,
  '{"manufacturer":"Seagate","interface":"SATA 3.0 Gb/s","capacity":500,"capacityGB":"500GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Seagate Momentus 5400.6 500GB 5400 RPM HDD 2.5" SATA')
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
  'AMD RADEON-R7SSD-120G 120GB SSD 2.5" SATA',
  3000,
  '{"manufacturer":"AMD","interface":"SATA 6.0 Gb/s","capacity":120,"capacityGB":"120GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD RADEON-R7SSD-120G 120GB SSD 2.5" SATA')
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
  'Western Digital Black 250GB HDD 7200RPM 2.5" SATA',
  3000,
  '{"manufacturer":"Western Digital","interface":"SATA 6.0 Gb/s","capacity":250,"capacityGB":"250GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Western Digital Black 250GB HDD 7200RPM 2.5" SATA')
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
  'Corsair MP600 PRO NH 1TB M.2 SSD PCIe 4.0 NVMe',
  3000,
  '{"manufacturer":"Corsair","interface":"M.2 PCIe 4.0 X4","capacity":1000,"capacityGB":"1000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair MP600 PRO NH 1TB M.2 SSD PCIe 4.0 NVMe')
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
  'Klevv CRAS C910 4TB SSD M.2-2280 PCIe 4.0 x4 NVMe',
  3000,
  '{"manufacturer":"Klevv","interface":"M.2 PCIe 4.0 X4","capacity":4000,"capacityGB":"4000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Klevv CRAS C910 4TB SSD M.2-2280 PCIe 4.0 x4 NVMe')
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
  'Addlink S20 1TB SSD 2.5" SATA',
  3000,
  '{"manufacturer":"Addlink","interface":"SATA 6.0 Gb/s","capacity":1000,"capacityGB":"1000GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Addlink S20 1TB SSD 2.5" SATA')
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
  'Samsung 990 Pro w/Heatsink 2TB SSD M.2-2280 PCIe 4.0 NVMe',
  3000,
  '{"manufacturer":"Samsung","interface":"M.2 PCIe 4.0 X4","capacity":2000,"capacityGB":"2000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Samsung 990 Pro w/Heatsink 2TB SSD M.2-2280 PCIe 4.0 NVMe')
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
  'Western Digital Gold 10TB HDD 3.5" 7200RPM SATA',
  3000,
  '{"manufacturer":"Western Digital","interface":"SATA 6.0 Gb/s","capacity":10000,"capacityGB":"10000GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Western Digital Gold 10TB HDD 3.5" 7200RPM SATA')
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
  'Crucial P5 2TB M.2-2280 SSD PCIe 3.0 x4 NVMe',
  3000,
  '{"manufacturer":"Crucial","interface":"M.2 PCIe 3.0 X4","capacity":2000,"capacityGB":"2000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Crucial P5 2TB M.2-2280 SSD PCIe 3.0 x4 NVMe')
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
  'PNY CS900 120GB 2.5" SSD SATA',
  3000,
  '{"manufacturer":"PNY","interface":"SATA 6.0 Gb/s","capacity":120,"capacityGB":"120GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('PNY CS900 120GB 2.5" SSD SATA')
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
  'Seagate Enterprise Capacity 8TB HDD 3.5" SAS',
  3000,
  '{"manufacturer":"Seagate","interface":"SAS 12.0 Gb/s","capacity":8000,"capacityGB":"8000GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Seagate Enterprise Capacity 8TB HDD 3.5" SAS')
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
  'Patriot P210 512GB SSD 2.5" SATA 6.0 Gb/s',
  3000,
  '{"manufacturer":"Patriot","interface":"SATA 6.0 Gb/s","capacity":512,"capacityGB":"512GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Patriot P210 512GB SSD 2.5" SATA 6.0 Gb/s')
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
  'Netac NV2000 512GB SSD M.2-2280 PCIe 3.0 X4 NVMe',
  3000,
  '{"manufacturer":"Netac","interface":"M.2 PCIe 3.0 X4","capacity":512,"capacityGB":"512GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Netac NV2000 512GB SSD M.2-2280 PCIe 3.0 X4 NVMe')
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
  'ADATA Swordfish 1TB SSD M.2-2280 PCIe 3.0 X4 NVMe',
  3000,
  '{"manufacturer":"ADATA","interface":"M.2 PCIe 3.0 X4","capacity":1000,"capacityGB":"1000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ADATA Swordfish 1TB SSD M.2-2280 PCIe 3.0 X4 NVMe')
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
  'Samsung SM951 128GB M.2-2280 SSD PCIe 3.0 x4 NVMe',
  3000,
  '{"manufacturer":"Samsung","interface":"M.2 PCIe 3.0 X4","capacity":128,"capacityGB":"128GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Samsung SM951 128GB M.2-2280 SSD PCIe 3.0 x4 NVMe')
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
  'Western Digital WD Blue 250 GB SSD 2.5" SATA 6.0 Gb/s',
  3000,
  '{"manufacturer":"Western Digital","interface":"SATA 6.0 Gb/s","capacity":250,"capacityGB":"250GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Western Digital WD Blue 250 GB SSD 2.5" SATA 6.0 Gb/s')
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
  'Kingston FURY 480GB SSD 2.5" SATA',
  3000,
  '{"manufacturer":"Kingston","interface":"SATA 6.0 Gb/s","capacity":480,"capacityGB":"480GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Kingston FURY 480GB SSD 2.5" SATA')
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
  'Klevv CRAS C710 512GB SSD M.2-2280 PCIe 3.0 NVMe',
  3000,
  '{"manufacturer":"Klevv","interface":"M.2 PCIe 3.0 X4","capacity":512,"capacityGB":"512GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Klevv CRAS C710 512GB SSD M.2-2280 PCIe 3.0 NVMe')
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
  'Hitachi 7K1000.C 500GB HDD 3.5" 7200RPM SATA 3.0 Gb/s Internal',
  3000,
  '{"manufacturer":"Hitachi","interface":"SATA 3.0 Gb/s","capacity":500,"capacityGB":"500GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Hitachi 7K1000.C 500GB HDD 3.5" 7200RPM SATA 3.0 Gb/s Internal')
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
  'ADATA Ultimate SU650 240GB SSD 2.5" SATA',
  3000,
  '{"manufacturer":"ADATA","interface":"SATA 6.0 Gb/s","capacity":240,"capacityGB":"240GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ADATA Ultimate SU650 240GB SSD 2.5" SATA')
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
  'ADATA Ultimate SU650 960GB 2.5" SSD SATA',
  3000,
  '{"manufacturer":"ADATA","interface":"SATA 6.0 Gb/s","capacity":960,"capacityGB":"960GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ADATA Ultimate SU650 960GB 2.5" SSD SATA')
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
  'TEAMGROUP GX2 256GB SSD 2.5" SATA',
  3000,
  '{"manufacturer":"TEAMGROUP","interface":"SATA 6.0 Gb/s","capacity":256,"capacityGB":"256GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('TEAMGROUP GX2 256GB SSD 2.5" SATA')
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
  'Intel 600p 128GB SSD M.2-2280 PCIe 3.0 x4 NVMe',
  3000,
  '{"manufacturer":"Intel","interface":"M.2 PCIe 3.0 X4","capacity":128,"capacityGB":"128GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel 600p 128GB SSD M.2-2280 PCIe 3.0 x4 NVMe')
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
  'Silicon Power US70 1TB M.2 SSD PCIe 4.0 NVMe',
  3000,
  '{"manufacturer":"Silicon Power","interface":"M.2 PCIe 4.0 X4","capacity":1000,"capacityGB":"1000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silicon Power US70 1TB M.2 SSD PCIe 4.0 NVMe')
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
  'Lexar Professional NM800PRO w/Heatsink 2TB SSD M.2-2280 PCIe 4.0 x4 NVMe',
  3000,
  '{"manufacturer":"Lexar","interface":"M.2 PCIe 4.0 X4","capacity":2000,"capacityGB":"2000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Lexar Professional NM800PRO w/Heatsink 2TB SSD M.2-2280 PCIe 4.0 x4 NVMe')
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
  'Apacer AS2280P4U Pro 2TB SSD M.2-2280 PCIe 3.0 x4 NVMe',
  3000,
  '{"manufacturer":"Apacer","interface":"M.2 PCIe 3.0 X4","capacity":2000,"capacityGB":"2000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Apacer AS2280P4U Pro 2TB SSD M.2-2280 PCIe 3.0 x4 NVMe')
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
  'Inland TN450 1TB M.2-2280 SSD PCIe 4.0 X4 NVMe',
  3000,
  '{"manufacturer":"Inland","interface":"M.2 PCIe 4.0 X4","capacity":1000,"capacityGB":"1000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Inland TN450 1TB M.2-2280 SSD PCIe 4.0 X4 NVMe')
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
  'Corsair MP600 ELITE 4TB M.2 SSD NVMe PCIe 4.0',
  3000,
  '{"manufacturer":"Corsair","interface":"M.2 PCIe 4.0 X4","capacity":4000,"capacityGB":"4000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair MP600 ELITE 4TB M.2 SSD NVMe PCIe 4.0')
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
  'Seagate Exos X16 14TB HDD 3.5" 7200RPM SATA',
  3000,
  '{"manufacturer":"Seagate","interface":"SATA 6.0 Gb/s","capacity":14000,"capacityGB":"14000GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Seagate Exos X16 14TB HDD 3.5" 7200RPM SATA')
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
  'Seagate Exos X18 16TB HDD 3.5" SAS 12.0 Gb/s',
  3000,
  '{"manufacturer":"Seagate","interface":"SAS 12.0 Gb/s","capacity":16000,"capacityGB":"16000GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Seagate Exos X18 16TB HDD 3.5" SAS 12.0 Gb/s')
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
  'Intel Pro 7600p 1TB SSD M.2-2280 PCIe 3.0 x4 NVMe',
  3000,
  '{"manufacturer":"Intel","interface":"M.2 PCIe 3.0 X4","capacity":1000,"capacityGB":"1000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel Pro 7600p 1TB SSD M.2-2280 PCIe 3.0 x4 NVMe')
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
  'Sabrent Rocket 256GB SSD M.2-2280 PCIe 3.0 x4 NVMe',
  3000,
  '{"manufacturer":"Sabrent","interface":"M.2 PCIe 3.0 X4","capacity":256,"capacityGB":"256GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Sabrent Rocket 256GB SSD M.2-2280 PCIe 3.0 x4 NVMe')
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
  'Intel 520 480GB SSD 2.5" SATA 6.0 Gb/s',
  3000,
  '{"manufacturer":"Intel","interface":"SATA 6.0 Gb/s","capacity":480,"capacityGB":"480GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel 520 480GB SSD 2.5" SATA 6.0 Gb/s')
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
  'Toshiba MG04ACA200E 2TB HDD 7200RPM 3.5" SATA',
  3000,
  '{"manufacturer":"Toshiba","interface":"SATA 6.0 Gb/s","capacity":2000,"capacityGB":"2000GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Toshiba MG04ACA200E 2TB HDD 7200RPM 3.5" SATA')
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
  'Western Digital Ultrastar 8TB HDD 3.5" SATA',
  3000,
  '{"manufacturer":"Western Digital","interface":"SATA 6.0 Gb/s","capacity":8000,"capacityGB":"8000GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Western Digital Ultrastar 8TB HDD 3.5" SATA')
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
  'Silicon Power P34A80 512GB SSD M.2-2280 PCIe 3.0 X4 NVME',
  3000,
  '{"manufacturer":"Silicon Power","interface":"M.2 PCIe 3.0 X4","capacity":512,"capacityGB":"512GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silicon Power P34A80 512GB SSD M.2-2280 PCIe 3.0 X4 NVME')
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
  'Seagate IronWolf 6TB NAS Hard Drive 7200 RPM 256MB Cache SATA 6.0Gb/s CMR 3.5" Internal HDD for RAID Network Attached Storage ST6000VN0033',
  3000,
  '{"manufacturer":"Seagate Bare Drives","interface":"SATA 6Gb/s","capacity":6000,"capacityGB":"6000GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Seagate IronWolf 6TB NAS Hard Drive 7200 RPM 256MB Cache SATA 6.0Gb/s CMR 3.5" Internal HDD for RAID Network Attached Storage ST6000VN0033')
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
  'Mushkin Tempest 256GB M.2-2280 SSD PCIe 3.0 X4 NVMe',
  3000,
  '{"manufacturer":"Mushkin","interface":"M.2 PCIe 3.0 X4","capacity":256,"capacityGB":"256GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Mushkin Tempest 256GB M.2-2280 SSD PCIe 3.0 X4 NVMe')
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
  'Seagate FireCuda 120 500GB SSD 2.5" SATA 6.0 Gb/s',
  3000,
  '{"manufacturer":"Seagate","interface":"SATA 6.0 Gb/s","capacity":500,"capacityGB":"500GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Seagate FireCuda 120 500GB SSD 2.5" SATA 6.0 Gb/s')
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
  'Crucial P310 2TB M.2 SSD PCIe 4.0 NVMe',
  3000,
  '{"manufacturer":"Crucial","interface":"M.2 PCIe 4.0 X4","capacity":2000,"capacityGB":"2000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Crucial P310 2TB M.2 SSD PCIe 4.0 NVMe')
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
  'Intel DC S3500 800GB SSD 2.5" SATA',
  3000,
  '{"manufacturer":"Intel","interface":"SATA 6.0 Gb/s","capacity":800,"capacityGB":"800GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Intel DC S3500 800GB SSD 2.5" SATA')
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
  'Toshiba MG09 512e 16TB 3.5" HDD 7200RPM SATA',
  3000,
  '{"manufacturer":"Toshiba","interface":"SATA 6.0 Gb/s","capacity":16000,"capacityGB":"16000GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Toshiba MG09 512e 16TB 3.5" HDD 7200RPM SATA')
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
  'Samsung 850 Pro 128GB SSD 2.5" SATA',
  3000,
  '{"manufacturer":"Samsung","interface":"SATA 6.0 Gb/s","capacity":128,"capacityGB":"128GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Samsung 850 Pro 128GB SSD 2.5" SATA')
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
  'Verbatim Vi3000 512GB SSD M.2-2280 PCIe 3.0 x4 NVMe',
  3000,
  '{"manufacturer":"Verbatim","interface":"M.2 PCIe 3.0 X4","capacity":512,"capacityGB":"512GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Verbatim Vi3000 512GB SSD M.2-2280 PCIe 3.0 x4 NVMe')
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
  'PNY CS2230 1TB SSD M.2-2280 PCIe 3.0 X4 NVMe',
  3000,
  '{"manufacturer":"PNY","interface":"M.2 PCIe 3.0 X4","capacity":1000,"capacityGB":"1000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('PNY CS2230 1TB SSD M.2-2280 PCIe 3.0 X4 NVMe')
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
  'Western Digital Purple Pro 18TB HDD 7200RPM 3.5" SATA',
  3000,
  '{"manufacturer":"Western Digital","interface":"SATA 6.0 Gb/s","capacity":18000,"capacityGB":"18000GB","formFactor":"3.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Western Digital Purple Pro 18TB HDD 7200RPM 3.5" SATA')
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
  'Crucial P1 2TB M.2-2280 SSD PCIe 3.0 X4 NVMe',
  3000,
  '{"manufacturer":"Crucial","interface":"M.2 PCIe 3.0 X4","capacity":2000,"capacityGB":"2000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Crucial P1 2TB M.2-2280 SSD PCIe 3.0 X4 NVMe')
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
  'Corsair MP510 480GB SSD M.2 PCIe 3.0 NVMe',
  3000,
  '{"manufacturer":"Corsair","interface":"M.2 PCIe 3.0 X4","capacity":480,"capacityGB":"480GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair MP510 480GB SSD M.2 PCIe 3.0 NVMe')
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
  'Samsung PM893 240 GB SSD 2.5" SATA 6.0 Gb/s',
  3000,
  '{"manufacturer":"Samsung","interface":"SATA 6.0 Gb/s","capacity":240,"capacityGB":"240GB","formFactor":"2.5\"","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Samsung PM893 240 GB SSD 2.5" SATA 6.0 Gb/s')
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
  'Corsair CSSD-F4000GBMP600PHX 4TB SSD M.2-2280 PCIe 4.0 x4 NVMe',
  3000,
  '{"manufacturer":"Corsair","interface":"M.2 PCIe 4.0 X4","capacity":4000,"capacityGB":"4000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair CSSD-F4000GBMP600PHX 4TB SSD M.2-2280 PCIe 4.0 x4 NVMe')
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
  'ADATA LEGEND 800 GOLD 2TB M.2 SSD PCIe 4.0 NVMe',
  3000,
  '{"manufacturer":"ADATA","interface":"M.2 PCIe 4.0 X4","capacity":2000,"capacityGB":"2000GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ADATA LEGEND 800 GOLD 2TB M.2 SSD PCIe 4.0 NVMe')
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
  'Silicon Power A80 256GB M.2 SSD PCIe 3.0 NVMe',
  3000,
  '{"manufacturer":"Silicon Power","interface":"M.2 PCIe 3.0 X4","capacity":256,"capacityGB":"256GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silicon Power A80 256GB M.2 SSD PCIe 3.0 NVMe')
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
  'XOC G300 512GB SSD M.2-2280 PCIe 3.0 X4 NVMe',
  3000,
  '{"manufacturer":"XOC","interface":"M.2 PCIe 3.0 X4","capacity":512,"capacityGB":"512GB","formFactor":"M.2-2280","readSpeed":null,"writeSpeed":null}'::jsonb,
  4,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('XOC G300 512GB SSD M.2-2280 PCIe 3.0 X4 NVMe')
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
  'Inno3D iChill X3 GeForce RTX 4070 SUPER 12GB GDDR6X Black',
  15000,
  '{"manufacturer":"Inno3D","memory":12,"vram":12,"memoryType":"GDDR6X","powerRequirement":220,"tdp":220,"tdpRating":"220W","length":334,"width":null,"height":null,"dimensions":{"length":334,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Inno3D iChill X3 GeForce RTX 4070 SUPER 12GB GDDR6X Black')
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
  'PowerColor AXR7 240 4GBD5-HLEV2 Radeon R7 240 4GB GDDR5 Black',
  15000,
  '{"manufacturer":"PowerColor","memory":4,"vram":4,"memoryType":"GDDR5","powerRequirement":30,"tdp":30,"tdpRating":"30W","length":146,"width":null,"height":null,"dimensions":{"length":146,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('PowerColor AXR7 240 4GBD5-HLEV2 Radeon R7 240 4GB GDDR5 Black')
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
  'Sapphire PULSE Radeon RX 5700 8GB GDDR6 Black / Red',
  15000,
  '{"manufacturer":"Sapphire","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":187,"tdp":187,"tdpRating":"187W","length":254,"width":null,"height":null,"dimensions":{"length":254,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Sapphire PULSE Radeon RX 5700 8GB GDDR6 Black / Red')
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
  'Gigabyte GAMING OC GeForce RTX 3060 8GB GDDR6 Black / Silver',
  15000,
  '{"manufacturer":"Gigabyte","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":170,"tdp":170,"tdpRating":"170W","length":198,"width":null,"height":null,"dimensions":{"length":198,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte GAMING OC GeForce RTX 3060 8GB GDDR6 Black / Silver')
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
  'PNY Quadro RTX 8000 VCQRTX8000-PB 48GB GDDR6 Black / White',
  15000,
  '{"manufacturer":"PNY","memory":48,"vram":48,"memoryType":"GDDR6","powerRequirement":295,"tdp":295,"tdpRating":"295W","length":267,"width":null,"height":null,"dimensions":{"length":267,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('PNY Quadro RTX 8000 VCQRTX8000-PB 48GB GDDR6 Black / White')
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
  'MSI GAMING OC GeForce RTX 5060 Ti 8GB GDDR7 Black',
  15000,
  '{"manufacturer":"MSI","memory":8,"vram":8,"memoryType":"GDDR7","powerRequirement":180,"tdp":180,"tdpRating":"180W","length":247,"width":null,"height":null,"dimensions":{"length":247,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI GAMING OC GeForce RTX 5060 Ti 8GB GDDR7 Black')
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
  'MSI Radeon R7 250 OC 2GB DDR3 Black / Blue',
  15000,
  '{"manufacturer":"MSI","memory":2,"vram":2,"memoryType":"DDR3","powerRequirement":65,"tdp":65,"tdpRating":"65W","length":110,"width":null,"height":null,"dimensions":{"length":110,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI Radeon R7 250 OC 2GB DDR3 Black / Blue')
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
  'PowerColor Fighter AMD Radeon RX 6800 Gaming Graphics card with 16GB GDDR6 Memory, Powered by AMD RDNA 2, Raytracing, PCI Express 4.0, HDMI 2.1, AM...',
  15000,
  '{"manufacturer":"PowerColor","memory":16,"vram":16,"memoryType":"GDDR6","powerRequirement":250,"tdp":250,"tdpRating":"250W","length":300,"width":null,"height":null,"dimensions":{"length":300,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('PowerColor Fighter AMD Radeon RX 6800 Gaming Graphics card with 16GB GDDR6 Memory, Powered by AMD RDNA 2, Raytracing, PCI Express 4.0, HDMI 2.1, AM...')
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
  'MSI SUPRIM X GeForce RTX 4080 16GB GDDR6X Black',
  15000,
  '{"manufacturer":"MSI","memory":16,"vram":16,"memoryType":"GDDR6X","powerRequirement":320,"tdp":320,"tdpRating":"320W","length":336,"width":null,"height":null,"dimensions":{"length":336,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI SUPRIM X GeForce RTX 4080 16GB GDDR6X Black')
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
  'AMD Radeon RX 6800 XT Black / Silver 16GB GDDR6',
  15000,
  '{"manufacturer":"AMD","memory":16,"vram":16,"memoryType":"GDDR6","powerRequirement":300,"tdp":300,"tdpRating":"300W","length":267,"width":null,"height":null,"dimensions":{"length":267,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD Radeon RX 6800 XT Black / Silver 16GB GDDR6')
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
  'EVGA 03G-P3-1595-AR GeForce GTX 580 3 GB',
  15000,
  '{"manufacturer":"EVGA","memory":3,"vram":3,"memoryType":"GDDR5","powerRequirement":244,"tdp":244,"tdpRating":"244W","length":279,"width":null,"height":null,"dimensions":{"length":279,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('EVGA 03G-P3-1595-AR GeForce GTX 580 3 GB')
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
  'MSI GeForce GTX 1050 2GB GDDR5 Black / White',
  15000,
  '{"manufacturer":"MSI","memory":2,"vram":2,"memoryType":"GDDR5","powerRequirement":75,"tdp":75,"tdpRating":"75W","length":215,"width":null,"height":null,"dimensions":{"length":215,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI GeForce GTX 1050 2GB GDDR5 Black / White')
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
  'GALAX EX GeForce RTX 5060 Ti 8GB GDDR7 Black',
  15000,
  '{"manufacturer":"GALAX","memory":8,"vram":8,"memoryType":"GDDR7","powerRequirement":180,"tdp":180,"tdpRating":"180W","length":255,"width":null,"height":null,"dimensions":{"length":255,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('GALAX EX GeForce RTX 5060 Ti 8GB GDDR7 Black')
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
  'Asus DUAL GeForce RTX 5070 12GB GDDR7 Black / Silver',
  15000,
  '{"manufacturer":"Asus","memory":12,"vram":12,"memoryType":"GDDR7","powerRequirement":250,"tdp":250,"tdpRating":"250W","length":249,"width":null,"height":null,"dimensions":{"length":249,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus DUAL GeForce RTX 5070 12GB GDDR7 Black / Silver')
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
  'Gigabyte GAMING OC GeForce RTX 2070 SUPER 8GB GDDR6 White',
  15000,
  '{"manufacturer":"Gigabyte","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":215,"tdp":215,"tdpRating":"215W","length":286,"width":null,"height":null,"dimensions":{"length":286,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte GAMING OC GeForce RTX 2070 SUPER 8GB GDDR6 White')
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
  'Sapphire PULSE Radeon RX 580 4GB GDDR5 Black',
  15000,
  '{"manufacturer":"Sapphire","memory":4,"vram":4,"memoryType":"GDDR5","powerRequirement":225,"tdp":225,"tdpRating":"225W","length":230,"width":null,"height":null,"dimensions":{"length":230,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Sapphire PULSE Radeon RX 580 4GB GDDR5 Black')
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
  'PNY XLR8 Gaming VERTO EPIC-X RGB GeForce RTX 4070 Ti 12GB GDDR6X Black',
  15000,
  '{"manufacturer":"PNY","memory":12,"vram":12,"memoryType":"GDDR6X","powerRequirement":285,"tdp":285,"tdpRating":"285W","length":332,"width":null,"height":null,"dimensions":{"length":332,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('PNY XLR8 Gaming VERTO EPIC-X RGB GeForce RTX 4070 Ti 12GB GDDR6X Black')
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
  'XFX FATBOY Radeon RX 590 8GB GDDR5 Black / Red',
  15000,
  '{"manufacturer":"XFX","memory":8,"vram":8,"memoryType":"GDDR5","powerRequirement":225,"tdp":225,"tdpRating":"225W","length":270,"width":null,"height":null,"dimensions":{"length":270,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('XFX FATBOY Radeon RX 590 8GB GDDR5 Black / Red')
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
  'Gigabyte GAMING GeForce GTX 1050 Ti 4GB GDDR5 Black',
  15000,
  '{"manufacturer":"Gigabyte","memory":4,"vram":4,"memoryType":"GDDR5","powerRequirement":75,"tdp":75,"tdpRating":"75W","length":219,"width":null,"height":null,"dimensions":{"length":219,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte GAMING GeForce GTX 1050 Ti 4GB GDDR5 Black')
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
  'Acer Nitro Intel Arc B570 OC 10GB',
  15000,
  '{"manufacturer":"Acer","memory":10,"vram":10,"memoryType":"GDDR6","powerRequirement":185,"tdp":185,"tdpRating":"185W","length":null,"width":null,"height":null,"dimensions":null,"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Acer Nitro Intel Arc B570 OC 10GB')
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
  'Gigabyte WINDFORCE OC SFF GeForce RTX 5070 Ti 16 GB',
  15000,
  '{"manufacturer":"Gigabyte","memory":16,"vram":16,"memoryType":"GDDR7","powerRequirement":300,"tdp":300,"tdpRating":"300W","length":304,"width":null,"height":null,"dimensions":{"length":304,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte WINDFORCE OC SFF GeForce RTX 5070 Ti 16 GB')
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
  'MSI AERO ITX OC GeForce RTX 3050 8GB 8 GB',
  15000,
  '{"manufacturer":"MSI","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":130,"tdp":130,"tdpRating":"130W","length":172,"width":null,"height":null,"dimensions":{"length":172,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI AERO ITX OC GeForce RTX 3050 8GB 8 GB')
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
  'Zotac GAMING Trinity GeForce RTX 3090 24GB GDDR6X Black',
  15000,
  '{"manufacturer":"Zotac","memory":24,"vram":24,"memoryType":"GDDR6X","powerRequirement":350,"tdp":350,"tdpRating":"350W","length":318,"width":null,"height":null,"dimensions":{"length":318,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Zotac GAMING Trinity GeForce RTX 3090 24GB GDDR6X Black')
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
  'MSI OC Radeon RX 460 4GB GDDR5 Black / White',
  15000,
  '{"manufacturer":"MSI","memory":4,"vram":4,"memoryType":"GDDR5","powerRequirement":84,"tdp":84,"tdpRating":"84W","length":172,"width":null,"height":null,"dimensions":{"length":172,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI OC Radeon RX 460 4GB GDDR5 Black / White')
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
  'XFX Swift OC Radeon RX 9060 XT 8GB GDDR6 White Triple Fan ',
  15000,
  '{"manufacturer":"XFX","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":150,"tdp":150,"tdpRating":"150W","length":290,"width":null,"height":null,"dimensions":{"length":290,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('XFX Swift OC Radeon RX 9060 XT 8GB GDDR6 White Triple Fan ')
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
  'Inno3D GeForce RTX 4070 SUPER X3 OC 12GB GDDR6X Black / Silver',
  15000,
  '{"manufacturer":"Inno3D","memory":12,"vram":12,"memoryType":"GDDR6X","powerRequirement":220,"tdp":220,"tdpRating":"220W","length":297,"width":null,"height":null,"dimensions":{"length":297,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Inno3D GeForce RTX 4070 SUPER X3 OC 12GB GDDR6X Black / Silver')
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
  'XFX Speedster MERC 319 Radeon RX 6900 XT 16GB GDDR6 Black',
  15000,
  '{"manufacturer":"XFX","memory":16,"vram":16,"memoryType":"GDDR6","powerRequirement":300,"tdp":300,"tdpRating":"300W","length":340,"width":null,"height":null,"dimensions":{"length":340,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('XFX Speedster MERC 319 Radeon RX 6900 XT 16GB GDDR6 Black')
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
  'MSI GT 1030 LP OC Black GeForce GT 1030 2GB GDDR5 Black',
  15000,
  '{"manufacturer":"MSI","memory":2,"vram":2,"memoryType":"GDDR5","powerRequirement":30,"tdp":30,"tdpRating":"30W","length":153,"width":null,"height":null,"dimensions":{"length":153,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI GT 1030 LP OC Black GeForce GT 1030 2GB GDDR5 Black')
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
  'MSI Gaming X Trio GeForce RTX 3060 12GB GDDR6 Black',
  15000,
  '{"manufacturer":"MSI","memory":12,"vram":12,"memoryType":"GDDR6","powerRequirement":170,"tdp":170,"tdpRating":"170W","length":323,"width":null,"height":null,"dimensions":{"length":323,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI Gaming X Trio GeForce RTX 3060 12GB GDDR6 Black')
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
  'Asus TUF GAMING OC Radeon RX 6950 XT 16GB GDDR6 Black',
  15000,
  '{"manufacturer":"Asus","memory":16,"vram":16,"memoryType":"GDDR6","powerRequirement":335,"tdp":335,"tdpRating":"335W","length":320,"width":null,"height":null,"dimensions":{"length":320,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus TUF GAMING OC Radeon RX 6950 XT 16GB GDDR6 Black')
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
  'XFX Speedster MERC 310 Black Edition Radeon RX 7900 XTX 24 GB',
  15000,
  '{"manufacturer":"XFX","memory":24,"vram":24,"memoryType":"GDDR6","powerRequirement":355,"tdp":355,"tdpRating":"355W","length":344,"width":null,"height":null,"dimensions":{"length":344,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('XFX Speedster MERC 310 Black Edition Radeon RX 7900 XTX 24 GB')
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
  'MSI Ventus GeForce RTX 2070 8GB GDDR6 Silver / Black',
  15000,
  '{"manufacturer":"MSI","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":185,"tdp":185,"tdpRating":"185W","length":226,"width":null,"height":null,"dimensions":{"length":226,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI Ventus GeForce RTX 2070 8GB GDDR6 Silver / Black')
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
  'PNY VCGGTX1050T4XGPB-OC GeForce GTX 1050 Ti 4GB GDDR5 Black / Red',
  15000,
  '{"manufacturer":"PNY","memory":4,"vram":4,"memoryType":"GDDR5","powerRequirement":75,"tdp":75,"tdpRating":"75W","length":245,"width":null,"height":null,"dimensions":{"length":245,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('PNY VCGGTX1050T4XGPB-OC GeForce GTX 1050 Ti 4GB GDDR5 Black / Red')
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
  'MSI SEA HAWK X GeForce RTX 2080 8GB GDDR6 Black / Silver',
  15000,
  '{"manufacturer":"MSI","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":215,"tdp":215,"tdpRating":"215W","length":268,"width":null,"height":null,"dimensions":{"length":268,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI SEA HAWK X GeForce RTX 2080 8GB GDDR6 Black / Silver')
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
  'Asus DUAL OC Radeon RX 7900 XT 20GB GDDR6 Black',
  15000,
  '{"manufacturer":"Asus","memory":20,"vram":20,"memoryType":"GDDR6","powerRequirement":300,"tdp":300,"tdpRating":"300W","length":323,"width":null,"height":null,"dimensions":{"length":323,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus DUAL OC Radeon RX 7900 XT 20GB GDDR6 Black')
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
  'Asus TUF GAMING OC V2 GeForce RTX 3070 LHR 8GB GDDR6 Black',
  15000,
  '{"manufacturer":"Asus","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":220,"tdp":220,"tdpRating":"220W","length":300,"width":null,"height":null,"dimensions":{"length":300,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus TUF GAMING OC V2 GeForce RTX 3070 LHR 8GB GDDR6 Black')
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
  'Asus DUAL EVO GeForce RTX 2060 6GB GDDR6 Black',
  15000,
  '{"manufacturer":"Asus","memory":6,"vram":6,"memoryType":"GDDR6","powerRequirement":160,"tdp":160,"tdpRating":"160W","length":242,"width":null,"height":null,"dimensions":{"length":242,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus DUAL EVO GeForce RTX 2060 6GB GDDR6 Black')
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
  'PNY RTX A-Series RTX A5500 24GB GDDR6 Black',
  15000,
  '{"manufacturer":"PNY","memory":24,"vram":24,"memoryType":"GDDR6","powerRequirement":230,"tdp":230,"tdpRating":"230W","length":267,"width":null,"height":null,"dimensions":{"length":267,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('PNY RTX A-Series RTX A5500 24GB GDDR6 Black')
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
  'MSI GAMING X SLIM GeForce RTX 4080 SUPER 16GB GDDR6X White',
  15000,
  '{"manufacturer":"MSI","memory":16,"vram":16,"memoryType":"GDDR6X","powerRequirement":320,"tdp":320,"tdpRating":"320W","length":322,"width":null,"height":null,"dimensions":{"length":322,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI GAMING X SLIM GeForce RTX 4080 SUPER 16GB GDDR6X White')
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
  'Asus STRIX GAMING GeForce RTX 3080 10GB GDDR6X Black',
  15000,
  '{"manufacturer":"Asus","memory":10,"vram":10,"memoryType":"GDDR6X","powerRequirement":320,"tdp":320,"tdpRating":"320W","length":318,"width":null,"height":null,"dimensions":{"length":318,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus STRIX GAMING GeForce RTX 3080 10GB GDDR6X Black')
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
  'Zotac GeForce RTX 3080 12GB LHR GAMING Trinity OC 12GB GDDR6X Black',
  15000,
  '{"manufacturer":"Zotac","memory":12,"vram":12,"memoryType":"GDDR6X","powerRequirement":350,"tdp":350,"tdpRating":"350W","length":318,"width":null,"height":null,"dimensions":{"length":318,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Zotac GeForce RTX 3080 12GB LHR GAMING Trinity OC 12GB GDDR6X Black')
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
  'Diamond RX580D58G Radeon RX 580 8GB GDDR5 Black / Red',
  15000,
  '{"manufacturer":"Diamond","memory":8,"vram":8,"memoryType":"GDDR5","powerRequirement":185,"tdp":185,"tdpRating":"185W","length":267,"width":null,"height":null,"dimensions":{"length":267,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Diamond RX580D58G Radeon RX 580 8GB GDDR5 Black / Red')
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
  'GALAX EX OC SNPR GeForce GTX 1080 8GB GDDR5X White',
  15000,
  '{"manufacturer":"GALAX","memory":8,"vram":8,"memoryType":"GDDR5X","powerRequirement":180,"tdp":180,"tdpRating":"180W","length":296,"width":null,"height":null,"dimensions":{"length":296,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('GALAX EX OC SNPR GeForce GTX 1080 8GB GDDR5X White')
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
  'XFX Swift OC Radeon RX 9060 XT 8GB GDDR6 White Dual Fan',
  15000,
  '{"manufacturer":"XFX","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":160,"tdp":160,"tdpRating":"160W","length":270,"width":null,"height":null,"dimensions":{"length":270,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('XFX Swift OC Radeon RX 9060 XT 8GB GDDR6 White Dual Fan')
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
  'GALAX EX Gamer (1-Click OC) GeForce RTX 4070 SUPER 12GB GDDR6X',
  15000,
  '{"manufacturer":"GALAX","memory":12,"vram":12,"memoryType":"GDDR6X","powerRequirement":220,"tdp":220,"tdpRating":"220W","length":336,"width":null,"height":null,"dimensions":{"length":336,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('GALAX EX Gamer (1-Click OC) GeForce RTX 4070 SUPER 12GB GDDR6X')
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
  'Zotac GeForce GTX 1080 AMP 8GB GDDR5X Black / Yellow',
  15000,
  '{"manufacturer":"Zotac","memory":8,"vram":8,"memoryType":"GDDR5X","powerRequirement":230,"tdp":230,"tdpRating":"230W","length":300,"width":null,"height":null,"dimensions":{"length":300,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Zotac GeForce GTX 1080 AMP 8GB GDDR5X Black / Yellow')
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
  'PowerColor Reaper Radeon RX 9060 XT 16GB GDDR6 Black',
  15000,
  '{"manufacturer":"PowerColor","memory":16,"vram":16,"memoryType":"GDDR6","powerRequirement":160,"tdp":160,"tdpRating":"160W","length":200,"width":null,"height":null,"dimensions":{"length":200,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('PowerColor Reaper Radeon RX 9060 XT 16GB GDDR6 Black')
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
  'Acer Predator BiFrost OC Radeon RX 7600 8GB GDDR6 Black',
  15000,
  '{"manufacturer":"Acer","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":165,"tdp":165,"tdpRating":"165W","length":267,"width":null,"height":null,"dimensions":{"length":267,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Acer Predator BiFrost OC Radeon RX 7600 8GB GDDR6 Black')
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
  'EVGA GeForce GT 1030 Gray 2GB GDDR5 Gray',
  15000,
  '{"manufacturer":"EVGA","memory":2,"vram":2,"memoryType":"GDDR5","powerRequirement":30,"tdp":30,"tdpRating":"30W","length":168,"width":null,"height":null,"dimensions":{"length":168,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('EVGA GeForce GT 1030 Gray 2GB GDDR5 Gray')
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
  'PowerColor Reaper Radeon RX 9060 XT 8GB GDDR6 Black',
  15000,
  '{"manufacturer":"PowerColor","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":160,"tdp":160,"tdpRating":"160W","length":200,"width":null,"height":null,"dimensions":{"length":200,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('PowerColor Reaper Radeon RX 9060 XT 8GB GDDR6 Black')
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
  'ASRock Radeon RX 5700 XT Taichi X OC+ 8GB GDDR6 Black / Gold',
  15000,
  '{"manufacturer":"ASRock","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":225,"tdp":225,"tdpRating":"225W","length":324,"width":null,"height":null,"dimensions":{"length":324,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock Radeon RX 5700 XT Taichi X OC+ 8GB GDDR6 Black / Gold')
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
  'Asus DUAL OC Radeon RX 7700 XT 12GB GDDR6 Black',
  15000,
  '{"manufacturer":"Asus","memory":12,"vram":12,"memoryType":"GDDR6","powerRequirement":245,"tdp":245,"tdpRating":"245W","length":280,"width":null,"height":null,"dimensions":{"length":280,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus DUAL OC Radeon RX 7700 XT 12GB GDDR6 Black')
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
  'Asus Blue / Silver Radeon RX 6800 16GB GDDR6 Blue / Silver',
  15000,
  '{"manufacturer":"Asus","memory":16,"vram":16,"memoryType":"GDDR6","powerRequirement":250,"tdp":250,"tdpRating":"250W","length":267,"width":null,"height":null,"dimensions":{"length":267,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus Blue / Silver Radeon RX 6800 16GB GDDR6 Blue / Silver')
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
  'EVGA GeForce GT 1030 DDR4',
  15000,
  '{"manufacturer":"EVGA","memory":2,"vram":2,"memoryType":"DDR4","powerRequirement":20,"tdp":20,"tdpRating":"20W","length":144.8,"width":null,"height":null,"dimensions":{"length":144.8,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('EVGA GeForce GT 1030 DDR4')
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
  'GALAX OC GeForce GTX 1050 Ti 4GB GDDR5 Black',
  15000,
  '{"manufacturer":"GALAX","memory":4,"vram":4,"memoryType":"GDDR5","powerRequirement":75,"tdp":75,"tdpRating":"75W","length":196,"width":null,"height":null,"dimensions":{"length":196,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('GALAX OC GeForce GTX 1050 Ti 4GB GDDR5 Black')
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
  'Asus Radeon RX 580 STRIX 8GB GDDR5 Black',
  15000,
  '{"manufacturer":"Asus","memory":8,"vram":8,"memoryType":"GDDR5","powerRequirement":185,"tdp":185,"tdpRating":"185W","length":298,"width":null,"height":null,"dimensions":{"length":298,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus Radeon RX 580 STRIX 8GB GDDR5 Black')
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
  'Zotac GAMING Twin Edge GeForce RTX 3060 12GB GDDR6 Black',
  15000,
  '{"manufacturer":"Zotac","memory":12,"vram":12,"memoryType":"GDDR6","powerRequirement":170,"tdp":170,"tdpRating":"170W","length":224,"width":null,"height":null,"dimensions":{"length":224,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Zotac GAMING Twin Edge GeForce RTX 3060 12GB GDDR6 Black')
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
  'SAPPHIRE PULSE Radeon RX 6500 XT',
  15000,
  '{"manufacturer":"Sapphire","memory":4,"vram":4,"memoryType":"GDDR6","powerRequirement":130,"tdp":130,"tdpRating":"130W","length":194,"width":null,"height":null,"dimensions":{"length":194,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('SAPPHIRE PULSE Radeon RX 6500 XT')
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
  'Sapphire Radeon RX 6950 XT TOXIC Limited Edition 16GB GDDR6 Silver / Black',
  15000,
  '{"manufacturer":"Sapphire","memory":16,"vram":16,"memoryType":"GDDR6","powerRequirement":420,"tdp":420,"tdpRating":"420W","length":270,"width":null,"height":null,"dimensions":{"length":270,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Sapphire Radeon RX 6950 XT TOXIC Limited Edition 16GB GDDR6 Silver / Black')
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
  'Acer Predator BiFrost OC Radeon RX 9070 XT 16GB GDDR6 Black / Silver',
  15000,
  '{"manufacturer":"Acer","memory":16,"vram":16,"memoryType":"GDDR6","powerRequirement":340,"tdp":340,"tdpRating":"340W","length":297,"width":null,"height":null,"dimensions":{"length":297,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Acer Predator BiFrost OC Radeon RX 9070 XT 16GB GDDR6 Black / Silver')
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
  'Gigabyte EAGLE OC Rev 2.0 GeForce RTX 3060 12GB GDDR6 Black',
  15000,
  '{"manufacturer":"Gigabyte","memory":12,"vram":12,"memoryType":"GDDR6","powerRequirement":170,"tdp":170,"tdpRating":"170W","length":242,"width":null,"height":null,"dimensions":{"length":242,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte EAGLE OC Rev 2.0 GeForce RTX 3060 12GB GDDR6 Black')
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
  'Gigabyte GAMING OC Radeon RX 9060 XT 8GB GDDR6 Black',
  15000,
  '{"manufacturer":"Gigabyte","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":160,"tdp":160,"tdpRating":"160W","length":281,"width":null,"height":null,"dimensions":{"length":281,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte GAMING OC Radeon RX 9060 XT 8GB GDDR6 Black')
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
  'Gigabyte D6 LP Radeon RX 6400 4 GB',
  15000,
  '{"manufacturer":"Gigabyte","memory":4,"vram":4,"memoryType":"GDDR6","powerRequirement":53,"tdp":53,"tdpRating":"53W","length":182,"width":null,"height":null,"dimensions":{"length":182,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte D6 LP Radeon RX 6400 4 GB')
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
  'ASRock Phantom Gaming Radeon RX 6500 XT 8GB GDDR6',
  15000,
  '{"manufacturer":"ASRock","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":107,"tdp":107,"tdpRating":"107W","length":240,"width":null,"height":null,"dimensions":{"length":240,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASRock Phantom Gaming Radeon RX 6500 XT 8GB GDDR6')
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
  'XFX Radeon RX 590 FATBOY OC+ 8GB GDDR5 Black / Red',
  15000,
  '{"manufacturer":"XFX","memory":8,"vram":8,"memoryType":"GDDR5","powerRequirement":225,"tdp":225,"tdpRating":"225W","length":270,"width":null,"height":null,"dimensions":{"length":270,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('XFX Radeon RX 590 FATBOY OC+ 8GB GDDR5 Black / Red')
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
  'AMD Radeon PRO W6800 32GB GDDR6 Blue / Gray',
  15000,
  '{"manufacturer":"AMD","memory":32,"vram":32,"memoryType":"GDDR6","powerRequirement":250,"tdp":250,"tdpRating":"250W","length":267,"width":null,"height":null,"dimensions":{"length":267,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AMD Radeon PRO W6800 32GB GDDR6 Blue / Gray')
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
  'EVGA GeForce RTX 3080 XC3 ULTRA GAMING',
  15000,
  '{"manufacturer":"EVGA","memory":10,"vram":10,"memoryType":"GDDR6X","powerRequirement":320,"tdp":320,"tdpRating":"320W","length":285,"width":null,"height":null,"dimensions":{"length":285,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('EVGA GeForce RTX 3080 XC3 ULTRA GAMING')
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
  'MSI GAMING X GeForce GTX 1070 8GB GDDR5 Black / Red',
  15000,
  '{"manufacturer":"MSI","memory":8,"vram":8,"memoryType":"GDDR5","powerRequirement":150,"tdp":150,"tdpRating":"150W","length":279,"width":null,"height":null,"dimensions":{"length":279,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI GAMING X GeForce GTX 1070 8GB GDDR5 Black / Red')
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
  'GIGABYTE Eagle GeForce GTX 1650 4GB GDDR6 PCI Express 3.0 x16 ATX Video Card GV-N1656EAGLE OC-4GD',
  15000,
  '{"manufacturer":"GIGABYTE","memory":4,"vram":4,"memoryType":"GDDR6","powerRequirement":85,"tdp":85,"tdpRating":"85W","length":212,"width":null,"height":null,"dimensions":{"length":212,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('GIGABYTE Eagle GeForce GTX 1650 4GB GDDR6 PCI Express 3.0 x16 ATX Video Card GV-N1656EAGLE OC-4GD')
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
  'PowerColor Red Devil Radeon RX VEGA 64 8GB HBM2 Red / Black',
  15000,
  '{"manufacturer":"PowerColor","memory":8,"vram":8,"memoryType":"HBM2","powerRequirement":295,"tdp":295,"tdpRating":"295W","length":316,"width":null,"height":null,"dimensions":{"length":316,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('PowerColor Red Devil Radeon RX VEGA 64 8GB HBM2 Red / Black')
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
  'Asus GeForce RTX 4060 Ti ROG Strix GAMING OC 16GB GDDR6 Black / Red',
  15000,
  '{"manufacturer":"Asus","memory":16,"vram":16,"memoryType":"GDDR6","powerRequirement":165,"tdp":165,"tdpRating":"165W","length":311,"width":null,"height":null,"dimensions":{"length":311,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus GeForce RTX 4060 Ti ROG Strix GAMING OC 16GB GDDR6 Black / Red')
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
  'Gigabyte TURBO GeForce RTX 2080 Ti 11GB GDDR6 Black / Silver',
  15000,
  '{"manufacturer":"Gigabyte","memory":11,"vram":11,"memoryType":"GDDR6","powerRequirement":250,"tdp":250,"tdpRating":"250W","length":272,"width":null,"height":null,"dimensions":{"length":272,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte TURBO GeForce RTX 2080 Ti 11GB GDDR6 Black / Silver')
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
  'Palit GamingPro OC GeForce RTX 2080 Ti 11GB GDDR6 Black / Gold',
  15000,
  '{"manufacturer":"Palit","memory":11,"vram":11,"memoryType":"GDDR6","powerRequirement":260,"tdp":260,"tdpRating":"260W","length":292,"width":null,"height":null,"dimensions":{"length":292,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Palit GamingPro OC GeForce RTX 2080 Ti 11GB GDDR6 Black / Gold')
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
  'XFX Radeon RX 7600 Speedster SWFT 210 Core 8GB GDDR6 Black',
  15000,
  '{"manufacturer":"XFX","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":165,"tdp":165,"tdpRating":"165W","length":241,"width":null,"height":null,"dimensions":{"length":241,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('XFX Radeon RX 7600 Speedster SWFT 210 Core 8GB GDDR6 Black')
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
  'EVGA Black / Clear GeForce RTX 2080 Ti 11GB GDDR6 Black',
  15000,
  '{"manufacturer":"EVGA","memory":11,"vram":11,"memoryType":"GDDR6","powerRequirement":250,"tdp":250,"tdpRating":"250W","length":270,"width":null,"height":null,"dimensions":{"length":270,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('EVGA Black / Clear GeForce RTX 2080 Ti 11GB GDDR6 Black')
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
  'MSI GeForce RTX 4060 Ti GAMING X TRIO 8G',
  15000,
  '{"manufacturer":"MSI","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":160,"tdp":160,"tdpRating":"160W","length":338,"width":null,"height":null,"dimensions":{"length":338,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI GeForce RTX 4060 Ti GAMING X TRIO 8G')
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
  'Zotac GAMING SOLID GeForce RTX 4070 Ti SUPER 16GB GDDR6X Black / Gray',
  15000,
  '{"manufacturer":"Zotac","memory":16,"vram":16,"memoryType":"GDDR6X","powerRequirement":295,"tdp":295,"tdpRating":"295W","length":336,"width":null,"height":null,"dimensions":{"length":336,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Zotac GAMING SOLID GeForce RTX 4070 Ti SUPER 16GB GDDR6X Black / Gray')
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
  'Asus DirectCU II Radeon R9 270X 2 GB',
  15000,
  '{"manufacturer":"Asus","memory":2,"vram":2,"memoryType":"GDDR5","powerRequirement":180,"tdp":180,"tdpRating":"180W","length":271,"width":null,"height":null,"dimensions":{"length":271,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus DirectCU II Radeon R9 270X 2 GB')
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
  'PowerColor RX 7900 XT 20G Radeon RX 7900 XT 20 GB',
  15000,
  '{"manufacturer":"PowerColor","memory":20,"vram":20,"memoryType":"GDDR6","powerRequirement":300,"tdp":300,"tdpRating":"300W","length":276,"width":null,"height":null,"dimensions":{"length":276,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('PowerColor RX 7900 XT 20G Radeon RX 7900 XT 20 GB')
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
  'Asus DUAL GeForce RTX 4070 SUPER 12GB GDDR6X White',
  15000,
  '{"manufacturer":"Asus","memory":12,"vram":12,"memoryType":"GDDR6X","powerRequirement":220,"tdp":220,"tdpRating":"220W","length":267,"width":null,"height":null,"dimensions":{"length":267,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus DUAL GeForce RTX 4070 SUPER 12GB GDDR6X White')
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
  'Asus GeForce RTX 5060 Ti TUF GAMING OC 8GB GDDR7 Black / Silver',
  15000,
  '{"manufacturer":"Asus","memory":8,"vram":8,"memoryType":"GDDR7","powerRequirement":180,"tdp":180,"tdpRating":"180W","length":302,"width":null,"height":null,"dimensions":{"length":302,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus GeForce RTX 5060 Ti TUF GAMING OC 8GB GDDR7 Black / Silver')
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
  'AORUS GeForce RTX 2080 XTREME WATERFORCE 8G',
  15000,
  '{"manufacturer":"GIGABYTE","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":215,"tdp":215,"tdpRating":"215W","length":291,"width":null,"height":null,"dimensions":{"length":291,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('AORUS GeForce RTX 2080 XTREME WATERFORCE 8G')
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
  'MSI ARMOR OC Radeon RX 570 4GB GDDR5 Black / White',
  15000,
  '{"manufacturer":"MSI","memory":4,"vram":4,"memoryType":"GDDR5","powerRequirement":150,"tdp":150,"tdpRating":"150W","length":246,"width":null,"height":null,"dimensions":{"length":246,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI ARMOR OC Radeon RX 570 4GB GDDR5 Black / White')
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
  'EVGA BLACK GAMING GeForce GTX 1660 SUPER 6GB GDDR6 Black',
  15000,
  '{"manufacturer":"EVGA","memory":6,"vram":6,"memoryType":"GDDR6","powerRequirement":125,"tdp":125,"tdpRating":"125W","length":190,"width":null,"height":null,"dimensions":{"length":190,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('EVGA BLACK GAMING GeForce GTX 1660 SUPER 6GB GDDR6 Black')
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
  'MSI VENTUS 2X PLUS GeForce RTX 5060 Ti 8GB GDDR7 Black / Gray',
  15000,
  '{"manufacturer":"MSI","memory":8,"vram":8,"memoryType":"GDDR7","powerRequirement":180,"tdp":180,"tdpRating":"180W","length":227,"width":null,"height":null,"dimensions":{"length":227,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI VENTUS 2X PLUS GeForce RTX 5060 Ti 8GB GDDR7 Black / Gray')
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
  'Gigabyte WINDFORCE GeForce RTX 2080 Ti 11 GB',
  15000,
  '{"manufacturer":"Gigabyte","memory":11,"vram":11,"memoryType":"GDDR6","powerRequirement":250,"tdp":250,"tdpRating":"250W","length":280,"width":null,"height":null,"dimensions":{"length":280,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte WINDFORCE GeForce RTX 2080 Ti 11 GB')
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
  'Sapphire PULSE Radeon RX 7700 XT 12GB GDDR6 Black / Red',
  15000,
  '{"manufacturer":"Sapphire","memory":12,"vram":12,"memoryType":"GDDR6","powerRequirement":230,"tdp":230,"tdpRating":"230W","length":280,"width":null,"height":null,"dimensions":{"length":280,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Sapphire PULSE Radeon RX 7700 XT 12GB GDDR6 Black / Red')
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
  'Palit Dual GeForce GTX 1070 8GB GDDR5 Black',
  15000,
  '{"manufacturer":"Palit","memory":8,"vram":8,"memoryType":"GDDR5","powerRequirement":150,"tdp":150,"tdpRating":"150W","length":252,"width":null,"height":null,"dimensions":{"length":252,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Palit Dual GeForce GTX 1070 8GB GDDR5 Black')
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
  'MSI GAMING X GeForce RTX 2070 8GB GDDR6 Black',
  15000,
  '{"manufacturer":"MSI","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":185,"tdp":185,"tdpRating":"185W","length":307,"width":null,"height":null,"dimensions":{"length":307,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI GAMING X GeForce RTX 2070 8GB GDDR6 Black')
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
  'MSI SEA HAWK X GeForce GTX 1080 8GB GDDR5X Black / Silver',
  15000,
  '{"manufacturer":"MSI","memory":8,"vram":8,"memoryType":"GDDR5X","powerRequirement":180,"tdp":180,"tdpRating":"180W","length":270,"width":null,"height":null,"dimensions":{"length":270,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI SEA HAWK X GeForce GTX 1080 8GB GDDR5X Black / Silver')
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
  'MSI GAMING GeForce GTX 950 2GB GDDR5 Black / Red',
  15000,
  '{"manufacturer":"MSI","memory":2,"vram":2,"memoryType":"GDDR5","powerRequirement":90,"tdp":90,"tdpRating":"90W","length":270,"width":null,"height":null,"dimensions":{"length":270,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI GAMING GeForce GTX 950 2GB GDDR5 Black / Red')
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
  'Asus Phoenix GeForce RTX 3050 8GB GDDR6 Black',
  15000,
  '{"manufacturer":"Asus","memory":8,"vram":8,"memoryType":"GDDR6","powerRequirement":130,"tdp":130,"tdpRating":"130W","length":177,"width":null,"height":null,"dimensions":{"length":177,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus Phoenix GeForce RTX 3050 8GB GDDR6 Black')
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
  'Asus TUF GAMING OC GeForce RTX 3080 12GB LHR 12GB GDDR6X Black / Silver',
  15000,
  '{"manufacturer":"Asus","memory":12,"vram":12,"memoryType":"GDDR6X","powerRequirement":350,"tdp":350,"tdpRating":"350W","length":300,"width":null,"height":null,"dimensions":{"length":300,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus TUF GAMING OC GeForce RTX 3080 12GB LHR 12GB GDDR6X Black / Silver')
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
  'EVGA FTW3 ULTRA HYBRID GAMING iCX3 GeForce RTX 3080 Ti 12GB GDDR6X Black',
  15000,
  '{"manufacturer":"EVGA","memory":12,"vram":12,"memoryType":"GDDR6X","powerRequirement":350,"tdp":350,"tdpRating":"350W","length":300,"width":null,"height":null,"dimensions":{"length":300,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('EVGA FTW3 ULTRA HYBRID GAMING iCX3 GeForce RTX 3080 Ti 12GB GDDR6X Black')
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
  'XFX Quicksilver AMD Radeon RX 9070XT Magnetic Air Edition BLACK',
  15000,
  '{"manufacturer":"XFX","memory":16,"vram":16,"memoryType":"GDDR6","powerRequirement":304,"tdp":304,"tdpRating":"304W","length":350,"width":null,"height":null,"dimensions":{"length":350,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('XFX Quicksilver AMD Radeon RX 9070XT Magnetic Air Edition BLACK')
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
  'Asus TUF Gaming OG OC GeForce RTX 4090 24GB GDDR6X Black',
  15000,
  '{"manufacturer":"Asus","memory":24,"vram":24,"memoryType":"GDDR6X","powerRequirement":450,"tdp":450,"tdpRating":"450W","length":326,"width":null,"height":null,"dimensions":{"length":326,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus TUF Gaming OG OC GeForce RTX 4090 24GB GDDR6X Black')
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
  'Gainward Phoenix GeForce RTX 3090 24GB GDDR6X Silver / Black',
  15000,
  '{"manufacturer":"Gainward","memory":24,"vram":24,"memoryType":"GDDR6X","powerRequirement":350,"tdp":350,"tdpRating":"350W","length":294,"width":null,"height":null,"dimensions":{"length":294,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gainward Phoenix GeForce RTX 3090 24GB GDDR6X Silver / Black')
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
  'PNY GeForce RTX 5070 Ti EPIC-X RGB Triple Fan Plus 16GB GDDR7 Black',
  15000,
  '{"manufacturer":"PNY","memory":16,"vram":16,"memoryType":"GDDR7","powerRequirement":300,"tdp":300,"tdpRating":"300W","length":328,"width":null,"height":null,"dimensions":{"length":328,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('PNY GeForce RTX 5070 Ti EPIC-X RGB Triple Fan Plus 16GB GDDR7 Black')
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
  'MSI GAMING GeForce GTX 1050 Ti 4GB GDDR5 Red / Black',
  15000,
  '{"manufacturer":"MSI","memory":4,"vram":4,"memoryType":"GDDR5","powerRequirement":75,"tdp":75,"tdpRating":"75W","length":229,"width":null,"height":null,"dimensions":{"length":229,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI GAMING GeForce GTX 1050 Ti 4GB GDDR5 Red / Black')
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
  'MSI ARMOR OCV1 Radeon RX 570 4GB GDDR5 Black / White',
  15000,
  '{"manufacturer":"MSI","memory":4,"vram":4,"memoryType":"GDDR5","powerRequirement":150,"tdp":150,"tdpRating":"150W","length":246,"width":null,"height":null,"dimensions":{"length":246,"width":null,"height":null},"pcieVersion":"4.0"}'::jsonb,
  5,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI ARMOR OCV1 Radeon RX 570 4GB GDDR5 Black / White')
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
  'CoolMax ZX-600 ATX 600W Non-Modular 80+ Certified',
  3000,
  '{"manufacturer":"CoolMax","wattage":600,"powerRequirement":600,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('CoolMax ZX-600 ATX 600W Non-Modular 80+ Certified')
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
  'NZXT C850 (2024) Black 850W Fully Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"NZXT","wattage":850,"powerRequirement":850,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('NZXT C850 (2024) Black 850W Fully Modular 80+ Gold Certified')
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
  'Thermaltake Toughpower GX2 Black 600W Non-Modular 80+ Gold',
  3000,
  '{"manufacturer":"Thermaltake","wattage":600,"powerRequirement":600,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermaltake Toughpower GX2 Black 600W Non-Modular 80+ Gold')
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
  'EVGA 600 W3, 80+ WHITE 600W, 3 Year Warranty, Power Supply',
  3000,
  '{"manufacturer":"EVGA","wattage":600,"powerRequirement":600,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('EVGA 600 W3, 80+ WHITE 600W, 3 Year Warranty, Power Supply')
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
  'SeaSonic M12II EVO ATX 520W Fully Modular 80+ Bronze Certified',
  3000,
  '{"manufacturer":"SeaSonic","wattage":520,"powerRequirement":520,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('SeaSonic M12II EVO ATX 520W Fully Modular 80+ Bronze Certified')
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
  'EVGA SuperNOVA 1200 P3 1200W 80+ Platinum Certified Fully Modular',
  3000,
  '{"manufacturer":"EVGA","wattage":1200,"powerRequirement":1200,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('EVGA SuperNOVA 1200 P3 1200W 80+ Platinum Certified Fully Modular')
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
  'be quiet! System Power 9 500 CM Black 500W Semi-Modular 80+ Bronze Certified',
  3000,
  '{"manufacturer":"be quiet!","wattage":500,"powerRequirement":500,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('be quiet! System Power 9 500 CM Black 500W Semi-Modular 80+ Bronze Certified')
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
  'be quiet! Straight Power 11 550W Fully Modular 80+ Gold',
  3000,
  '{"manufacturer":"be quiet!","wattage":550,"powerRequirement":550,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('be quiet! Straight Power 11 550W Fully Modular 80+ Gold')
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
  'Antec Earthwatts Green 380W Non-Modular 80+ Bronze Certified',
  3000,
  '{"manufacturer":"Antec","wattage":380,"powerRequirement":380,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Antec Earthwatts Green 380W Non-Modular 80+ Bronze Certified')
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
  'be quiet! Straight Power 11 Black 850W Fully Modular 80+ Platinum Certified',
  3000,
  '{"manufacturer":"be quiet!","wattage":850,"powerRequirement":850,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('be quiet! Straight Power 11 Black 850W Fully Modular 80+ Platinum Certified')
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
  'Cooler Master V White SFX ATX 3.0 850W Fully Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"Cooler Master","wattage":850,"powerRequirement":850,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cooler Master V White SFX ATX 3.0 850W Fully Modular 80+ Gold Certified')
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
  'Thermalright AG-650 ATX 650W Fully Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"Thermalright","wattage":650,"powerRequirement":650,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermalright AG-650 ATX 650W Fully Modular 80+ Gold Certified')
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
  'Lian Li EDGE White 850W Fully Modular 80+ Gold',
  3000,
  '{"manufacturer":"Lian Li","wattage":850,"powerRequirement":850,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Lian Li EDGE White 850W Fully Modular 80+ Gold')
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
  'be quiet! Pure Power 11 600W Non-Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"be quiet!","wattage":600,"powerRequirement":600,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('be quiet! Pure Power 11 600W Non-Modular 80+ Gold Certified')
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
  'EVGA SuperNOVA 750 G5 ATX 750W Fully Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"EVGA","wattage":750,"powerRequirement":750,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('EVGA SuperNOVA 750 G5 ATX 750W Fully Modular 80+ Gold Certified')
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
  'FSP Group Dagger Black SFX 600W Fully Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"FSP Group","wattage":600,"powerRequirement":600,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('FSP Group Dagger Black SFX 600W Fully Modular 80+ Gold Certified')
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
  'Thermaltake TOUGHPOWER PF1 ARGB 1050W 80+ Platinum Fully Modular',
  3000,
  '{"manufacturer":"Thermaltake","wattage":1050,"powerRequirement":1050,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermaltake TOUGHPOWER PF1 ARGB 1050W 80+ Platinum Fully Modular')
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
  'Antec EARTHWATTS GOLD PRO 750W Semi-Modular 80+ Gold',
  3000,
  '{"manufacturer":"Antec","wattage":750,"powerRequirement":750,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Antec EARTHWATTS GOLD PRO 750W Semi-Modular 80+ Gold')
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
  'Corsair CX450M (2015) 450W Semi-Modular 80+ Bronze Certified ATX',
  3000,
  '{"manufacturer":"Corsair","wattage":450,"powerRequirement":450,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair CX450M (2015) 450W Semi-Modular 80+ Bronze Certified ATX')
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
  'SeaSonic S12G 650W Non-Modular 80+ Gold',
  3000,
  '{"manufacturer":"SeaSonic","wattage":650,"powerRequirement":650,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('SeaSonic S12G 650W Non-Modular 80+ Gold')
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
  'Cooler Master XG650 Black 650W Fully Modular 80+ Platinum Certified',
  3000,
  '{"manufacturer":"Cooler Master","wattage":650,"powerRequirement":650,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cooler Master XG650 Black 650W Fully Modular 80+ Platinum Certified')
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
  'StarTech ATX2POWER450 ATX 450W Non-Modular',
  3000,
  '{"manufacturer":"StarTech","wattage":450,"powerRequirement":450,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('StarTech ATX2POWER450 ATX 450W Non-Modular')
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
  'Corsair TX950 Certified ATX 950W 80+ Bronze Non-Modular',
  3000,
  '{"manufacturer":"Corsair","wattage":950,"powerRequirement":950,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair TX950 Certified ATX 950W 80+ Bronze Non-Modular')
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
  'HEC XPOWER780 ATX 600W Non-Modular',
  3000,
  '{"manufacturer":"HEC","wattage":600,"powerRequirement":600,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('HEC XPOWER780 ATX 600W Non-Modular')
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
  'Fractal Design Anode Black 750W Semi-Modular 80+ Bronze Certified',
  3000,
  '{"manufacturer":"Fractal Design","wattage":750,"powerRequirement":750,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Fractal Design Anode Black 750W Semi-Modular 80+ Bronze Certified')
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
  'Antec Signature Black 1000W Fully Modular 80+ Platinum Certified',
  3000,
  '{"manufacturer":"Antec","wattage":1000,"powerRequirement":1000,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Antec Signature Black 1000W Fully Modular 80+ Platinum Certified')
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
  'Asus ROG THOR 850P Black / Red 850W Fully Modular 80+ Platinum',
  3000,
  '{"manufacturer":"Asus","wattage":850,"powerRequirement":850,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus ROG THOR 850P Black / Red 850W Fully Modular 80+ Platinum')
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
  'Enermax REVOLUTION III Black / Gold 650W 80+ Gold Fully Modular',
  3000,
  '{"manufacturer":"Enermax","wattage":650,"powerRequirement":650,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Enermax REVOLUTION III Black / Gold 650W 80+ Gold Fully Modular')
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
  'KOLINK Classic Black/Red 400W Non-Modular 80+ Bronze Certified',
  3000,
  '{"manufacturer":"KOLINK","wattage":400,"powerRequirement":400,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('KOLINK Classic Black/Red 400W Non-Modular 80+ Bronze Certified')
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
  'Cougar COUGAR-GX700 ATX 700W Fully Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"Cougar","wattage":700,"powerRequirement":700,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cougar COUGAR-GX700 ATX 700W Fully Modular 80+ Gold Certified')
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
  'OCZ Fatal1ty 1000W Semi-Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"OCZ","wattage":1000,"powerRequirement":1000,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('OCZ Fatal1ty 1000W Semi-Modular 80+ Gold Certified')
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
  'Zalman TX ATX 700W Non-Modular',
  3000,
  '{"manufacturer":"Zalman","wattage":700,"powerRequirement":700,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Zalman TX ATX 700W Non-Modular')
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
  'Apevia ATX-CW500WP4 ATX 500W Non-Modular',
  3000,
  '{"manufacturer":"Apevia","wattage":500,"powerRequirement":500,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Apevia ATX-CW500WP4 ATX 500W Non-Modular')
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
  'Thermaltake Toughpower GF A3 - TT Premium Edition ATX 850W Fully Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"Thermaltake","wattage":850,"powerRequirement":850,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermaltake Toughpower GF A3 - TT Premium Edition ATX 850W Fully Modular 80+ Gold Certified')
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
  'EVGA 600 W1 600W Non-Modular 80+ Certified',
  3000,
  '{"manufacturer":"EVGA","wattage":600,"powerRequirement":600,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('EVGA 600 W1 600W Non-Modular 80+ Certified')
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
  'Montech APX Black 550W Non-Modular 80+ Certified',
  3000,
  '{"manufacturer":"Montech","wattage":550,"powerRequirement":550,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Montech APX Black 550W Non-Modular 80+ Certified')
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
  'Apevia ATX-AS500W-BK ATX 500W Non-Modular',
  3000,
  '{"manufacturer":"Apevia","wattage":500,"powerRequirement":500,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Apevia ATX-AS500W-BK ATX 500W Non-Modular')
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
  'OCZ ZT ATX 750W Fully Modular 80+ Bronze Certified',
  3000,
  '{"manufacturer":"OCZ","wattage":750,"powerRequirement":750,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('OCZ ZT ATX 750W Fully Modular 80+ Bronze Certified')
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
  'Antec CSK ATX 750W Semi-Modular 80+ Bronze Certified',
  3000,
  '{"manufacturer":"Antec","wattage":750,"powerRequirement":750,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Antec CSK ATX 750W Semi-Modular 80+ Bronze Certified')
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
  'be quiet! STRAIGHT POWER E9 680W / CM 680 W 80+ Gold Certified Semi-modular ATX',
  3000,
  '{"manufacturer":"be quiet!","wattage":680,"powerRequirement":680,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('be quiet! STRAIGHT POWER E9 680W / CM 680 W 80+ Gold Certified Semi-modular ATX')
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
  'Cooler Master 700W MasterWatt Lite 230V ATX 700W Non-Modular 80+ Certified',
  3000,
  '{"manufacturer":"Cooler Master","wattage":700,"powerRequirement":700,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cooler Master 700W MasterWatt Lite 230V ATX 700W Non-Modular 80+ Certified')
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
  'OCZ ModXStream Pro 600W Semi-Modular 80+',
  3000,
  '{"manufacturer":"OCZ","wattage":600,"powerRequirement":600,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('OCZ ModXStream Pro 600W Semi-Modular 80+')
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
  'Antec VP ATX 500W Non-Modular',
  3000,
  '{"manufacturer":"Antec","wattage":500,"powerRequirement":500,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Antec VP ATX 500W Non-Modular')
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
  'Antec High Current Gamer Extreme 1000W Fully Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"Antec","wattage":1000,"powerRequirement":1000,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Antec High Current Gamer Extreme 1000W Fully Modular 80+ Gold Certified')
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
  'Seasonic PRIME Gold 1200W Fully Modular 80+ Gold',
  3000,
  '{"manufacturer":"SeaSonic","wattage":1200,"powerRequirement":1200,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Seasonic PRIME Gold 1200W Fully Modular 80+ Gold')
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
  'Cougar CougarA500 ATX 500W Non-Modular 80+ Bronze Certified',
  3000,
  '{"manufacturer":"Cougar","wattage":500,"powerRequirement":500,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cougar CougarA500 ATX 500W Non-Modular 80+ Bronze Certified')
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
  'XFX PRO Black Edition 850W 80+ Gold Fully Modular',
  3000,
  '{"manufacturer":"XFX","wattage":850,"powerRequirement":850,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('XFX PRO Black Edition 850W 80+ Gold Fully Modular')
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
  'SeaSonic S12G ATX 750W Non-Modular 80+ Gold',
  3000,
  '{"manufacturer":"SeaSonic","wattage":750,"powerRequirement":750,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('SeaSonic S12G ATX 750W Non-Modular 80+ Gold')
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
  'GAMDIAS ASTRAPE M1 Black Multicolor ATX 650W Non-Modular 80+ Certified',
  3000,
  '{"manufacturer":"GAMDIAS","wattage":650,"powerRequirement":650,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('GAMDIAS ASTRAPE M1 Black Multicolor ATX 650W Non-Modular 80+ Certified')
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
  'Fractal Design Tesla R2 650W Non-Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"Fractal Design","wattage":650,"powerRequirement":650,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Fractal Design Tesla R2 650W Non-Modular 80+ Gold Certified')
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
  'Enermax Revolution D.F. 12 Black 850W Fully Modular 80+ Gold',
  3000,
  '{"manufacturer":"Enermax","wattage":850,"powerRequirement":850,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Enermax Revolution D.F. 12 Black 850W Fully Modular 80+ Gold')
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
  'FSP Group Hydro White 1200W 80+ Platinum Fully Modular',
  3000,
  '{"manufacturer":"FSP Group","wattage":1200,"powerRequirement":1200,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('FSP Group Hydro White 1200W 80+ Platinum Fully Modular')
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
  'be quiet! Dark Power 12 Black 750W Fully Modular 80+ Titanium Certified',
  3000,
  '{"manufacturer":"be quiet!","wattage":750,"powerRequirement":750,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('be quiet! Dark Power 12 Black 750W Fully Modular 80+ Titanium Certified')
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
  'Rosewill HERCULES-1600S ATX 1600W Semi-Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"Rosewill","wattage":1600,"powerRequirement":1600,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Rosewill HERCULES-1600S ATX 1600W Semi-Modular 80+ Gold Certified')
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
  'Thermalright TPFX850 White SFX 850W Fully Modular 80+ Platinum Certified',
  3000,
  '{"manufacturer":"Thermalright","wattage":850,"powerRequirement":850,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermalright TPFX850 White SFX 850W Fully Modular 80+ Platinum Certified')
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
  'be quiet! System Power 10 U Black ATX 650W Non-Modular 80+ Bronze Certified',
  3000,
  '{"manufacturer":"be quiet!","wattage":650,"powerRequirement":650,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('be quiet! System Power 10 U Black ATX 650W Non-Modular 80+ Bronze Certified')
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
  'LC-Power LC V2.31 Black TFX 400W Non-Modular',
  3000,
  '{"manufacturer":"LC-Power","wattage":400,"powerRequirement":400,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('LC-Power LC V2.31 Black TFX 400W Non-Modular')
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
  'Asus ROG Strix White 850W Fully Modular 80+ Gold',
  3000,
  '{"manufacturer":"Asus","wattage":850,"powerRequirement":850,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus ROG Strix White 850W Fully Modular 80+ Gold')
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
  'SeaSonic B12 BC 850W Non-Modular 80+ Bronze Certified',
  3000,
  '{"manufacturer":"SeaSonic","wattage":850,"powerRequirement":850,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('SeaSonic B12 BC 850W Non-Modular 80+ Bronze Certified')
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
  'Thermaltake Toughpower PF1 TT Premium Edition Black 850W Fully Modular 80+ Platinum',
  3000,
  '{"manufacturer":"Thermaltake","wattage":850,"powerRequirement":850,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermaltake Toughpower PF1 TT Premium Edition Black 850W Fully Modular 80+ Platinum')
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
  'FSP Group Hydro X 450W Non-Modular 80+ Gold',
  3000,
  '{"manufacturer":"FSP Group","wattage":450,"powerRequirement":450,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('FSP Group Hydro X 450W Non-Modular 80+ Gold')
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
  'Enermax ENP450AST ATX 450W Non-Modular',
  3000,
  '{"manufacturer":"Enermax","wattage":450,"powerRequirement":450,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Enermax ENP450AST ATX 450W Non-Modular')
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
  'Raidmax Cobra Black ATX 650W Fully Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"Raidmax","wattage":650,"powerRequirement":650,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Raidmax Cobra Black ATX 650W Fully Modular 80+ Gold Certified')
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
  'Cooler Master Extreme 2 525W Non-Modular',
  3000,
  '{"manufacturer":"Cooler Master","wattage":525,"powerRequirement":525,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cooler Master Extreme 2 525W Non-Modular')
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
  'Antec High Current Pro 750W 80+ Gold Certified Semi-Modular',
  3000,
  '{"manufacturer":"Antec","wattage":750,"powerRequirement":750,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Antec High Current Pro 750W 80+ Gold Certified Semi-Modular')
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
  'Raidmax Scorpio 735W 80+ Bronze Certified Semi-Modular',
  3000,
  '{"manufacturer":"Raidmax","wattage":735,"powerRequirement":735,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Raidmax Scorpio 735W 80+ Bronze Certified Semi-Modular')
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
  'Xilence XP550R9 Black / Red ATX 550W Non-Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"Xilence","wattage":550,"powerRequirement":550,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Xilence XP550R9 Black / Red ATX 550W Non-Modular 80+ Gold Certified')
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
  'Apevia ATX-JV650W 650W Non-Modular',
  3000,
  '{"manufacturer":"Apevia","wattage":650,"powerRequirement":650,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Apevia ATX-JV650W 650W Non-Modular')
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
  'OCZ ZS ATX 750W Non-Modular 80+ Bronze Certified',
  3000,
  '{"manufacturer":"OCZ","wattage":750,"powerRequirement":750,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('OCZ ZS ATX 750W Non-Modular 80+ Bronze Certified')
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
  'be quiet! Dark Power Pro 13 1600W Fully Modular 80+ Titanium Certified',
  3000,
  '{"manufacturer":"be quiet!","wattage":1600,"powerRequirement":1600,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('be quiet! Dark Power Pro 13 1600W Fully Modular 80+ Titanium Certified')
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
  'KOLINK Modular Power Black ATX 700W Semi-Modular 80+ Bronze Certified',
  3000,
  '{"manufacturer":"KOLINK","wattage":700,"powerRequirement":700,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('KOLINK Modular Power Black ATX 700W Semi-Modular 80+ Bronze Certified')
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
  'Corsair TX550M Gold 550W 80+ Gold Certified Semi-Modular',
  3000,
  '{"manufacturer":"Corsair","wattage":550,"powerRequirement":550,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair TX550M Gold 550W 80+ Gold Certified Semi-Modular')
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
  'In Win GreenMe 650 650W Non-Modular 80+ Bronze Certified ATX',
  3000,
  '{"manufacturer":"In Win","wattage":650,"powerRequirement":650,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('In Win GreenMe 650 650W Non-Modular 80+ Bronze Certified ATX')
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
  'Rosewill PHOTON-1200 1200W Fully Modular 80+ Gold Certified ATX',
  3000,
  '{"manufacturer":"Rosewill","wattage":1200,"powerRequirement":1200,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Rosewill PHOTON-1200 1200W Fully Modular 80+ Gold Certified ATX')
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
  'FSP Group Raider S 450W Non-Modular 80+ Silver Certified ATX',
  3000,
  '{"manufacturer":"FSP Group","wattage":450,"powerRequirement":450,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('FSP Group Raider S 450W Non-Modular 80+ Silver Certified ATX')
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
  'Rosewill G550 ATX 550W Semi-Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"Rosewill","wattage":550,"powerRequirement":550,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Rosewill G550 ATX 550W Semi-Modular 80+ Gold Certified')
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
  'be quiet! Dark Power Pro 10 850W Semi-Modular 80+ Platinum Certified',
  3000,
  '{"manufacturer":"be quiet!","wattage":850,"powerRequirement":850,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('be quiet! Dark Power Pro 10 850W Semi-Modular 80+ Platinum Certified')
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
  'Cooler Master VSM ATX 650W Semi-Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"Cooler Master","wattage":650,"powerRequirement":650,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cooler Master VSM ATX 650W Semi-Modular 80+ Gold Certified')
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
  'Cooler Master VSM ATX 750W Semi-Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"Cooler Master","wattage":750,"powerRequirement":750,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cooler Master VSM ATX 750W Semi-Modular 80+ Gold Certified')
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
  'Silverstone Essential Black / Blue 750W Semi-Modular 80+ Gold Certified ATX',
  3000,
  '{"manufacturer":"Silverstone","wattage":750,"powerRequirement":750,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silverstone Essential Black / Blue 750W Semi-Modular 80+ Gold Certified ATX')
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
  'G.Skill PS850P Black 850W Fully Modular 80+ Platinum Certified',
  3000,
  '{"manufacturer":"G.Skill","wattage":850,"powerRequirement":850,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('G.Skill PS850P Black 850W Fully Modular 80+ Platinum Certified')
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
  'Silverstone Essential Black 750W Non-Modular 80+ Bronze',
  3000,
  '{"manufacturer":"Silverstone","wattage":750,"powerRequirement":750,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silverstone Essential Black 750W Non-Modular 80+ Bronze')
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
  'In Win Commander III 700W Semi-Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"In Win","wattage":700,"powerRequirement":700,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('In Win Commander III 700W Semi-Modular 80+ Gold Certified')
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
  'Xigmatek NRP-MC1002 1000W 80+ Bronze Certified Fully Modular ATX',
  3000,
  '{"manufacturer":"Xigmatek","wattage":1000,"powerRequirement":1000,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Xigmatek NRP-MC1002 1000W 80+ Bronze Certified Fully Modular ATX')
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
  'MSI MAG A850GL PCIE5 White 850W Fully Modular 80+ Gold ATX',
  3000,
  '{"manufacturer":"MSI","wattage":850,"powerRequirement":850,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI MAG A850GL PCIE5 White 850W Fully Modular 80+ Gold ATX')
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
  'ADATA XPG CYBERCORE II Black 1300W Fully Modular 80+ Platinum',
  3000,
  '{"manufacturer":"ADATA","wattage":1300,"powerRequirement":1300,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ADATA XPG CYBERCORE II Black 1300W Fully Modular 80+ Platinum')
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
  'Corsair RM1200x SHIFT Side Interface 1200W Fully Modular 80+ Gold',
  3000,
  '{"manufacturer":"Corsair","wattage":1200,"powerRequirement":1200,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair RM1200x SHIFT Side Interface 1200W Fully Modular 80+ Gold')
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
  'Silverstone DA850R-GMA White 850W Fully Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"Silverstone","wattage":850,"powerRequirement":850,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silverstone DA850R-GMA White 850W Fully Modular 80+ Gold Certified')
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
  'Xilence XP530R8 Black / Red ATX 530W Non-Modular 80+ Bronze Certified',
  3000,
  '{"manufacturer":"Xilence","wattage":530,"powerRequirement":530,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Xilence XP530R8 Black / Red ATX 530W Non-Modular 80+ Bronze Certified')
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
  'EVGA SuperNOVA 1300 GT 1300W Fully Modular 80+ Gold',
  3000,
  '{"manufacturer":"EVGA","wattage":1300,"powerRequirement":1300,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('EVGA SuperNOVA 1300 GT 1300W Fully Modular 80+ Gold')
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
  'Enermax REVOLUTION DUO 700W Non-Modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"Enermax","wattage":700,"powerRequirement":700,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Enermax REVOLUTION DUO 700W Non-Modular 80+ Gold Certified')
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
  'Thermaltake Litepower 650W Non-Modular',
  3000,
  '{"manufacturer":"Thermaltake","wattage":650,"powerRequirement":650,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermaltake Litepower 650W Non-Modular')
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
  'RMx Series™ RM650x — 650 Watt 80 PLUS Gold Fully Modular ATX PSU',
  3000,
  '{"manufacturer":"Corsair","wattage":650,"powerRequirement":650,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('RMx Series™ RM650x — 650 Watt 80 PLUS Gold Fully Modular ATX PSU')
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
  'Thermaltake EVO_Blue ATX 650W Semi-modular 80+ Gold Certified',
  3000,
  '{"manufacturer":"Thermaltake","wattage":650,"powerRequirement":650,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermaltake EVO_Blue ATX 650W Semi-modular 80+ Gold Certified')
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
  '1STPLAYER NGDP ATX 3.0 1000W Fully Modular 80+ Platinum Certified',
  3000,
  '{"manufacturer":"1STPLAYER","wattage":1000,"powerRequirement":1000,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('1STPLAYER NGDP ATX 3.0 1000W Fully Modular 80+ Platinum Certified')
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
  'NOX Hummer 650W Semi-Modular 80+ Bronze Certified',
  3000,
  '{"manufacturer":"NOX","wattage":650,"powerRequirement":650,"efficiency":null,"efficiencyRating":null,"modular":"Semi-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('NOX Hummer 650W Semi-Modular 80+ Bronze Certified')
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
  'CoolMax CUQ-1350B ATX 1350W Non-Modular 80+ Certified',
  3000,
  '{"manufacturer":"CoolMax","wattage":1350,"powerRequirement":1350,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('CoolMax CUQ-1350B ATX 1350W Non-Modular 80+ Certified')
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
  'Antec True Power 550W 80+ Bronze Certified Fully Modular',
  3000,
  '{"manufacturer":"Antec","wattage":550,"powerRequirement":550,"efficiency":null,"efficiencyRating":null,"modular":"Full","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Antec True Power 550W 80+ Bronze Certified Fully Modular')
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
  'SeaSonic SSP-300TBS TFX 300W Non-Modular 80+ Bronze Certified',
  3000,
  '{"manufacturer":"SeaSonic","wattage":300,"powerRequirement":300,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('SeaSonic SSP-300TBS TFX 300W Non-Modular 80+ Bronze Certified')
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
  'LEPA MX-F1 ATX 400W Non-Modular',
  3000,
  '{"manufacturer":"LEPA","wattage":400,"powerRequirement":400,"efficiency":null,"efficiencyRating":null,"modular":"Non-Modular","modularType":"Fully Modular"}'::jsonb,
  6,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('LEPA MX-F1 ATX 400W Non-Modular')
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
  'Rosewill BLACKHAWK-ULTRA ATX Full Tower Black with USB 3.2 Gen 1 Type-A and USB 2.0 Type-A',
  2500,
  '{"manufacturer":"Rosewill","formFactor":"ATX Full Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Rosewill BLACKHAWK-ULTRA ATX Full Tower Black with USB 3.2 Gen 1 Type-A and USB 2.0 Type-A')
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
  'Lian Li O11 Dynamic EVO ATX Mid Tower Gray / Black Tinted Tempered Glass Side Panel, USB 3.2 Gen 2 Type-C USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"Lian Li","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Lian Li O11 Dynamic EVO ATX Mid Tower Gray / Black Tinted Tempered Glass Side Panel, USB 3.2 Gen 2 Type-C USB 3.2 Gen 1 Type-A')
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
  'In Win D-Frame 2.0 ATX Full Tower White / Blue Tempered Glass Side Panel w/1065 W Power Supply',
  2500,
  '{"manufacturer":"InWin","formFactor":"ATX Full Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('In Win D-Frame 2.0 ATX Full Tower White / Blue Tempered Glass Side Panel w/1065 W Power Supply')
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
  'GameMax White Diamond ARGB ATX Mid Tower White / Black with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A, USB 2.0 Type-A',
  2500,
  '{"manufacturer":"GAMEMAX","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('GameMax White Diamond ARGB ATX Mid Tower White / Black with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A, USB 2.0 Type-A')
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
  'Corsair Carbide Series SPEC-06 ATX Mid Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A Front Panel',
  2500,
  '{"manufacturer":"Corsair","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Carbide Series SPEC-06 ATX Mid Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A Front Panel')
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
  'DIYPC ARGB-Q8-BK Micro ATX Mid Tower Black Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"DIYPC","formFactor":"Micro ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('DIYPC ARGB-Q8-BK Micro ATX Mid Tower Black Tempered Glass Side Panel')
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
  'Azza Spectra ATX Mid Tower White with Tempered Glass Side Panel and Front Panel USB 3.2 Gen 1 Type-A, USB 2.0 Type-A',
  2500,
  '{"manufacturer":"AZZA","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Azza Spectra ATX Mid Tower White with Tempered Glass Side Panel and Front Panel USB 3.2 Gen 1 Type-A, USB 2.0 Type-A')
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
  'Apevia X-FIT-100 Mini-ITX Tower Case Black with 250 W Power Supply',
  2500,
  '{"manufacturer":"Apevia","formFactor":"Mini-ITX Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Apevia X-FIT-100 Mini-ITX Tower Case Black with 250 W Power Supply')
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
  'APNX V1 ATX Mid Tower White / Brown Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"APNX","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('APNX V1 ATX Mid Tower White / Brown Tempered Glass Side Panel')
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
  'Montech AIR 903 MAX ATX Mid Tower Black Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"MONTECH","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Montech AIR 903 MAX ATX Mid Tower Black Tempered Glass Side Panel')
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
  'Cooler Master MasterCase Maker 5 ATX Mid Tower Black with Acrylic Side Panel and Front Panel: USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A, USB 2.0 T...',
  2500,
  '{"manufacturer":"Cooler Master","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cooler Master MasterCase Maker 5 ATX Mid Tower Black with Acrylic Side Panel and Front Panel: USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A, USB 2.0 T...')
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
  'RAIJINTEK PAN Slim Mini-ITX Desktop',
  2500,
  '{"manufacturer":"RAIJINTEK","formFactor":"Mini-ITX Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('RAIJINTEK PAN Slim Mini-ITX Desktop')
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
  'be quiet! Pure Base 600 ATX Mid Tower Black / Orange Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"be quiet!","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('be quiet! Pure Base 600 ATX Mid Tower Black / Orange Tempered Glass Side Panel')
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
  'Zalman Z10 DUO ATX Mid Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 2 Type-C / USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"Zalman","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Zalman Z10 DUO ATX Mid Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 2 Type-C / USB 3.2 Gen 1 Type-A')
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
  'Fractal Design Epoch RGB ATX Mid Tower White Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"Fractal Design","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Fractal Design Epoch RGB ATX Mid Tower White Tempered Glass Side Panel')
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
  'Fractal Design Meshify 2 Compact TG Dark Tint ATX Mid Tower Black Tinted Tempered Glass',
  2500,
  '{"manufacturer":"Fractal Design","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Fractal Design Meshify 2 Compact TG Dark Tint ATX Mid Tower Black Tinted Tempered Glass')
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
  'CiT Master ATX Mid Tower Black Tempered Glass Side Panel, USB 3.2 Gen 1 & USB 2.0 Front USB',
  2500,
  '{"manufacturer":"CiT","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('CiT Master ATX Mid Tower Black Tempered Glass Side Panel, USB 3.2 Gen 1 & USB 2.0 Front USB')
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
  'Corsair Obsidian Series 350D Micro ATX Mid Tower Black Window',
  2500,
  '{"manufacturer":"Corsair","formFactor":"Micro ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Obsidian Series 350D Micro ATX Mid Tower Black Window')
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
  'Fractal Design Meshify 2 Compact ATX Mid Tower White TG Clear Tint Tempered Glass',
  2500,
  '{"manufacturer":"Fractal Design","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Fractal Design Meshify 2 Compact ATX Mid Tower White TG Clear Tint Tempered Glass')
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
  'HAVN BF 360 Flow White',
  2500,
  '{"manufacturer":"HAVN","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('HAVN BF 360 Flow White')
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
  'Corsair Obsidian Series 450D ATX Mid Tower Black Acrylic Side Panel',
  2500,
  '{"manufacturer":"Corsair","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Obsidian Series 450D ATX Mid Tower Black Acrylic Side Panel')
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
  'Rosewill FBM-X1 Micro ATX Mini Tower Black with Acrylic Side Panel and USB 3.2 Gen 1 Type-A, USB 2.0 Type-A Front Panel',
  2500,
  '{"manufacturer":"Rosewill","formFactor":"Micro ATX Mini Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Rosewill FBM-X1 Micro ATX Mini Tower Black with Acrylic Side Panel and USB 3.2 Gen 1 Type-A, USB 2.0 Type-A Front Panel')
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
  'Jonsbo BO 100 Mini-ITX Desktop Silver with Tempered Glass Side Panel and USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"Jonsbo","formFactor":"Mini-ITX Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Jonsbo BO 100 Mini-ITX Desktop Silver with Tempered Glass Side Panel and USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A')
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
  'FSP Group CUT593P ATX Full Tower White with Tempered Glass Side Panel, USB 3.2 Gen 2 Type-C USB 3.2 Gen 1 Type-A, and Dimensions 500 x 230 x 544',
  2500,
  '{"manufacturer":"FSP Group","formFactor":"ATX Full Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('FSP Group CUT593P ATX Full Tower White with Tempered Glass Side Panel, USB 3.2 Gen 2 Type-C USB 3.2 Gen 1 Type-A, and Dimensions 500 x 230 x 544')
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
  'LIAN LI O11 Dynamic EVO O11DEX Black Aluminum / Steel / Tempered Glass ATX Mid Tower Computer Case',
  2500,
  '{"manufacturer":"Lian Li","formFactor":"ATX Full Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('LIAN LI O11 Dynamic EVO O11DEX Black Aluminum / Steel / Tempered Glass ATX Mid Tower Computer Case')
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
  'Cougar Purity MicroATX Mini Tower Black',
  2500,
  '{"manufacturer":"Cougar","formFactor":"Micro ATX Mini Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cougar Purity MicroATX Mini Tower Black')
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
  'NZXT H700 ATX Mid Tower White Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"NZXT","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('NZXT H700 ATX Mid Tower White Tempered Glass Side Panel')
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
  'GameMax Master M905 ATX Full Tower Black Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"GAMEMAX","formFactor":"ATX Full Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('GameMax Master M905 ATX Full Tower Black Tempered Glass Side Panel')
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
  'NZXT H7 Flow (2024) ATX Mid Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 2x2 Type-C USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"NZXT","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('NZXT H7 Flow (2024) ATX Mid Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 2x2 Type-C USB 3.2 Gen 1 Type-A')
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
  'Corsair Vengeance C70 ATX Mid Tower Green Acrylic Side Panel',
  2500,
  '{"manufacturer":"Corsair","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Vengeance C70 ATX Mid Tower Green Acrylic Side Panel')
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
  'Lian Li O11 Dynamic Mini ATX Mid Tower Snow Edition Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"Lian Li","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Lian Li O11 Dynamic Mini ATX Mid Tower Snow Edition Tempered Glass Side Panel')
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
  'Phanteks Enthoo EVOLV ITX TG Mini-ITX Desktop Black / Red Tinted Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"Phanteks","formFactor":"Mini-ITX Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Phanteks Enthoo EVOLV ITX TG Mini-ITX Desktop Black / Red Tinted Tempered Glass Side Panel')
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
  'Thermaltake Versa N26 ATX Mid Tower Black Acrylic Side Panel',
  2500,
  '{"manufacturer":"Thermaltake","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermaltake Versa N26 ATX Mid Tower Black Acrylic Side Panel')
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
  'SHARKOON Elite Shark CA200G ATX Mid Tower Black Tempered Glass USB 3.2 Gen 1 Type-A USB 2.0 Type-A',
  2500,
  '{"manufacturer":"SHARKOON","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('SHARKOON Elite Shark CA200G ATX Mid Tower Black Tempered Glass USB 3.2 Gen 1 Type-A USB 2.0 Type-A')
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
  'Cooler Master MasterBox TD500 Mesh ATX Mid Tower White w/o Controller',
  2500,
  '{"manufacturer":"Cooler Master","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cooler Master MasterBox TD500 Mesh ATX Mid Tower White w/o Controller')
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
  'Deepcool CK560 ATX Mid Tower White/Black Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"DeepCool","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool CK560 ATX Mid Tower White/Black Tempered Glass Side Panel')
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
  'Lian Li Q58 Mini-ITX Desktop Black Tempered Glass Side Panel, PCIe 4.0',
  2500,
  '{"manufacturer":"Lian Li","formFactor":"Mini-ITX Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Lian Li Q58 Mini-ITX Desktop Black Tempered Glass Side Panel, PCIe 4.0')
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
  'Jonsbo D40 ATX Mid Tower Black Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"Jonsbo","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Jonsbo D40 ATX Mid Tower Black Tempered Glass Side Panel')
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
  'NZXT H710i ATX Mid Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"NZXT","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('NZXT H710i ATX Mid Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A')
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
  'NZXT H7 Flow 2024 - Mid-Tower ATX Airflow Case - Includes Pre-Installed 3 x 120mm Fans - CM-H72FB-01 - Supports Bottom Fans for Dedicated GPU Cooli...',
  2500,
  '{"manufacturer":"NZXT","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('NZXT H7 Flow 2024 - Mid-Tower ATX Airflow Case - Includes Pre-Installed 3 x 120mm Fans - CM-H72FB-01 - Supports Bottom Fans for Dedicated GPU Cooli...')
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
  'Corsair Carbide Series 678C ATX Mid Tower White / Black with Tempered Glass Side Panel and USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"Corsair","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair Carbide Series 678C ATX Mid Tower White / Black with Tempered Glass Side Panel and USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A')
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
  'NZXT H500 ATX Mid Tower White with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"NZXT","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('NZXT H500 ATX Mid Tower White with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A')
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
  'Cougar MX340 ATX Mid Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A USB 2.0 Type-A Front Panel',
  2500,
  '{"manufacturer":"Cougar","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cougar MX340 ATX Mid Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A USB 2.0 Type-A Front Panel')
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
  'SAMA IM01 Pro Micro ATX Mini Tower Black Tempered Glass, Front USB: USB 3.2 Gen2 Type-C & USB 3.2 Gen1 Type-A',
  2500,
  '{"manufacturer":"SAMA","formFactor":"Micro ATX Mini Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('SAMA IM01 Pro Micro ATX Mini Tower Black Tempered Glass, Front USB: USB 3.2 Gen2 Type-C & USB 3.2 Gen1 Type-A')
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
  'Fractal Design Define S2 Vision RGB ATX Mid Tower Black with Tinted Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"Fractal Design","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Fractal Design Define S2 Vision RGB ATX Mid Tower Black with Tinted Tempered Glass Side Panel')
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
  'Apevia Guardian-M ATX Mid Tower Black Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"Apevia","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Apevia Guardian-M ATX Mid Tower Black Tempered Glass Side Panel')
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
  'MUSETEX Y4 ATX Mid Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 2 Type-C USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"MUSETEX","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MUSETEX Y4 ATX Mid Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 2 Type-C USB 3.2 Gen 1 Type-A')
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
  'MSI MPG GUNGNIR 300R AIRFLOW ATX Mid Tower White with Tempered Glass Side Panel and USB 3.2 Gen 2x2 Type-C / USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"MSI","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI MPG GUNGNIR 300R AIRFLOW ATX Mid Tower White with Tempered Glass Side Panel and USB 3.2 Gen 2x2 Type-C / USB 3.2 Gen 1 Type-A')
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
  'Phanteks NV5 ATX Mid Tower Black Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"Phanteks","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Phanteks NV5 ATX Mid Tower Black Tempered Glass Side Panel')
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
  'Fractal Design Define C ATX Mid Tower Black Tempered Glass',
  2500,
  '{"manufacturer":"Fractal Design","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Fractal Design Define C ATX Mid Tower Black Tempered Glass')
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
  'Maingear Vybe Mk. V ATX Mid Tower Red / Black Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"Maingear","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Maingear Vybe Mk. V ATX Mid Tower Red / Black Tempered Glass Side Panel')
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
  'be quiet! Pure Base 501 DX ATX Mid Tower White Tempered Glass',
  2500,
  '{"manufacturer":"be quiet!","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('be quiet! Pure Base 501 DX ATX Mid Tower White Tempered Glass')
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
  'Jonsbo N10 Mini-ITX Tower Silver with Mesh Side Panel and USB 3.2 Gen 2 Type-C Front Panel',
  2500,
  '{"manufacturer":"Jonsbo","formFactor":"Mini-ITX Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Jonsbo N10 Mini-ITX Tower Silver with Mesh Side Panel and USB 3.2 Gen 2 Type-C Front Panel')
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
  'Fractal Design Arc XL ATX Full Tower Black with Acrylic Side Panel and USB 3.2 Gen 1 Type-A, USB 2.0 Type-A',
  2500,
  '{"manufacturer":"Fractal Design","formFactor":"ATX Full Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Fractal Design Arc XL ATX Full Tower Black with Acrylic Side Panel and USB 3.2 Gen 1 Type-A, USB 2.0 Type-A')
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
  'Thermaltake Versa H17 Micro ATX Mini Tower Black',
  2500,
  '{"manufacturer":"Thermaltake","formFactor":"Micro ATX Mini Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermaltake Versa H17 Micro ATX Mini Tower Black')
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
  'Fractal Design Era ITX Mini Tower Case (Carbon with Tempered Glass)',
  2500,
  '{"manufacturer":"Fractal Design","formFactor":"Mini-ITX Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Fractal Design Era ITX Mini Tower Case (Carbon with Tempered Glass)')
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
  'Thermaltake Ceres 300 ATX Mid Tower Green Tempered Glass ARGB',
  2500,
  '{"manufacturer":"Thermaltake","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermaltake Ceres 300 ATX Mid Tower Green Tempered Glass ARGB')
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
  'KOLINK Unity Cascade ARGB ATX Mid Tower Black Tempered Glass USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"KOLINK","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('KOLINK Unity Cascade ARGB ATX Mid Tower Black Tempered Glass USB 3.2 Gen 1 Type-A')
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
  'In Win Explorer Mini-ITX Desktop White Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"InWin","formFactor":"Mini-ITX Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('In Win Explorer Mini-ITX Desktop White Tempered Glass Side Panel')
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
  'DIYPC DIY-mATX06-Wood Micro ATX Mini Tower Black / Brown with Tempered Glass Side Panel and USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"DIYPC","formFactor":"Micro ATX Mini Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('DIYPC DIY-mATX06-Wood Micro ATX Mini Tower Black / Brown with Tempered Glass Side Panel and USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A')
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
  'HYTE Y40 ATX Mid Tower White / Black with Tempered Glass Side Panel and USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"HYTE","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('HYTE Y40 ATX Mid Tower White / Black with Tempered Glass Side Panel and USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A')
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
  'GameMax Vista M Micro ATX Mini Tower White Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"GAMEMAX","formFactor":"Micro ATX Mini Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('GameMax Vista M Micro ATX Mini Tower White Tempered Glass Side Panel')
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
  'JONSBO D30 BLACK Mini Micro ATX Computer Case, Aluminum/Steel/Tempered Glass-1 Side, Simple High Compatibility MATX Case, Support 240 Water & 168mm...',
  2500,
  '{"manufacturer":"Jonsbo","formFactor":"Micro ATX Mini Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('JONSBO D30 BLACK Mini Micro ATX Computer Case, Aluminum/Steel/Tempered Glass-1 Side, Simple High Compatibility MATX Case, Support 240 Water & 168mm...')
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
  'Thermaltake Versa N21 ATX Mid Tower Black Acrylic Side Panel, USB 3.2 Gen 1 Type-A, USB 2.0 Type-A',
  2500,
  '{"manufacturer":"Thermaltake","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermaltake Versa N21 ATX Mid Tower Black Acrylic Side Panel, USB 3.2 Gen 1 Type-A, USB 2.0 Type-A')
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
  'Thermaltake View 21 ATX Mid Tower Black Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"Thermaltake","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermaltake View 21 ATX Mid Tower Black Tempered Glass Side Panel')
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
  'Thermaltake Commander C34 ATX Mid Tower White / Black Tempered Glass Side Panel ARGB',
  2500,
  '{"manufacturer":"Thermaltake","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermaltake Commander C34 ATX Mid Tower White / Black Tempered Glass Side Panel ARGB')
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
  'HYTE Y70 Silver Wolf ATX Mid Tower Black / Purple with Tempered Glass Side Panel and USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"HYTE","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('HYTE Y70 Silver Wolf ATX Mid Tower Black / Purple with Tempered Glass Side Panel and USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A')
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
  'HAVN BF360 Flow Black',
  2500,
  '{"manufacturer":"HAVN","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('HAVN BF360 Flow Black')
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
  'Raidmax Viper GX ATX Mid Tower Black / Green USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"Raidmax","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Raidmax Viper GX ATX Mid Tower Black / Green USB 3.2 Gen 1 Type-A')
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
  'In Win Chopin MAX Mini-ITX Desktop Gray with Mesh Side Panel, USB 3.2 Gen 2x2 Type-C, USB 3.2 Gen 1 Type-A, and 200 W Power Supply',
  2500,
  '{"manufacturer":"InWin","formFactor":"Mini-ITX Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('In Win Chopin MAX Mini-ITX Desktop Gray with Mesh Side Panel, USB 3.2 Gen 2x2 Type-C, USB 3.2 Gen 1 Type-A, and 200 W Power Supply')
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
  'Deepcool D-Shield V2 ATX Mid Tower Black Acrylic Side Panel',
  2500,
  '{"manufacturer":"DeepCool","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool D-Shield V2 ATX Mid Tower Black Acrylic Side Panel')
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
  'Lian Li O11 Dynamic Mini V2 ATX Mini Tower White Tempered Glass, USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"Lian Li","formFactor":"ATX Mini Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Lian Li O11 Dynamic Mini V2 ATX Mini Tower White Tempered Glass, USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A')
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
  'MSI MAG FORGE 112R ATX Mid Tower Black Tempered Glass Side Panel, USB 3.2 Gen 1 Type-A Front Panel',
  2500,
  '{"manufacturer":"MSI","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI MAG FORGE 112R ATX Mid Tower Black Tempered Glass Side Panel, USB 3.2 Gen 1 Type-A Front Panel')
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
  'Fractal Design Meshify 2 RGB ATX Mid Tower Black Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"Fractal Design","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Fractal Design Meshify 2 RGB ATX Mid Tower Black Tempered Glass Side Panel')
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
  'Deepcool MACUBE 110 Micro ATX Mini Tower Black Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"DeepCool","formFactor":"Micro ATX Mini Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool MACUBE 110 Micro ATX Mini Tower Black Tempered Glass Side Panel')
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
  'In Win A5 ATX Mid Tower Black Tempered Glass Side Panel, USB 3.2 Gen 2x2 Type-C, USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"InWin","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('In Win A5 ATX Mid Tower Black Tempered Glass Side Panel, USB 3.2 Gen 2x2 Type-C, USB 3.2 Gen 1 Type-A')
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
  'Mars Gaming MCZ MicroATX Mid Tower Black Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"Mars Gaming","formFactor":"Micro ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Mars Gaming MCZ MicroATX Mid Tower Black Tempered Glass Side Panel')
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
  'Deepcool Dukase ATX Mid Tower Black Acrylic Side Panel',
  2500,
  '{"manufacturer":"DeepCool","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool Dukase ATX Mid Tower Black Acrylic Side Panel')
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
  'Asus Prime AP201 Micro ATX Mini Tower White Mesh Side Panel',
  2500,
  '{"manufacturer":"ASUS","formFactor":"Micro ATX Mini Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus Prime AP201 Micro ATX Mini Tower White Mesh Side Panel')
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
  'Silverstone PS13 ATX Mid Tower Black',
  2500,
  '{"manufacturer":"Silverstone","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silverstone PS13 ATX Mid Tower Black')
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
  'NOX Hummer ASTRA ATX Mid Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-C and USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"NOX","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('NOX Hummer ASTRA ATX Mid Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-C and USB 3.2 Gen 1 Type-A')
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
  'HYTE Y70 ATX Mid Tower Taro Milk Purple Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"HYTE","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('HYTE Y70 ATX Mid Tower Taro Milk Purple Tempered Glass Side Panel')
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
  'Asus TUF Gaming GT502 ATX Mid Tower White Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"ASUS","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus TUF Gaming GT502 ATX Mid Tower White Tempered Glass Side Panel')
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
  'SSUPD Meshlicious Mini-ITX Tower White with Mesh Side Panel and USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"SSUPD","formFactor":"Mini-ITX Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('SSUPD Meshlicious Mini-ITX Tower White with Mesh Side Panel and USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A')
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
  'Geometric Future Model 5 Fanless ATX Mid Tower White Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"Geometric Future","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Geometric Future Model 5 Fanless ATX Mid Tower White Tempered Glass Side Panel')
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
  'Lian Li PC-TU200 Mini-ITX Tower Black',
  2500,
  '{"manufacturer":"Lian Li","formFactor":"Mini-ITX Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Lian Li PC-TU200 Mini-ITX Tower Black')
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
  'Aerocool Tor Pro ATX Full Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A, USB 2.0 Type-A',
  2500,
  '{"manufacturer":"AeroCool","formFactor":"ATX Full Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Aerocool Tor Pro ATX Full Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A, USB 2.0 Type-A')
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
  'Lian Li LANCOOL III ATX Mid Tower Black RGB Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"Lian Li","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Lian Li LANCOOL III ATX Mid Tower Black RGB Tempered Glass Side Panel')
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
  'Fractal Design Define R4 ATX Mid Tower White Acrylic Side Panel',
  2500,
  '{"manufacturer":"Fractal Design","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Fractal Design Define R4 ATX Mid Tower White Acrylic Side Panel')
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
  'NZXT H510 Elite ATX Mid Tower Black with Tempered Glass Side Panel and Front I/O: USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"NZXT","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('NZXT H510 Elite ATX Mid Tower Black with Tempered Glass Side Panel and Front I/O: USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A')
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
  'Deepcool CH510 ATX Mid Tower Black Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"DeepCool","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool CH510 ATX Mid Tower Black Tempered Glass Side Panel')
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
  'Jonsbo D300 Micro ATX Mid Tower Black 4PCS Tempered Glass Side Panel',
  2500,
  '{"manufacturer":"Jonsbo","formFactor":"Micro ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Jonsbo D300 Micro ATX Mid Tower Black 4PCS Tempered Glass Side Panel')
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
  'In Win BK623.BH300TB3 Micro ATX Mini Tower Case Black / Silver w/300 W Power Supply',
  2500,
  '{"manufacturer":"InWin","formFactor":"Micro ATX Mini Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('In Win BK623.BH300TB3 Micro ATX Mini Tower Case Black / Silver w/300 W Power Supply')
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
  'Deepcool Matrexx 55 V3 ATX Mid Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A, USB 2.0 Type-A Front Panel',
  2500,
  '{"manufacturer":"DeepCool","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool Matrexx 55 V3 ATX Mid Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A, USB 2.0 Type-A Front Panel')
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
  'Deepcool MATREXX 40 3FS Micro ATX Mini Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A USB 2.0 Type-A',
  2500,
  '{"manufacturer":"DeepCool","formFactor":"Micro ATX Mini Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool MATREXX 40 3FS Micro ATX Mini Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A USB 2.0 Type-A')
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
  'Jonsbo TK-3 ATX Mid Tower White with Tempered Glass Side Panel and USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"Jonsbo","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Jonsbo TK-3 ATX Mid Tower White with Tempered Glass Side Panel and USB 3.2 Gen 2 Type-C, USB 3.2 Gen 1 Type-A')
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
  'NZXT Phantom 410 ATX Mid Tower Black Acrylic Side Panel',
  2500,
  '{"manufacturer":"NZXT","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('NZXT Phantom 410 ATX Mid Tower Black Acrylic Side Panel')
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
  'CiT Mirage F6 ATX Mid Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A / USB 2.0 Type-A',
  2500,
  '{"manufacturer":"CiT","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('CiT Mirage F6 ATX Mid Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A / USB 2.0 Type-A')
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
  'Aerocool P500C ATX Mid Tower White with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A, USB 2.0 Type-A',
  2500,
  '{"manufacturer":"AeroCool","formFactor":"ATX Mid Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Aerocool P500C ATX Mid Tower White with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-A, USB 2.0 Type-A')
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
  'Cooler Master Elite 301 Lite Micro ATX Mini Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-C and USB 3.2 Gen 1 Type-A',
  2500,
  '{"manufacturer":"Cooler Master","formFactor":"Micro ATX Mini Tower","maxGpuLength":null,"max_gpu_length":null,"maxCoolerHeight":null,"max_cooler_height":null,"motherboardSupport":["ATX","Micro-ATX","Mini-ITX"]}'::jsonb,
  7,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cooler Master Elite 301 Lite Micro ATX Mini Tower Black with Tempered Glass Side Panel and USB 3.2 Gen 1 Type-C and USB 3.2 Gen 1 Type-A')
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

INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  'NZXT Kraken Water 240mm RGB White',
  1500,
  '{"manufacturer":"NZXT","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":56,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('NZXT Kraken Water 240mm RGB White')
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
  'GAMDIAS CHIONE M2 Water 240mm Black',
  1500,
  '{"manufacturer":"GAMDIAS","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('GAMDIAS CHIONE M2 Water 240mm Black')
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
  'Thermalright Le Grand Macho Air 159mm Fanless',
  1500,
  '{"manufacturer":"Thermalright","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":159,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermalright Le Grand Macho Air 159mm Fanless')
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
  'GameMax Twin 600 88.2 CFM Air 155mm Black',
  1500,
  '{"manufacturer":"GameMax","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":155,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('GameMax Twin 600 88.2 CFM Air 155mm Black')
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
  'Corsair iCUE LINK TITAN 240 RX Water 240mm RGB 73.5 CFM White',
  1500,
  '{"manufacturer":"Corsair","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair iCUE LINK TITAN 240 RX Water 240mm RGB 73.5 CFM White')
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
  'Silverstone NovaPeak 360 Water 360mm 69.8 CFM Black',
  1500,
  '{"manufacturer":"Silverstone","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":54,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silverstone NovaPeak 360 Water 360mm 69.8 CFM Black')
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
  'Thermalright Burst Assassin Air 154mm Gray / Black',
  1500,
  '{"manufacturer":"Thermalright","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":154,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermalright Burst Assassin Air 154mm Gray / Black')
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
  'ID-COOLING FROSTFLOW X LITE Water 240mm White',
  1500,
  '{"manufacturer":"ID-COOLING","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ID-COOLING FROSTFLOW X LITE Water 240mm White')
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
  'ID-COOLING IS-55 Air ARGB 55mm Black',
  1500,
  '{"manufacturer":"ID-COOLING","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":55,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ID-COOLING IS-55 Air ARGB 55mm Black')
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
  'Corsair iCUE LINK H100i Water 240mm RGB Black',
  1500,
  '{"manufacturer":"Corsair","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Corsair iCUE LINK H100i Water 240mm RGB Black')
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
  'Cooler Master X Dream I117 Air 60mm 36.5 CFM',
  1500,
  '{"manufacturer":"Cooler Master","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":60,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cooler Master X Dream I117 Air 60mm 36.5 CFM')
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
  'iTek Hydro Cube 65.54 CFM Water 240mm White',
  1500,
  '{"manufacturer":"iTek","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":72,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('iTek Hydro Cube 65.54 CFM Water 240mm White')
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
  'ARCTIC Liquid Freezer III Water 280 A-RGB 69.9 CFM White',
  1500,
  '{"manufacturer":"ARCTIC","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ARCTIC Liquid Freezer III Water 280 A-RGB 69.9 CFM White')
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
  'Asus ROG STRIX LC II 80.95 CFM Water 360mm Black',
  1500,
  '{"manufacturer":"Asus","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus ROG STRIX LC II 80.95 CFM Water 360mm Black')
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
  'Iceberg Thermal IceSLEET G6 Stealth 85 CFM Air 160mm Black / Blue',
  1500,
  '{"manufacturer":"Iceberg Thermal","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":160,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Iceberg Thermal IceSLEET G6 Stealth 85 CFM Air 160mm Black / Blue')
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
  'Iceberg Thermal IceSLEET X6 76 CFM Air 159mm Teal / Silver',
  1500,
  '{"manufacturer":"Iceberg Thermal","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":159,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Iceberg Thermal IceSLEET X6 76 CFM Air 159mm Teal / Silver')
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
  'Valkyrie SYN 80 CFM Water 240mm White / Blue',
  1500,
  '{"manufacturer":"Valkyrie","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Valkyrie SYN 80 CFM Water 240mm White / Blue')
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
  'upHere AC12BE Air 154mm Black',
  1500,
  '{"manufacturer":"upHere","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":154,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('upHere AC12BE Air 154mm Black')
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
  'Asus ROG Ryujin 240 RGB AIO Water 240mm 121.8 CFM Black',
  1500,
  '{"manufacturer":"Asus","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus ROG Ryujin 240 RGB AIO Water 240mm 121.8 CFM Black')
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
  'EVGA CLCx Water 280mm 85.13 CFM Black',
  1500,
  '{"manufacturer":"EVGA","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('EVGA CLCx Water 280mm 85.13 CFM Black')
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
  'FSP Group MP7 76 CFM Air 153mm Black',
  1500,
  '{"manufacturer":"FSP Group","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":153,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('FSP Group MP7 76 CFM Air 153mm Black')
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
  'Rosewill RCX-ZAIO-92 54.8 CFM Sleeve Bearing Air 138mm',
  1500,
  '{"manufacturer":"Rosewill","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":138,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Rosewill RCX-ZAIO-92 54.8 CFM Sleeve Bearing Air 138mm')
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
  'ARCTIC Alpine 11 Plus Air 70mm Fluid Dynamic Bearing',
  1500,
  '{"manufacturer":"ARCTIC","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":70,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ARCTIC Alpine 11 Plus Air 70mm Fluid Dynamic Bearing')
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
  'Cooler Master MasterLiquid ML240R RGB Water 240mm',
  1500,
  '{"manufacturer":"Cooler Master","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cooler Master MasterLiquid ML240R RGB Water 240mm')
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
  'Deepcool Gammaxx L360 V2 Water 360mm Black / White',
  1500,
  '{"manufacturer":"Deepcool","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool Gammaxx L360 V2 Water 360mm Black / White')
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
  'Enermax LIQMAX III RGB Water 240mm 72.1 CFM Black',
  1500,
  '{"manufacturer":"Enermax","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Enermax LIQMAX III RGB Water 240mm 72.1 CFM Black')
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
  'MSI MAG CORELIQUID I360 70.7 CFM Water 360mm White',
  1500,
  '{"manufacturer":"MSI","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":62,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('MSI MAG CORELIQUID I360 70.7 CFM Water 360mm White')
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
  'Deepcool CASTLE 240EX Water 240mm RGB 60.6 CFM Black',
  1500,
  '{"manufacturer":"Deepcool","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool CASTLE 240EX Water 240mm RGB 60.6 CFM Black')
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
  'Ocypus Iota Water 360mm 77 CFM White',
  1500,
  '{"manufacturer":"Ocypus","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Ocypus Iota Water 360mm 77 CFM White')
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
  'Geometric Future Eskimo Junior 36 69.11 CFM Water 360mm Black',
  1500,
  '{"manufacturer":"Geometric Future","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":53,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Geometric Future Eskimo Junior 36 69.11 CFM Water 360mm Black')
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
  'Deepcool LE320 Water 120mm 85.85 CFM White',
  1500,
  '{"manufacturer":"Deepcool","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":52,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool LE320 Water 120mm 85.85 CFM White')
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
  'Deepcool ICE BLADE PRO V2.0 Air 161mm 60.29 CFM',
  1500,
  '{"manufacturer":"Deepcool","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":161,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool ICE BLADE PRO V2.0 Air 161mm 60.29 CFM')
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
  'NZXT Kraken Z53 73.11 CFM Water 240mm Black',
  1500,
  '{"manufacturer":"NZXT","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('NZXT Kraken Z53 73.11 CFM Water 240mm Black')
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
  'ARCTIC Alpine 12 CO Air 77mm Black / Gray',
  1500,
  '{"manufacturer":"ARCTIC","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":77,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ARCTIC Alpine 12 CO Air 77mm Black / Gray')
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
  'NZXT Kraken X52 Rev 2 Water 240mm 73.11 CFM',
  1500,
  '{"manufacturer":"NZXT","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('NZXT Kraken X52 Rev 2 Water 240mm 73.11 CFM')
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
  'StarTech FAN775E Air 49.37 CFM',
  1500,
  '{"manufacturer":"StarTech","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":68,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('StarTech FAN775E Air 49.37 CFM')
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
  'Thermalright Assassin X Refined SE ARGB Air 148mm Black / Silver',
  1500,
  '{"manufacturer":"Thermalright","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":148,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermalright Assassin X Refined SE ARGB Air 148mm Black / Silver')
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
  'Cooler Master Masterliquid 240 Atmos Water 240mm White',
  1500,
  '{"manufacturer":"Cooler Master","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":53,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cooler Master Masterliquid 240 Atmos Water 240mm White')
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
  'CRYORIG R1 Ultimate Air 76 CFM 169mm',
  1500,
  '{"manufacturer":"CRYORIG","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":169,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('CRYORIG R1 Ultimate Air 76 CFM 169mm')
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
  'BitFenix Cube ARGB 60 CFM Water 240mm ARGB 60 CFM Black',
  1500,
  '{"manufacturer":"BitFenix","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('BitFenix Cube ARGB 60 CFM Water 240mm ARGB 60 CFM Black')
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
  'DarkFlash Shadow PWM CPU Cooler',
  1500,
  '{"manufacturer":"darkFlash","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":94,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('DarkFlash Shadow PWM CPU Cooler')
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
  'iBuypower AW4 Water 360mm 65 CFM White',
  1500,
  '{"manufacturer":"iBuypower","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('iBuypower AW4 Water 360mm 65 CFM White')
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
  'Cooler Master Hyper 212X Air 158mm',
  1500,
  '{"manufacturer":"Cooler Master","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":158,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cooler Master Hyper 212X Air 158mm')
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
  'Vetroo V240 Water 240mm 52 CFM Pink',
  1500,
  '{"manufacturer":"Vetroo","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Vetroo V240 Water 240mm 52 CFM Pink')
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
  'Xilence LQ360G.W.ARGB Water 360mm 68.2 CFM White',
  1500,
  '{"manufacturer":"Xilence","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Xilence LQ360G.W.ARGB Water 360mm 68.2 CFM White')
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
  'Lian Li Hydroshift LCD Water 360mm White',
  1500,
  '{"manufacturer":"Lian Li","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":59,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Lian Li Hydroshift LCD Water 360mm White')
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
  'NZXT Kraken X63 Water 280mm Black',
  1500,
  '{"manufacturer":"NZXT","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('NZXT Kraken X63 Water 280mm Black')
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
  'Jonsbo HX6250 90.2 CFM Air 162mm Black',
  1500,
  '{"manufacturer":"Jonsbo","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":162,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Jonsbo HX6250 90.2 CFM Air 162mm Black')
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
  'EVGA CLCx 360 Water 360mm 73.15 CFM Black',
  1500,
  '{"manufacturer":"EVGA","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('EVGA CLCx 360 Water 360mm 73.15 CFM Black')
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
  'Thermaltake UX200 SE Air 156mm ARGB Black',
  1500,
  '{"manufacturer":"Thermaltake","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":156,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermaltake UX200 SE Air 156mm ARGB Black')
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
  'Noctua NH-L12S Air 70mm',
  1500,
  '{"manufacturer":"Noctua","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":70,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Noctua NH-L12S Air 70mm')
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
  'Thermalright Frozen Notte Water 240mm ARGB Black',
  1500,
  '{"manufacturer":"Thermalright","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermalright Frozen Notte Water 240mm ARGB Black')
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
  'ASUS ROG RYUJIN III 240 ARGB White Edition ',
  1500,
  '{"manufacturer":"ASUS","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ASUS ROG RYUJIN III 240 ARGB White Edition ')
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
  'NZXT Kraken X52 Water 240mm',
  1500,
  '{"manufacturer":"NZXT","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('NZXT Kraken X52 Water 240mm')
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
  'ARCTIC Liquid Freezer II 280 Water 280mm RGB 68.9 CFM Black',
  1500,
  '{"manufacturer":"ARCTIC","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ARCTIC Liquid Freezer II 280 Water 280mm RGB 68.9 CFM Black')
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
  'Deepcool AG500 Air ARGB 67.88 CFM 155mm White',
  1500,
  '{"manufacturer":"Deepcool","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":155,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool AG500 Air ARGB 67.88 CFM 155mm White')
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
  'Deepcool GAMERSTORM CAPTAIN 240X Water 240mm 64.4 CFM White / Black',
  1500,
  '{"manufacturer":"Deepcool","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool GAMERSTORM CAPTAIN 240X Water 240mm 64.4 CFM White / Black')
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
  'Thermaltake TH420 Water 420mm ARGB Sync 84.32 CFM White',
  1500,
  '{"manufacturer":"Thermaltake","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermaltake TH420 Water 420mm ARGB Sync 84.32 CFM White')
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
  'Silverstone NovaPeak Water 240mm 69.8 CFM Black',
  1500,
  '{"manufacturer":"Silverstone","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":54,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silverstone NovaPeak Water 240mm 69.8 CFM Black')
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
  'Silverstone NT06-PRO-V2 Air 82mm Silver / Black',
  1500,
  '{"manufacturer":"Silverstone","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":82,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Silverstone NT06-PRO-V2 Air 82mm Silver / Black')
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
  'ARCTIC Liquid Freezer II Water 420mm Black',
  1500,
  '{"manufacturer":"ARCTIC","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ARCTIC Liquid Freezer II Water 420mm Black')
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
  'Xilence LQ240 ARGB 68.2 CFM Water 240mm Black',
  1500,
  '{"manufacturer":"Xilence","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":47,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Xilence LQ240 ARGB 68.2 CFM Water 240mm Black')
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
  'Fractal Design Kelvin T12 Water 120mm 62.4 CFM',
  1500,
  '{"manufacturer":"Fractal Design","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Fractal Design Kelvin T12 Water 120mm 62.4 CFM')
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
  'Vetroo R360 Water 360mm White',
  1500,
  '{"manufacturer":"Vetroo","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":55,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Vetroo R360 Water 360mm White')
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
  'ARCTIC Freezer i30 Air 74 CFM 161mm',
  1500,
  '{"manufacturer":"ARCTIC","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":161,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ARCTIC Freezer i30 Air 74 CFM 161mm')
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
  'ARCTIC Alpine 23 Air 65mm White / Black',
  1500,
  '{"manufacturer":"ARCTIC","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":65,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ARCTIC Alpine 23 Air 65mm White / Black')
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
  'Thermalright AQUA ELITE ARGB V4 66.17 CFM Water 240mm Black',
  1500,
  '{"manufacturer":"Thermalright","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":48,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermalright AQUA ELITE ARGB V4 66.17 CFM Water 240mm Black')
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
  'NZXT Kraken Elite Water 280mm RGB White',
  1500,
  '{"manufacturer":"NZXT","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('NZXT Kraken Elite Water 280mm RGB White')
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
  'Asus Prime LC 360 ARGB LCD Water 360mm ARGB LCD 77.22 CFM White',
  1500,
  '{"manufacturer":"Asus","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":62,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus Prime LC 360 ARGB LCD Water 360mm ARGB LCD 77.22 CFM White')
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
  'NZXT Kraken Plus RGB Water 240mm 75.05 CFM White',
  1500,
  '{"manufacturer":"NZXT","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":56,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('NZXT Kraken Plus RGB Water 240mm 75.05 CFM White')
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
  'Phanteks PH-TC14PE_BK Air 171mm 78.1 CFM Black',
  1500,
  '{"manufacturer":"Phanteks","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":171,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Phanteks PH-TC14PE_BK Air 171mm 78.1 CFM Black')
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
  'Valkyrie DRAGONFANG 80 CFM Water 360mm Black',
  1500,
  '{"manufacturer":"Valkyrie","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Valkyrie DRAGONFANG 80 CFM Water 360mm Black')
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
  'GAMDIAS BOREAS M2-51D 72.94 CFM Air 159mm Black',
  1500,
  '{"manufacturer":"GAMDIAS","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":159,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('GAMDIAS BOREAS M2-51D 72.94 CFM Air 159mm Black')
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
  'Noctua NH-U9S Air 124mm',
  1500,
  '{"manufacturer":"Noctua","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":124,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Noctua NH-U9S Air 124mm')
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
  'Thermalright Grand Vision ARGB 69 CFM Water 72mm Black',
  1500,
  '{"manufacturer":"Thermalright","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":72,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermalright Grand Vision ARGB 69 CFM Water 72mm Black')
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
  'Enermax Liqmax III Water 120mm HF 90.1 CFM Black',
  1500,
  '{"manufacturer":"Enermax","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Enermax Liqmax III Water 120mm HF 90.1 CFM Black')
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
  'Deepcool CASTLE 360EX Water 360mm 64.4 CFM White / Black',
  1500,
  '{"manufacturer":"Deepcool","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool CASTLE 360EX Water 360mm 64.4 CFM White / Black')
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
  'ID-COOLING SE-902 Air 38.5 CFM',
  1500,
  '{"manufacturer":"ID-COOLING","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ID-COOLING SE-902 Air 38.5 CFM')
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
  'NZXT T120 Air 159mm White',
  1500,
  '{"manufacturer":"NZXT","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":159,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('NZXT T120 Air 159mm White')
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
  'Thermalright Frozen Warframe Water 240mm ARGB White',
  1500,
  '{"manufacturer":"Thermalright","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermalright Frozen Warframe Water 240mm ARGB White')
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
  'Asus TUF Gaming LC III ARGB LCD Water 360mm 90.78 CFM Black',
  1500,
  '{"manufacturer":"Asus","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":67,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus TUF Gaming LC III ARGB LCD Water 360mm 90.78 CFM Black')
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
  'ID-COOLING SPACE LCD Water 240mm 76.16 CFM White',
  1500,
  '{"manufacturer":"ID-COOLING","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ID-COOLING SPACE LCD Water 240mm 76.16 CFM White')
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
  'Gigabyte GAMING 360 61.61 CFM Water 360mm 61.61 CFM Black',
  1500,
  '{"manufacturer":"Gigabyte","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":63,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte GAMING 360 61.61 CFM Water 360mm 61.61 CFM Black')
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
  'Deepcool GAMMAXX 200 Air 143mm 37.18 CFM',
  1500,
  '{"manufacturer":"Deepcool","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":143,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool GAMMAXX 200 Air 143mm 37.18 CFM')
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
  'ID-COOLING FROZN A410 DK Air 152mm Black',
  1500,
  '{"manufacturer":"ID-COOLING","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":152,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ID-COOLING FROZN A410 DK Air 152mm Black')
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
  'Asus ROG Ryujin III Water 360mm ARGB Black',
  1500,
  '{"manufacturer":"Asus","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":101,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus ROG Ryujin III Water 360mm ARGB Black')
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
  'Deepcool LS720S ZERO DARK Water 360mm Black',
  1500,
  '{"manufacturer":"Deepcool","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":55,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool LS720S ZERO DARK Water 360mm Black')
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
  'Thermalright Frozen Notte ARGB Water 360mm Black',
  1500,
  '{"manufacturer":"Thermalright","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Thermalright Frozen Notte ARGB Water 360mm Black')
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
  'Deepcool AK400 Air 155mm ZERO DARK PLUS 59.46 CFM Black',
  1500,
  '{"manufacturer":"Deepcool","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":155,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Deepcool AK400 Air 155mm ZERO DARK PLUS 59.46 CFM Black')
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
  'upHere P5K CPU Air Cooler 230w TDP 6mm x 5 Copper Heat Pipes CPU Cooler with 120mm Fan PWM 1800RPM 77.93CFM for Intel LGA 2011/2066 (Mainboard X79/...',
  1500,
  '{"manufacturer":"upHere","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":153,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('upHere P5K CPU Air Cooler 230w TDP 6mm x 5 Copper Heat Pipes CPU Cooler with 120mm Fan PWM 1800RPM 77.93CFM for Intel LGA 2011/2066 (Mainboard X79/...')
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
  'ARCTIC Freezer 11 LP Air Fluid Dynamic Bearing 53mm',
  1500,
  '{"manufacturer":"ARCTIC","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":53,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ARCTIC Freezer 11 LP Air Fluid Dynamic Bearing 53mm')
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
  'Gigabyte AORUS WATERFORCE Water 280mm Black',
  1500,
  '{"manufacturer":"Gigabyte","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Gigabyte AORUS WATERFORCE Water 280mm Black')
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
  'Asus ROG STRIX LC II ARGB 80.95 CFM Liquid CPU Cooler',
  1500,
  '{"manufacturer":"Asus","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus ROG STRIX LC II ARGB 80.95 CFM Liquid CPU Cooler')
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
  'In Win SR36 PRO 101.5 CFM Water 360mm Black',
  1500,
  '{"manufacturer":"In Win","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":100,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('In Win SR36 PRO 101.5 CFM Water 360mm Black')
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
  'Cooler Master Nepton 140XL Water 140mm 122.5 CFM',
  1500,
  '{"manufacturer":"Cooler Master","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Cooler Master Nepton 140XL Water 140mm 122.5 CFM')
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
  'ARCTIC Freezer 34 CO Air 157mm Black / Silver',
  1500,
  '{"manufacturer":"ARCTIC","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":157,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('ARCTIC Freezer 34 CO Air 157mm Black / Silver')
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
  'Asus ROG STRIX LC III Water 360mm ARGB 70.38 CFM Black',
  1500,
  '{"manufacturer":"Asus","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus ROG STRIX LC III Water 360mm ARGB 70.38 CFM Black')
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
  'Jonsbo HX4170D Air 45mm Black',
  1500,
  '{"manufacturer":"Jonsbo","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":45,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Jonsbo HX4170D Air 45mm Black')
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
  'Asus ROG RYUJIN II Water 360mm 71.6 CFM Black',
  1500,
  '{"manufacturer":"Asus","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('Asus ROG RYUJIN II Water 360mm 71.6 CFM Black')
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
  'GAMDIAS AURA GL240 V2 Water 240mm 73.6 CFM',
  1500,
  '{"manufacturer":"GAMDIAS","supported_sockets":[],"supportedSockets":[],"sockets":[],"tdp":null,"tdpRating":null,"height":null,"type":"Air Cooler","coolerType":"Air Cooler"}'::jsonb,
  8,
  NULL,
  NULL
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('GAMDIAS AURA GL240 V2 Water 240mm 73.6 CFM')
);

-- Summary:
-- CPU: 120 imported, 0 skipped
-- Motherboard: 120 imported, 0 skipped
-- RAM: 120 imported, 0 skipped
-- Storage: 120 imported, 0 skipped
-- GPU: 120 imported, 0 skipped
-- PSU: 120 imported, 0 skipped
-- PCCase: 120 imported, 0 skipped
-- CPUCooler: 120 imported, 0 skipped
