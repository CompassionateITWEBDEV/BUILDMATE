-- ============================================================
-- CREATE OR UPDATE COMPONENT CATEGORIES
-- ============================================================
-- This ensures the category IDs match what the insert script expects

-- Create categories if they don't exist
INSERT INTO component_categories (category_id, category_name)
VALUES 
    (1, 'CPU'),
    (2, 'Motherboard'),
    (3, 'Memory'),
    (4, 'Storage'),
    (5, 'GPU'),
    (6, 'PSU'),
    (7, 'Case'),
    (8, 'Cooling')
ON CONFLICT (category_id) DO UPDATE
SET category_name = EXCLUDED.category_name;

-- Verify categories
SELECT * FROM component_categories ORDER BY category_id;







