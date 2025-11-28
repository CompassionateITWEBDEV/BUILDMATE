-- Add component_purpose column to components table if it doesn't exist
-- This column is used for performance category filtering (gaming, academic, office)

ALTER TABLE public.components 
ADD COLUMN IF NOT EXISTS component_purpose VARCHAR(50);

-- Add comment to explain the field
COMMENT ON COLUMN public.components.component_purpose IS 'Performance category: gaming, academic, office, or NULL for all categories';



