-- Add component_image field to components table
-- This allows storing image URLs or Supabase Storage paths for each component

ALTER TABLE public.components 
ADD COLUMN IF NOT EXISTS component_image TEXT;

-- Add comment to explain the field
COMMENT ON COLUMN public.components.component_image IS 'URL or Supabase Storage path to the component image';


