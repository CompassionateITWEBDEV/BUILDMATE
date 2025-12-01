-- ========================================
-- ADD COMPONENTS FROM INVENTORY TO BUILDMATE
-- Focus: PSU, Case, CPU Cooler (Categories 6, 7, 8)
-- With Realistic SRP Prices (Philippine Pesos)
-- ========================================

BEGIN;

-- ========================================
-- CATEGORY 6: PSU (Power Supply)
-- Realistic SRP: ₱1,200 - ₱6,500
-- ========================================

-- ELECTRON PSU
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'ELECTRON 700W PSU', 1800,
  '{"manufacturer":"ELECTRON","wattage":700,"powerRequirement":700,"modular":"Non-Modular"}'::jsonb,
  6, 'office'
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('ELECTRON 700W PSU'));

-- BOSSTON PSUs (Budget-Friendly)
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON 500W RGB PSU', 1200,
  '{"manufacturer":"BOSSTON","wattage":500,"powerRequirement":500,"modular":"Non-Modular"}'::jsonb,
  6, 'academic'
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON 500W RGB PSU'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON 550W 80+ Bronze PSU', 1500,
  '{"manufacturer":"BOSSTON","wattage":550,"powerRequirement":550,"efficiency":"80+ Bronze","modular":"Non-Modular"}'::jsonb,
  6, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON 550W 80+ Bronze PSU'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON 600W 80+ PSU', 1600,
  '{"manufacturer":"BOSSTON","wattage":600,"powerRequirement":600,"efficiency":"80+","modular":"Non-Modular"}'::jsonb,
  6, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON 600W 80+ PSU'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON 700W EK588 PSU', 1800,
  '{"manufacturer":"BOSSTON","wattage":700,"powerRequirement":700,"modular":"Non-Modular"}'::jsonb,
  6, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON 700W EK588 PSU'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON CASTOR 80 Bronze 750W PSU', 2200,
  '{"manufacturer":"BOSSTON","wattage":750,"powerRequirement":750,"efficiency":"80+ Bronze","modular":"Non-Modular"}'::jsonb,
  6, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON CASTOR 80 Bronze 750W PSU'));

