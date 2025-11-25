-- Additional migration for missing ERD features
-- Run this after the main migration if the database already exists

-- Add missing columns to components table
ALTER TABLE public.components 
  ADD COLUMN IF NOT EXISTS component_brand character varying(255),
  ADD COLUMN IF NOT EXISTS component_description text;

-- Create sequence for build_guides if not exists
CREATE SEQUENCE IF NOT EXISTS build_guides_build_guide_id_seq;

-- Create build_guides table if not exists
CREATE TABLE IF NOT EXISTS public.build_guides (
  build_guide_id integer NOT NULL DEFAULT nextval('build_guides_build_guide_id_seq'::regclass),
  build_id integer NOT NULL,
  build_guide_name character varying(255) NOT NULL,
  guide_steps text NOT NULL,
  build_guide_thumbnail text,
  description character varying(255),
  created_at timestamp without time zone DEFAULT now(),
  updated_at timestamp without time zone DEFAULT now(),
  CONSTRAINT build_guides_pkey PRIMARY KEY (build_guide_id),
  CONSTRAINT fk_build_guide_build FOREIGN KEY (build_id) REFERENCES public.builds(build_id) ON DELETE CASCADE
);

-- Enable Row Level Security
ALTER TABLE public.build_guides ENABLE ROW LEVEL SECURITY;

-- Create RLS policies for build_guides
CREATE POLICY "Public can view build guides" ON public.build_guides
  FOR SELECT USING (true);

CREATE POLICY "Users can create build guides for own builds" ON public.build_guides
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.builds 
      WHERE builds.build_id = build_guides.build_id 
      AND auth.uid()::text = builds.user_id::text
    )
  );

CREATE POLICY "Users can update own build guides" ON public.build_guides
  FOR UPDATE USING (
    EXISTS (
      SELECT 1 FROM public.builds 
      WHERE builds.build_id = build_guides.build_id 
      AND auth.uid()::text = builds.user_id::text
    )
  );

CREATE POLICY "Users can delete own build guides" ON public.build_guides
  FOR DELETE USING (
    EXISTS (
      SELECT 1 FROM public.builds 
      WHERE builds.build_id = build_guides.build_id 
      AND auth.uid()::text = builds.user_id::text
    )
  );

-- Admin policies (allow admins to manage all data)
CREATE POLICY "Admins can manage all users" ON public.users
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.users 
      WHERE users.user_id::text = auth.uid()::text 
      AND users.user_type = 'admin'
    )
  );

CREATE POLICY "Admins can manage all builds" ON public.builds
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.users 
      WHERE users.user_id::text = auth.uid()::text 
      AND users.user_type = 'admin'
    )
  );

CREATE POLICY "Admins can manage all components" ON public.components
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.users 
      WHERE users.user_id::text = auth.uid()::text 
      AND users.user_type = 'admin'
    )
  );

CREATE POLICY "Admins can manage all build guides" ON public.build_guides
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.users 
      WHERE users.user_id::text = auth.uid()::text 
      AND users.user_type = 'admin'
    )
  );

