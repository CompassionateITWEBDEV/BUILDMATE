-- ============================================================
-- INSERT SAMPLE PC COMPONENTS WITH IMAGES
-- ============================================================
-- This script will populate your database with sample components
-- Run this if your components table is empty
-- ============================================================

-- ============================================================
-- ADD MISSING COLUMNS IF THEY DON'T EXIST
-- ============================================================
-- Add component_image column
ALTER TABLE components 
ADD COLUMN IF NOT EXISTS component_image TEXT;

-- Add component_brand column
ALTER TABLE components 
ADD COLUMN IF NOT EXISTS component_brand TEXT;

-- Add component_purpose column
ALTER TABLE components 
ADD COLUMN IF NOT EXISTS component_purpose TEXT;

-- Add availability_status column
ALTER TABLE components 
ADD COLUMN IF NOT EXISTS availability_status TEXT DEFAULT 'in_stock';

-- Add comments to explain the fields
COMMENT ON COLUMN components.component_image IS 'URL or Supabase Storage path to the component image';
COMMENT ON COLUMN components.component_brand IS 'Brand or manufacturer of the component';
COMMENT ON COLUMN components.component_purpose IS 'Intended use: academic, office, or gaming';
COMMENT ON COLUMN components.availability_status IS 'Stock status: in_stock, out_of_stock, low_stock, discontinued';