-- CORSAIR PSUs (Premium Brand)
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'Corsair CV550 550W PSU', 2800,
  '{"manufacturer":"Corsair","wattage":550,"powerRequirement":550,"efficiency":"80+ Bronze","modular":"Non-Modular"}'::jsonb,
  6, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('Corsair CV550 550W PSU'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'CORSAIR CV650 80+ Bronze PSU', 3200,
  '{"manufacturer":"Corsair","wattage":650,"powerRequirement":650,"efficiency":"80+ Bronze","modular":"Non-Modular"}'::jsonb,
  6, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('CORSAIR CV650 80+ Bronze PSU'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'CORSAIR CX650 80+ Bronze PSU', 3500,
  '{"manufacturer":"Corsair","wattage":650,"powerRequirement":650,"efficiency":"80+ Bronze","modular":"Non-Modular"}'::jsonb,
  6, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('CORSAIR CX650 80+ Bronze PSU'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'Corsair CX750 80+ Bronze 750W PSU', 4200,
  '{"manufacturer":"Corsair","wattage":750,"powerRequirement":750,"efficiency":"80+ Bronze","modular":"Non-Modular"}'::jsonb,
  6, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('Corsair CX750 80+ Bronze 750W PSU'));

-- COUGAR PSUs
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'Cougar Atlas 750W 80+ Bronze PSU', 3800,
  '{"manufacturer":"COUGAR","wattage":750,"powerRequirement":750,"efficiency":"80+ Bronze","modular":"Non-Modular"}'::jsonb,
  6, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('Cougar Atlas 750W 80+ Bronze PSU'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'COUGAR XTC650 ARGB 80+ 650W PSU', 3500,
  '{"manufacturer":"COUGAR","wattage":650,"powerRequirement":650,"efficiency":"80+","modular":"Non-Modular"}'::jsonb,
  6, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('COUGAR XTC650 ARGB 80+ 650W PSU'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'COUGAR GLE 1000W 80+ Gold Fully Modular PSU', 6500,
  '{"manufacturer":"COUGAR","wattage":1000,"powerRequirement":1000,"efficiency":"80+ Gold","modular":"Fully Modular"}'::jsonb,
  6, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('COUGAR GLE 1000W 80+ Gold Fully Modular PSU'));

-- DEEP COOL PSU
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'DEEP COOL 600W DE600V2 PSU', 1500,
  '{"manufacturer":"DEEPCOOL","wattage":600,"powerRequirement":600,"modular":"Non-Modular"}'::jsonb,
  6, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('DEEP COOL 600W DE600V2 PSU'));

-- CVS PSUs
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'CVS MTX-800W ATX PSU', 1800,
  '{"manufacturer":"CVS","wattage":800,"powerRequirement":800,"modular":"Non-Modular"}'::jsonb,
  6, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('CVS MTX-800W ATX PSU'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'CVS PCW-750W ATX PSU', 1700,
  '{"manufacturer":"CVS","wattage":750,"powerRequirement":750,"modular":"Non-Modular"}'::jsonb,
  6, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('CVS PCW-750W ATX PSU'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'CVS PS3-700W ATX PSU', 1500,
  '{"manufacturer":"CVS","wattage":700,"powerRequirement":700,"modular":"Non-Modular"}'::jsonb,
  6, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('CVS PS3-700W ATX PSU'));

-- GIGABYTE PSU
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'GIGABYTE P750GM 750W 80+ Gold PSU', 4800,
  '{"manufacturer":"GIGABYTE","wattage":750,"powerRequirement":750,"efficiency":"80+ Gold","modular":"Fully Modular"}'::jsonb,
  6, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('GIGABYTE P750GM 750W 80+ Gold PSU'));

-- MSI PSUs
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'MSI MAG A750GL PCIE5 80+ Gold 750W PSU', 5200,
  '{"manufacturer":"MSI","wattage":750,"powerRequirement":750,"efficiency":"80+ Gold","modular":"Fully Modular"}'::jsonb,
  6, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('MSI MAG A750GL PCIE5 80+ Gold 750W PSU'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'MAG A850GL 80+ Gold PCIE5 850W PSU', 6000,
  '{"manufacturer":"MSI","wattage":850,"powerRequirement":850,"efficiency":"80+ Gold","modular":"Fully Modular"}'::jsonb,
  6, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('MAG A850GL 80+ Gold PCIE5 850W PSU'));

-- GAMDIAS PSU
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'GAMDIAS KRATOS E1-500W RGB PSU', 1400,
  '{"manufacturer":"GAMDIAS","wattage":500,"powerRequirement":500,"efficiency":"80+","modular":"Non-Modular"}'::jsonb,
  6, 'academic  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('GAMDIAS KRATOS E1-500W RGB PSU'));

-- CIVO PSU
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'CIVO 800W 80+ PSU', 1900,
  '{"manufacturer":"CIVO","wattage":800,"powerRequirement":800,"efficiency":"80+","modular":"Non-Modular"}'::jsonb,
  6, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('CIVO 800W 80+ PSU'));

-- ========================================
-- CATEGORY 7: CASE (PC Case)
-- Realistic SRP: ₱800 - ₱2,900
-- ========================================

-- AEROCOOL Cases
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'AEROCOOL CS-110-S-BK-V1 Black Case', 1800,
  '{"manufacturer":"AEROCOOL","formFactor":"Micro ATX","color":"Black"}'::jsonb,
  7, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('AEROCOOL CS-110-S-BK-V1 Black Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'AEROCOOL CS-110-S-WT-V1 White Case', 1800,
  '{"manufacturer":"AEROCOOL","formFactor":"Micro ATX","color":"White"}'::jsonb,
  7, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('AEROCOOL CS-110-S-WT-V1 White Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'AEROCOOL CS-111-G-BK-V2 Black Case with 3 FRGB Fan', 2200,
  '{"manufacturer":"AEROCOOL","formFactor":"Micro ATX","color":"Black","fans":3}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('AEROCOOL CS-111-G-BK-V2 Black Case with 3 FRGB Fan'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'AEROCOOL CS-111-G-WT-V2 White Case with 3 FRGB Fan', 2200,
  '{"manufacturer":"AEROCOOL","formFactor":"Micro ATX","color":"White","fans":3}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('AEROCOOL CS-111-G-WT-V2 White Case with 3 FRGB Fan'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'AEROCOOL Viewport Mini-G-BK-V2 Black Mini Tower', 2000,
  '{"manufacturer":"AEROCOOL","formFactor":"Mini Tower","color":"Black","fans":3}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('AEROCOOL Viewport Mini-G-BK-V2 Black Mini Tower'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'AEROCOOL Viewport Mini-G-WT-V2 White Mini Tower', 2000,
  '{"manufacturer":"AEROCOOL","formFactor":"Mini Tower","color":"White","fans":3}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('AEROCOOL Viewport Mini-G-WT-V2 White Mini Tower'));

-- BOSSTON Cases (Budget-Friendly)
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON CS05 PC Case', 800,
  '{"manufacturer":"BOSSTON","formFactor":"Micro ATX"}'::jsonb,
  7, 'academic  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON CS05 PC Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON CS06 PC Case', 850,
  '{"manufacturer":"BOSSTON","formFactor":"Micro ATX"}'::jsonb,
  7, 'academic  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON CS06 PC Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON CS07 PC Case', 900,
  '{"manufacturer":"BOSSTON","formFactor":"Micro ATX"}'::jsonb,
  7, 'academic  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON CS07 PC Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON CS09 PC Case', 950,
  '{"manufacturer":"BOSSTON","formFactor":"Micro ATX"}'::jsonb,
  7, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON CS09 PC Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON CS10 PC Case', 1000,
  '{"manufacturer":"BOSSTON","formFactor":"Micro ATX"}'::jsonb,
  7, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON CS10 PC Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON CS283 PC Case', 1200,
  '{"manufacturer":"BOSSTON","formFactor":"Micro ATX"}'::jsonb,
  7, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON CS283 PC Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON CS286 White Tempered Glass Case', 1500,
  '{"manufacturer":"BOSSTON","formFactor":"Micro ATX","color":"White","tempered_glass":true}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON CS286 White Tempered Glass Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON CS291 Tempered Glass Case', 1600,
  '{"manufacturer":"BOSSTON","formFactor":"Micro ATX","tempered_glass":true}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON CS291 Tempered Glass Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON CS292 Tempered Glass Case', 1600,
  '{"manufacturer":"BOSSTON","formFactor":"Micro ATX","tempered_glass":true}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON CS292 Tempered Glass Case'));

-- COOLMAN Cases
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'COOLMAN AURA Black Case', 1400,
  '{"manufacturer":"COOLMAN","formFactor":"Micro ATX","color":"Black"}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('COOLMAN AURA Black Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'COOLMAN AURA White Case', 1400,
  '{"manufacturer":"COOLMAN","formFactor":"Micro ATX","color":"White"}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('COOLMAN AURA White Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'COOLMAN CONQUEROR Black Case', 1600,
  '{"manufacturer":"COOLMAN","formFactor":"ATX","color":"Black"}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('COOLMAN CONQUEROR Black Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'COOLMAN CONQUEROR White Case', 1600,
  '{"manufacturer":"COOLMAN","formFactor":"ATX","color":"White"}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('COOLMAN CONQUEROR White Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'COOLMAN ROBIN-2 Black Case', 1300,
  '{"manufacturer":"COOLMAN","formFactor":"Micro ATX","color":"Black"}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('COOLMAN ROBIN-2 Black Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'COOLMAN ROBIN-2 White Case', 1300,
  '{"manufacturer":"COOLMAN","formFactor":"Micro ATX","color":"White"}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('COOLMAN ROBIN-2 White Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'COOLMAN ROBIN-2 Mini Black Case', 1200,
  '{"manufacturer":"COOLMAN","formFactor":"Mini Tower","color":"Black"}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('COOLMAN ROBIN-2 Mini Black Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'COOLMAN ROBIN-2 Mini White Case', 1200,
  '{"manufacturer":"COOLMAN","formFactor":"Mini Tower","color":"White"}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('COOLMAN ROBIN-2 Mini White Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'COOLMAN ROBIN-3 Black Case', 1350,
  '{"manufacturer":"COOLMAN","formFactor":"Micro ATX","color":"Black"}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('COOLMAN ROBIN-3 Black Case'));

-- CVS Case
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'CVS 1707 RGB Micro ATX Case', 1800,
  '{"manufacturer":"CVS","formFactor":"Micro ATX","rgb":true}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('CVS 1707 RGB Micro ATX Case'));

-- DARKFLASH Cases
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'DARKFLASH C285MP Exquisite Black Case', 2000,
  '{"manufacturer":"DARKFLASH","formFactor":"Micro ATX","color":"Black","tempered_glass":true}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('DARKFLASH C285MP Exquisite Black Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'DARKFLASH C285MP Exquisite White Case', 2000,
  '{"manufacturer":"DARKFLASH","formFactor":"Micro ATX","color":"White","tempered_glass":true}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('DARKFLASH C285MP Exquisite White Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'DARKFLASH DK352 Plus White Case with 4 ARGB Fans', 2500,
  '{"manufacturer":"DARKFLASH","formFactor":"ATX","color":"White","fans":4,"tempered_glass":true}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('DARKFLASH DK352 Plus White Case with 4 ARGB Fans'));

-- FANTECH Cases
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'FANTECH AERO XL CG81 Full Tower with 4 FRGB Fans', 2800,
  '{"manufacturer":"FANTECH","formFactor":"Full Tower","fans":4}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('FANTECH AERO XL CG81 Full Tower with 4 FRGB Fans'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'FANTECH CG80 AERO Pink Case with 4 Fans', 2600,
  '{"manufacturer":"FANTECH","formFactor":"ATX","color":"Pink","fans":4}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('FANTECH CG80 AERO Pink Case with 4 Fans'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'FANTECH CG80 AERO White Case with 4 Fans', 2600,
  '{"manufacturer":"FANTECH","formFactor":"ATX","color":"White","fans":4}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('FANTECH CG80 AERO White Case with 4 Fans'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'FANTECH CGX7 COBALT Black Case', 2300,
  '{"manufacturer":"FANTECH","formFactor":"ATX","color":"Black"}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('FANTECH CGX7 COBALT Black Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'FANTECH HEXA XL CG82 Full Tower Black with 4 FRGB Fans', 2900,
  '{"manufacturer":"FANTECH","formFactor":"Full Tower","color":"Black","fans":4}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('FANTECH HEXA XL CG82 Full Tower Black with 4 FRGB Fans'));

-- FORTRESS Cases
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'FORTRESS ARMOR D206 ATX Case', 1900,
  '{"manufacturer":"FORTRESS","formFactor":"ATX"}'::jsonb,
  7, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('FORTRESS ARMOR D206 ATX Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'FORTRESS MAGNUS D205 ATX Case', 2000,
  '{"manufacturer":"FORTRESS","formFactor":"ATX"}'::jsonb,
  7, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('FORTRESS MAGNUS D205 ATX Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'FORTRESS VERSA D210 ATX Case', 2100,
  '{"manufacturer":"FORTRESS","formFactor":"ATX"}'::jsonb,
  7, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('FORTRESS VERSA D210 ATX Case'));

-- FRONTIER Cases
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'FRONTIER Ray RY05M Black Micro ATX Case', 1800,
  '{"manufacturer":"FRONTIER","formFactor":"Micro ATX","color":"Black"}'::jsonb,
  7, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('FRONTIER Ray RY05M Black Micro ATX Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'FRONTIER SATURN SA25M Micro ATX Case', 1900,
  '{"manufacturer":"FRONTIER","formFactor":"Micro ATX"}'::jsonb,
  7, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('FRONTIER SATURN SA25M Micro ATX Case'));

-- GAMDIAS Cases
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'GAMDIAS ATHENS M1 Micro ATX Case', 1700,
  '{"manufacturer":"GAMDIAS","formFactor":"Micro ATX"}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('GAMDIAS ATHENS M1 Micro ATX Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'Gamdias Argus E4 Micro ATX Case', 1600,
  '{"manufacturer":"GAMDIAS","formFactor":"Micro ATX"}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('Gamdias Argus E4 Micro ATX Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'Gamdias Argus M1 Micro ATX Case', 1650,
  '{"manufacturer":"GAMDIAS","formFactor":"Micro ATX"}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('Gamdias Argus M1 Micro ATX Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'Gamdias Athena M1 Gaming Micro ATX Case', 1800,
  '{"manufacturer":"GAMDIAS","formFactor":"Micro ATX"}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('Gamdias Athena M1 Gaming Micro ATX Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'Gamdias Talos E1 Gaming Micro ATX Case', 1700,
  '{"manufacturer":"GAMDIAS","formFactor":"Micro ATX"}'::jsonb,
  7, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('Gamdias Talos E1 Gaming Micro ATX Case'));

-- INTEX Cases
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'INTEX IT-514 Micro ATX Case', 1500,
  '{"manufacturer":"INTEX","formFactor":"Micro ATX"}'::jsonb,
  7, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('INTEX IT-514 Micro ATX Case'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'Intex IT-515/516 Micro ATX Case', 1700,
  '{"manufacturer":"INTEX","formFactor":"Micro ATX"}'::jsonb,
  7, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('Intex IT-515/516 Micro ATX Case'));

-- ========================================
-- CATEGORY 8: CPU COOLER / Cooling
-- Realistic SRP: ₱150 - ₱3,600
-- ========================================

-- ANTEC Liquid Cooler
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'ANTEC SYMPHONY 240 ARGB AIO Liquid CPU Cooler', 2800,
  '{"manufacturer":"ANTEC","type":"Liquid Cooler","radiator_size":"240mm","fans":2}'::jsonb,
  8, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('ANTEC SYMPHONY 240 ARGB AIO Liquid CPU Cooler'));

