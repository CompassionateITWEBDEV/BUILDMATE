-- Create build_types table in Supabase
-- Run this in Supabase SQL Editor

-- Create sequence if it doesn't exist
CREATE SEQUENCE IF NOT EXISTS build_types_build_type_id_seq;

-- Create build_types table
CREATE TABLE IF NOT EXISTS public.build_types (
  build_type_id integer NOT NULL DEFAULT nextval('build_types_build_type_id_seq'::regclass),
  type_name character varying(100) NOT NULL,
  description text NULL,
  CONSTRAINT build_types_pkey PRIMARY KEY (build_type_id)
) TABLESPACE pg_default;

-- Insert default build types if they don't exist
-- Using type_name for conflict check since it should be unique
INSERT INTO public.build_types (type_name, description) 
SELECT * FROM (VALUES
  ('Gaming', 'High-performance gaming builds'),
  ('Office', 'Business and productivity builds'),
  ('Budget', 'Cost-effective builds'),
  ('Workstation', 'Professional workstation builds'),
  ('HTPC', 'Home Theater PC builds'),
  ('Server', 'Server and enterprise builds')
) AS v(type_name, description)
WHERE NOT EXISTS (
  SELECT 1 FROM public.build_types WHERE build_types.type_name = v.type_name
);

-- Enable Row Level Security
ALTER TABLE public.build_types ENABLE ROW LEVEL SECURITY;

-- Create policy for public read access
DROP POLICY IF EXISTS "Public can view build types" ON public.build_types;
CREATE POLICY "Public can view build types" ON public.build_types
  FOR SELECT USING (true);

-- Grant necessary permissions
GRANT SELECT ON public.build_types TO anon;
GRANT SELECT ON public.build_types TO authenticated;

