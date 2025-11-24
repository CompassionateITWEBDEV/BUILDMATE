-- Create retailers table in Supabase
-- Run this in Supabase SQL Editor

-- Create sequence if it doesn't exist
CREATE SEQUENCE IF NOT EXISTS retailers_retailer_id_seq;

-- Create retailers table
CREATE TABLE IF NOT EXISTS public.retailers (
  retailer_id integer NOT NULL DEFAULT nextval('retailers_retailer_id_seq'::regclass),
  retailer_name character varying(150) NOT NULL,
  email character varying(150) NULL,
  website text NULL,
  retailer_address text NULL,
  retailer_phone character varying(20) NULL,
  retailer_contact_person character varying(100) NULL,
  CONSTRAINT retailers_pkey PRIMARY KEY (retailer_id)
) TABLESPACE pg_default;

-- Enable Row Level Security
ALTER TABLE public.retailers ENABLE ROW LEVEL SECURITY;

-- Create policy for public read access
DROP POLICY IF EXISTS "Public can view retailers" ON public.retailers;
CREATE POLICY "Public can view retailers" ON public.retailers
  FOR SELECT USING (true);

-- Grant necessary permissions
GRANT SELECT ON public.retailers TO anon;
GRANT SELECT ON public.retailers TO authenticated;