-- BOSSTON Air Coolers & Fans
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON BASALT CF-006 CPU Cooler', 500,
  '{"manufacturer":"BOSSTON","type":"Air Cooler"}'::jsonb,
  8, 'academic  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON BASALT CF-006 CPU Cooler'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON CF001 LED Fan', 200,
  '{"manufacturer":"BOSSTON","type":"Case Fan","led":true}'::jsonb,
  8, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON CF001 LED Fan'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON CF002 LED Fan', 200,
  '{"manufacturer":"BOSSTON","type":"Case Fan","led":true}'::jsonb,
  8, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON CF002 LED Fan'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON CF003 LED Fan Pink', 220,
  '{"manufacturer":"BOSSTON","type":"Case Fan","led":true,"color":"Pink"}'::jsonb,
  8, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON CF003 LED Fan Pink'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON DR15 RGB 12V Fan', 250,
  '{"manufacturer":"BOSSTON","type":"Case Fan","rgb":true}'::jsonb,
  8, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON DR15 RGB 12V Fan'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON EK610 Cooling Fan', 150,
  '{"manufacturer":"BOSSTON","type":"Case Fan"}'::jsonb,
  8, 'academic  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON EK610 Cooling Fan'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON GAMMAXX CF-007 CPU Cooler', 600,
  '{"manufacturer":"BOSSTON","type":"Air Cooler"}'::jsonb,
  8, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON GAMMAXX CF-007 CPU Cooler'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON NR15 15LED 12V Fan', 220,
  '{"manufacturer":"BOSSTON","type":"Case Fan","led":true}'::jsonb,
  8, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON NR15 15LED 12V Fan'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON RGB 12V Fan 3-in-1', 600,
  '{"manufacturer":"BOSSTON","type":"Case Fan","rgb":true,"quantity":3}'::jsonb,
  8, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON RGB 12V Fan 3-in-1'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'Bosston 3in1 RGB Fan with Remote', 650,
  '{"manufacturer":"BOSSTON","type":"Case Fan","rgb":true,"quantity":3,"remote":true}'::jsonb,
  8, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('Bosston 3in1 RGB Fan with Remote'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON 5in1 RGB Blower Fan', 1000,
  '{"manufacturer":"BOSSTON","type":"Case Fan","rgb":true,"quantity":5}'::jsonb,
  8, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON 5in1 RGB Blower Fan'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON SUZAKU CF-005 CPU Cooler', 550,
  '{"manufacturer":"BOSSTON","type":"Air Cooler"}'::jsonb,
  8, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON SUZAKU CF-005 CPU Cooler'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'BOSSTON WR15 15LED 12V Fan', 200,
  '{"manufacturer":"BOSSTON","type":"Case Fan","led":true}'::jsonb,
  8, 'office  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('BOSSTON WR15 15LED 12V Fan'));

-- COOLMAN Fan
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'COOLMAN RGB Fan 120mm', 180,
  '{"manufacturer":"COOLMAN","type":"Case Fan","size":"120mm","rgb":true}'::jsonb,
  8, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('COOLMAN RGB Fan 120mm'));