-- ============================================================
-- INSERT SAMPLE CPUs (Category 1)
-- ============================================================
INSERT INTO components (component_name, component_brand, component_price, category_id, availability_status, component_purpose, component_image)
VALUES 
    ('Intel Core i9-13900K', 'Intel', 35000, 1, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/0066cc/ffffff?text=Intel+Core+i9-13900K'),
    ('Intel Core i7-13700K', 'Intel', 28000, 1, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/0066cc/ffffff?text=Intel+Core+i7-13700K'),
    ('Intel Core i5-13600K', 'Intel', 18000, 1, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/0066cc/ffffff?text=Intel+Core+i5-13600K'),
    ('Intel Core i5-12400F', 'Intel', 9000, 1, 'in_stock', 'office', 'https://via.placeholder.com/400x400/0066cc/ffffff?text=Intel+Core+i5-12400F'),
    ('Intel Core i3-12100', 'Intel', 6000, 1, 'in_stock', 'academic', 'https://via.placeholder.com/400x400/0066cc/ffffff?text=Intel+Core+i3-12100'),
    ('AMD Ryzen 9 7950X', 'AMD', 38000, 1, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/0066cc/ffffff?text=AMD+Ryzen+9+7950X'),
    ('AMD Ryzen 7 7700X', 'AMD', 25000, 1, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/0066cc/ffffff?text=AMD+Ryzen+7+7700X'),
    ('AMD Ryzen 5 5600X', 'AMD', 10000, 1, 'in_stock', 'office', 'https://via.placeholder.com/400x400/0066cc/ffffff?text=AMD+Ryzen+5+5600X'),
    ('AMD Ryzen 5 5600G', 'AMD', 9000, 1, 'in_stock', 'office', 'https://via.placeholder.com/400x400/0066cc/ffffff?text=AMD+Ryzen+5+5600G'),
    ('AMD Ryzen 3 3200G', 'AMD', 5000, 1, 'in_stock', 'academic', 'https://via.placeholder.com/400x400/0066cc/ffffff?text=AMD+Ryzen+3+3200G')
ON CONFLICT DO NOTHING;

-- ============================================================
-- INSERT SAMPLE MOTHERBOARDS (Category 2)
-- ============================================================
INSERT INTO components (component_name, component_brand, component_price, category_id, availability_status, component_purpose, component_image)
VALUES 
    ('ASUS ROG Strix Z790-E', 'ASUS', 28000, 2, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/00aa44/ffffff?text=ASUS+ROG+Strix+Z790-E'),
    ('MSI MAG Z790 Tomahawk', 'MSI', 22000, 2, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/00aa44/ffffff?text=MSI+MAG+Z790+Tomahawk'),
    ('Gigabyte B760 AORUS Elite', 'Gigabyte', 12000, 2, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/00aa44/ffffff?text=Gigabyte+B760+Elite'),
    ('ASRock B660M Pro RS', 'ASRock', 7000, 2, 'in_stock', 'office', 'https://via.placeholder.com/400x400/00aa44/ffffff?text=ASRock+B660M+Pro'),
    ('ASUS Prime H610M-E', 'ASUS', 4500, 2, 'in_stock', 'academic', 'https://via.placeholder.com/400x400/00aa44/ffffff?text=ASUS+Prime+H610M-E'),
    ('MSI MPG X670E Carbon', 'MSI', 30000, 2, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/00aa44/ffffff?text=MSI+X670E+Carbon'),
    ('ASUS TUF Gaming B650-PLUS', 'ASUS', 15000, 2, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/00aa44/ffffff?text=ASUS+TUF+B650-PLUS'),
    ('Gigabyte B550 AORUS Elite', 'Gigabyte', 10000, 2, 'in_stock', 'office', 'https://via.placeholder.com/400x400/00aa44/ffffff?text=Gigabyte+B550+Elite'),
    ('MSI B450M PRO-VDH MAX', 'MSI', 5500, 2, 'in_stock', 'office', 'https://via.placeholder.com/400x400/00aa44/ffffff?text=MSI+B450M+PRO-VDH'),
    ('ASRock A520M-HVS', 'ASRock', 3500, 2, 'in_stock', 'academic', 'https://via.placeholder.com/400x400/00aa44/ffffff?text=ASRock+A520M-HVS')
ON CONFLICT DO NOTHING;

-- ============================================================
-- INSERT SAMPLE RAM/MEMORY (Category 3)
-- ============================================================
INSERT INTO components (component_name, component_brand, component_price, category_id, availability_status, component_purpose, component_image)
VALUES 
    ('Corsair Vengeance RGB 32GB DDR5-6000', 'Corsair', 12000, 3, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/9933cc/ffffff?text=Corsair+Vengeance+32GB'),
    ('G.Skill Trident Z5 32GB DDR5-5600', 'G.Skill', 10000, 3, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/9933cc/ffffff?text=GSkill+Trident+32GB'),
    ('Kingston Fury Beast 16GB DDR4-3200', 'Kingston', 3500, 3, 'in_stock', 'office', 'https://via.placeholder.com/400x400/9933cc/ffffff?text=Kingston+Fury+16GB'),
    ('Crucial 8GB DDR4-2666', 'Crucial', 1500, 3, 'in_stock', 'academic', 'https://via.placeholder.com/400x400/9933cc/ffffff?text=Crucial+8GB+DDR4'),
    ('Corsair Vengeance LPX 16GB DDR4-3600', 'Corsair', 4000, 3, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/9933cc/ffffff?text=Corsair+LPX+16GB'),
    ('G.Skill Ripjaws V 32GB DDR4-3600', 'G.Skill', 7500, 3, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/9933cc/ffffff?text=GSkill+Ripjaws+32GB'),
    ('Kingston Fury Beast 32GB DDR5-5200', 'Kingston', 9000, 3, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/9933cc/ffffff?text=Kingston+Beast+32GB'),
    ('Crucial Ballistix 16GB DDR4-3200', 'Crucial', 3800, 3, 'in_stock', 'office', 'https://via.placeholder.com/400x400/9933cc/ffffff?text=Crucial+Ballistix+16GB')
ON CONFLICT DO NOTHING;

-- ============================================================
-- INSERT SAMPLE STORAGE (Category 4)
-- ============================================================
INSERT INTO components (component_name, component_brand, component_price, category_id, availability_status, component_purpose, component_image)
VALUES 
    ('Samsung 990 Pro 2TB NVMe', 'Samsung', 12000, 4, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/ff8800/ffffff?text=Samsung+990+Pro+2TB'),
    ('Samsung 980 Pro 1TB NVMe', 'Samsung', 7000, 4, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/ff8800/ffffff?text=Samsung+980+Pro+1TB'),
    ('WD Black SN850X 1TB NVMe', 'Western Digital', 6500, 4, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/ff8800/ffffff?text=WD+Black+SN850X+1TB'),
    ('Kingston NV2 500GB NVMe', 'Kingston', 2500, 4, 'in_stock', 'office', 'https://via.placeholder.com/400x400/ff8800/ffffff?text=Kingston+NV2+500GB'),
    ('Crucial P3 500GB NVMe', 'Crucial', 2300, 4, 'in_stock', 'academic', 'https://via.placeholder.com/400x400/ff8800/ffffff?text=Crucial+P3+500GB'),
    ('Seagate Barracuda 2TB HDD', 'Seagate', 3500, 4, 'in_stock', 'office', 'https://via.placeholder.com/400x400/ff8800/ffffff?text=Seagate+2TB+HDD'),
    ('WD Blue 1TB HDD', 'Western Digital', 2000, 4, 'in_stock', 'academic', 'https://via.placeholder.com/400x400/ff8800/ffffff?text=WD+Blue+1TB+HDD')
ON CONFLICT DO NOTHING;

-- ============================================================
-- INSERT SAMPLE GPUs (Category 5)
-- ============================================================
INSERT INTO components (component_name, component_brand, component_price, category_id, availability_status, component_purpose, component_image)
VALUES 
    ('ASUS ROG Strix RTX 4090', 'ASUS', 120000, 5, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/cc0000/ffffff?text=ASUS+RTX+4090'),
    ('MSI Gaming X Trio RTX 4080', 'MSI', 80000, 5, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/cc0000/ffffff?text=MSI+RTX+4080'),
    ('Gigabyte Gaming OC RTX 4070 Ti', 'Gigabyte', 55000, 5, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/cc0000/ffffff?text=Gigabyte+RTX+4070Ti'),
    ('ASUS Dual RTX 4060 Ti', 'ASUS', 35000, 5, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/cc0000/ffffff?text=ASUS+RTX+4060Ti'),
    ('MSI Ventus 2X RTX 4060', 'MSI', 25000, 5, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/cc0000/ffffff?text=MSI+RTX+4060'),
    ('Gigabyte Eagle RTX 3060', 'Gigabyte', 20000, 5, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/cc0000/ffffff?text=Gigabyte+RTX+3060'),
    ('Sapphire Pulse RX 7900 XTX', 'Sapphire', 70000, 5, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/cc0000/ffffff?text=Sapphire+RX+7900XTX'),
    ('PowerColor Red Devil RX 7800 XT', 'PowerColor', 45000, 5, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/cc0000/ffffff?text=PowerColor+RX+7800XT'),
    ('ASUS Dual RX 6600', 'ASUS', 18000, 5, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/cc0000/ffffff?text=ASUS+RX+6600')
ON CONFLICT DO NOTHING;

-- ============================================================
-- INSERT SAMPLE PSUs (Category 6)
-- ============================================================
INSERT INTO components (component_name, component_brand, component_price, category_id, availability_status, component_purpose, component_image)
VALUES 
    ('Corsair RM1000x 1000W 80+ Gold', 'Corsair', 12000, 6, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/ffaa00/ffffff?text=Corsair+RM1000x'),
    ('Seasonic Focus GX-850 850W', 'Seasonic', 8500, 6, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/ffaa00/ffffff?text=Seasonic+850W'),
    ('EVGA SuperNOVA 750W 80+ Gold', 'EVGA', 7000, 6, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/ffaa00/ffffff?text=EVGA+750W'),
    ('Corsair CV650 650W 80+ Bronze', 'Corsair', 4000, 6, 'in_stock', 'office', 'https://via.placeholder.com/400x400/ffaa00/ffffff?text=Corsair+CV650'),
    ('Thermaltake Smart 500W', 'Thermaltake', 2500, 6, 'in_stock', 'academic', 'https://via.placeholder.com/400x400/ffaa00/ffffff?text=Thermaltake+500W')
ON CONFLICT DO NOTHING;

-- ============================================================
-- INSERT SAMPLE CASES (Category 7)
-- ============================================================
INSERT INTO components (component_name, component_brand, component_price, category_id, availability_status, component_purpose, component_image)
VALUES 
    ('NZXT H7 Flow Mid Tower', 'NZXT', 8000, 7, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/666666/ffffff?text=NZXT+H7+Flow'),
    ('Corsair 4000D Airflow', 'Corsair', 7000, 7, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/666666/ffffff?text=Corsair+4000D'),
    ('Fractal Design Meshify 2', 'Fractal Design', 9000, 7, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/666666/ffffff?text=Fractal+Meshify+2'),
    ('Lian Li Lancool 216', 'Lian Li', 8500, 7, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/666666/ffffff?text=Lian+Li+216'),
    ('Cooler Master MasterBox Q300L', 'Cooler Master', 3500, 7, 'in_stock', 'office', 'https://via.placeholder.com/400x400/666666/ffffff?text=CM+Q300L'),
    ('Tecware Forge M', 'Tecware', 2000, 7, 'in_stock', 'academic', 'https://via.placeholder.com/400x400/666666/ffffff?text=Tecware+Forge+M')
ON CONFLICT DO NOTHING;

-- ============================================================
-- INSERT SAMPLE COOLING (Category 8)
-- ============================================================
INSERT INTO components (component_name, component_brand, component_price, category_id, availability_status, component_purpose, component_image)
VALUES 
    ('Noctua NH-D15 CPU Cooler', 'Noctua', 6000, 8, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/00ccff/ffffff?text=Noctua+NH-D15'),
    ('Corsair iCUE H150i Elite LCD', 'Corsair', 12000, 8, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/00ccff/ffffff?text=Corsair+H150i'),
    ('NZXT Kraken X63 280mm AIO', 'NZXT', 9000, 8, 'in_stock', 'gaming', 'https://via.placeholder.com/400x400/00ccff/ffffff?text=NZXT+Kraken+X63'),
    ('Cooler Master Hyper 212 Black', 'Cooler Master', 2500, 8, 'in_stock', 'office', 'https://via.placeholder.com/400x400/00ccff/ffffff?text=CM+Hyper+212'),
    ('be quiet! Pure Rock 2', 'be quiet!', 3000, 8, 'in_stock', 'office', 'https://via.placeholder.com/400x400/00ccff/ffffff?text=be+quiet+Rock+2'),
    ('DeepCool AK400', 'DeepCool', 1800, 8, 'in_stock', 'academic', 'https://via.placeholder.com/400x400/00ccff/ffffff?text=DeepCool+AK400')
ON CONFLICT DO NOTHING;

-- ============================================================
-- VERIFY INSERTED COMPONENTS
-- ============================================================
SELECT 
    cc.category_id,
    cc.category_name,
    COUNT(c.component_id) as component_count,
    MIN(c.component_price) as min_price,
    MAX(c.component_price) as max_price
FROM component_categories cc
LEFT JOIN components c ON cc.category_id = c.category_id
GROUP BY cc.category_id, cc.category_name
ORDER BY cc.category_id;

-- Show total count
SELECT COUNT(*) as total_components FROM components;