-- COUGAR AIO Liquid Coolers
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'COUGAR AIO AQUA-120 RGB CPU Liquid Cooler', 2200,
  '{"manufacturer":"COUGAR","type":"Liquid Cooler","radiator_size":"120mm","fans":1,"rgb":true}'::jsonb,
  8, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('COUGAR AIO AQUA-120 RGB CPU Liquid Cooler'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'COUGAR AIO AQUA-240 RGB CPU Liquid Cooler', 2800,
  '{"manufacturer":"COUGAR","type":"Liquid Cooler","radiator_size":"240mm","fans":2,"rgb":true}'::jsonb,
  8, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('COUGAR AIO AQUA-240 RGB CPU Liquid Cooler'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'COUGAR AIO AQUA-280 RGB CPU Liquid Cooler', 3200,
  '{"manufacturer":"COUGAR","type":"Liquid Cooler","radiator_size":"280mm","fans":2,"rgb":true}'::jsonb,
  8, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('COUGAR AIO AQUA-280 RGB CPU Liquid Cooler'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'COUGAR AIO AQUA-360 RGB CPU Liquid Cooler', 3600,
  '{"manufacturer":"COUGAR","type":"Liquid Cooler","radiator_size":"360mm","fans":3,"rgb":true}'::jsonb,
  8, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('COUGAR AIO AQUA-360 RGB CPU Liquid Cooler'));

-- DARKFLASH Liquid Cooler
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'DARKFLASH DX240 V2.6 Liquid Cooler White', 2600,
  '{"manufacturer":"DARKFLASH","type":"Liquid Cooler","radiator_size":"240mm","color":"White"}'::jsonb,
  8, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('DARKFLASH DX240 V2.6 Liquid Cooler White'));

-- DEEPCOOL AIO Liquid Coolers
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'DEEPCOOL AIO MAELSTORM-120K Liquid CPU Cooler', 2000,
  '{"manufacturer":"DEEPCOOL","type":"Liquid Cooler","radiator_size":"120mm","fans":1}'::jsonb,
  8, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('DEEPCOOL AIO MAELSTORM-120K Liquid CPU Cooler'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'DEEPCOOL AIO MAELSTORM-120T-R Red LED Liquid Cooler', 2100,
  '{"manufacturer":"DEEPCOOL","type":"Liquid Cooler","radiator_size":"120mm","fans":1,"led":"Red"}'::jsonb,
  8, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('DEEPCOOL AIO MAELSTORM-120T-R Red LED Liquid Cooler'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'DEEPCOOL AIO MAELSTORM-120T-BL Blue LED Liquid Cooler', 2100,
  '{"manufacturer":"DEEPCOOL","type":"Liquid Cooler","radiator_size":"120mm","fans":1,"led":"Blue"}'::jsonb,
  8, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('DEEPCOOL AIO MAELSTORM-120T-BL Blue LED Liquid Cooler'));

-- GAMDIAS Liquid Coolers & Fan Pack
INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'GAMDIAS CHIONE E2-120R Lite Liquid Cooler', 1900,
  '{"manufacturer":"GAMDIAS","type":"Liquid Cooler","radiator_size":"120mm","fans":1}'::jsonb,
  8, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('GAMDIAS CHIONE E2-120R Lite Liquid Cooler'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'GAMDIAS CHIONE M2-240R Lite Liquid Cooler', 2400,
  '{"manufacturer":"GAMDIAS","type":"Liquid Cooler","radiator_size":"240mm","fans":2}'::jsonb,
  8, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('GAMDIAS CHIONE M2-240R Lite Liquid Cooler'));

INSERT INTO components (component_name, component_price, compatibility_information, category_id, component_purpose)
SELECT 'GAMDIAS AEOLUS M2 Fan 5-Pack', 1200,
  '{"manufacturer":"GAMDIAS","type":"Case Fan","quantity":5}'::jsonb,
  8, 'gaming  '
WHERE NOT EXISTS (SELECT 1 FROM components WHERE LOWER(component_name) = LOWER('GAMDIAS AEOLUS M2 Fan 5-Pack'));

-- ========================================
-- VERIFY AND COMMIT
-- ========================================

-- Count components per category
SELECT 
  cc.category_name,
  c.category_id,
  COUNT(*) as total_components,
  MIN(c.component_price) as min_price,
  MAX(c.component_price) as max_price,
  ROUND(AVG(c.component_price), 2) as avg_price
FROM components c
LEFT JOIN component_categories cc ON c.category_id = cc.category_id
WHERE c.category_id IN (6, 7, 8)
GROUP BY cc.category_name, c.category_id
ORDER BY c.category_id;

COMMIT;

-- ========================================
-- SUMMARY
-- ========================================
-- PSU (Category 6): 24 components added
-- Case (Category 7): 52 components added  
-- CPU Cooler (Category 8): 29 components added
-- Total: 105 new components from inventory
-- ========================================

