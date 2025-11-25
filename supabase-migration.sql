-- Migration script for BUILDMATE database schema
-- Run this in your Supabase SQL editor

-- Create sequences
CREATE SEQUENCE IF NOT EXISTS users_user_id_seq;
CREATE SEQUENCE IF NOT EXISTS build_types_build_type_id_seq;
CREATE SEQUENCE IF NOT EXISTS builds_build_id_seq;
CREATE SEQUENCE IF NOT EXISTS component_categories_category_id_seq;
CREATE SEQUENCE IF NOT EXISTS components_component_id_seq;
CREATE SEQUENCE IF NOT EXISTS retailers_retailer_id_seq;
CREATE SEQUENCE IF NOT EXISTS build_components_build_component_id_seq;
CREATE SEQUENCE IF NOT EXISTS build_history_bhistory_id_seq;
CREATE SEQUENCE IF NOT EXISTS comments_comment_id_seq;
CREATE SEQUENCE IF NOT EXISTS build_guides_build_guide_id_seq;

-- Create tables
CREATE TABLE IF NOT EXISTS public.users (
  user_id integer NOT NULL DEFAULT nextval('users_user_id_seq'::regclass),
  user_name character varying NOT NULL,
  email character varying NOT NULL UNIQUE,
  password text NOT NULL,
  user_type text DEFAULT 'user'::text CHECK (user_type = ANY (ARRAY['admin'::text, 'user'::text, 'moderator'::text])),
  created_at timestamp without time zone DEFAULT now(),
  CONSTRAINT users_pkey PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS public.build_types (
  build_type_id integer NOT NULL DEFAULT nextval('build_types_build_type_id_seq'::regclass),
  type_name character varying NOT NULL,
  description text,
  CONSTRAINT build_types_pkey PRIMARY KEY (build_type_id)
);

CREATE TABLE IF NOT EXISTS public.component_categories (
  category_id integer NOT NULL DEFAULT nextval('component_categories_category_id_seq'::regclass),
  category_name character varying NOT NULL,
  description text,
  CONSTRAINT component_categories_pkey PRIMARY KEY (category_id)
);

CREATE TABLE IF NOT EXISTS public.retailers (
  retailer_id integer NOT NULL DEFAULT nextval('retailers_retailer_id_seq'::regclass),
  retailer_name character varying NOT NULL,
  email character varying,
  website text,
  retailer_address text,
  retailer_phone character varying,
  retailer_contact_person character varying,
  CONSTRAINT retailers_pkey PRIMARY KEY (retailer_id)
);

CREATE TABLE IF NOT EXISTS public.components (
  component_id integer NOT NULL DEFAULT nextval('components_component_id_seq'::regclass),
  component_name character varying NOT NULL,
  component_brand character varying(255),
  component_price numeric,
  component_description text,
  compatibility_information text,
  category_id integer NOT NULL,
  retailer_id integer,
  CONSTRAINT components_pkey PRIMARY KEY (component_id),
  CONSTRAINT fk_component_category FOREIGN KEY (category_id) REFERENCES public.component_categories(category_id),
  CONSTRAINT fk_component_retailer FOREIGN KEY (retailer_id) REFERENCES public.retailers(retailer_id)
);

CREATE TABLE IF NOT EXISTS public.builds (
  build_id integer NOT NULL DEFAULT nextval('builds_build_id_seq'::regclass),
  user_id integer NOT NULL,
  build_type_id integer NOT NULL,
  build_name character varying NOT NULL,
  date_created timestamp without time zone DEFAULT now(),
  CONSTRAINT builds_pkey PRIMARY KEY (build_id),
  CONSTRAINT fk_build_user FOREIGN KEY (user_id) REFERENCES public.users(user_id),
  CONSTRAINT fk_build_type FOREIGN KEY (build_type_id) REFERENCES public.build_types(build_type_id)
);

CREATE TABLE IF NOT EXISTS public.build_components (
  build_component_id integer NOT NULL DEFAULT nextval('build_components_build_component_id_seq'::regclass),
  build_id integer NOT NULL,
  component_id integer NOT NULL,
  CONSTRAINT build_components_pkey PRIMARY KEY (build_component_id),
  CONSTRAINT fk_build FOREIGN KEY (build_id) REFERENCES public.builds(build_id),
  CONSTRAINT fk_component FOREIGN KEY (component_id) REFERENCES public.components(component_id)
);

CREATE TABLE IF NOT EXISTS public.build_history (
  bhistory_id integer NOT NULL DEFAULT nextval('build_history_bhistory_id_seq'::regclass),
  build_id integer NOT NULL,
  change_description text,
  changed_at timestamp without time zone DEFAULT now(),
  CONSTRAINT build_history_pkey PRIMARY KEY (bhistory_id),
  CONSTRAINT fk_build_history FOREIGN KEY (build_id) REFERENCES public.builds(build_id)
);

CREATE TABLE IF NOT EXISTS public.comments (
  comment_id integer NOT NULL DEFAULT nextval('comments_comment_id_seq'::regclass),
  bhistory_id integer NOT NULL,
  user_id integer NOT NULL,
  comment_text text NOT NULL,
  commented_at timestamp without time zone DEFAULT now(),
  CONSTRAINT comments_pkey PRIMARY KEY (comment_id),
  CONSTRAINT fk_comment_history FOREIGN KEY (bhistory_id) REFERENCES public.build_history(bhistory_id),
  CONSTRAINT fk_comment_user FOREIGN KEY (user_id) REFERENCES public.users(user_id)
);

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

-- Insert initial data
INSERT INTO public.component_categories (category_name, description) VALUES
('CPU', 'Central Processing Unit'),
('Motherboard', 'Main circuit board'),
('Memory', 'Random Access Memory (RAM)'),
('Storage', 'Hard drives and SSDs'),
('GPU', 'Graphics Processing Unit'),
('PSU', 'Power Supply Unit'),
('Case', 'Computer case'),
('Cooling', 'CPU coolers and case fans')
ON CONFLICT DO NOTHING;

INSERT INTO public.build_types (type_name, description) VALUES
('Gaming', 'High-performance gaming builds'),
('Office', 'Business and productivity builds'),
('Budget', 'Cost-effective builds'),
('Workstation', 'Professional workstation builds'),
('HTPC', 'Home Theater PC builds'),
('Server', 'Server and enterprise builds')
ON CONFLICT DO NOTHING;

-- Enable Row Level Security (RLS)
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.builds ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.build_components ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.build_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.build_guides ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
-- Users can only see and modify their own data
CREATE POLICY "Users can view own profile" ON public.users
  FOR SELECT USING (auth.uid()::text = user_id::text);

CREATE POLICY "Users can update own profile" ON public.users
  FOR UPDATE USING (auth.uid()::text = user_id::text);

-- Users can see and modify their own builds
CREATE POLICY "Users can view own builds" ON public.builds
  FOR SELECT USING (auth.uid()::text = user_id::text);

CREATE POLICY "Users can create own builds" ON public.builds
  FOR INSERT WITH CHECK (auth.uid()::text = user_id::text);

CREATE POLICY "Users can update own builds" ON public.builds
  FOR UPDATE USING (auth.uid()::text = user_id::text);

CREATE POLICY "Users can delete own builds" ON public.builds
  FOR DELETE USING (auth.uid()::text = user_id::text);

-- Build components follow build permissions
CREATE POLICY "Users can view own build components" ON public.build_components
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.builds 
      WHERE builds.build_id = build_components.build_id 
      AND auth.uid()::text = builds.user_id::text
    )
  );

CREATE POLICY "Users can modify own build components" ON public.build_components
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.builds 
      WHERE builds.build_id = build_components.build_id 
      AND auth.uid()::text = builds.user_id::text
    )
  );

-- Public read access for components, categories, and build types
CREATE POLICY "Public can view components" ON public.components
  FOR SELECT USING (true);

CREATE POLICY "Public can view component categories" ON public.component_categories
  FOR SELECT USING (true);

CREATE POLICY "Public can view build types" ON public.build_types
  FOR SELECT USING (true);

CREATE POLICY "Public can view retailers" ON public.retailers
  FOR SELECT USING (true);

-- Build history and comments follow build permissions
CREATE POLICY "Users can view own build history" ON public.build_history
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.builds 
      WHERE builds.build_id = build_history.build_id 
      AND auth.uid()::text = builds.user_id::text
    )
  );

CREATE POLICY "Users can create own build history" ON public.build_history
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.builds 
      WHERE builds.build_id = build_history.build_id 
      AND auth.uid()::text = builds.user_id::text
    )
  );

CREATE POLICY "Users can view own build comments" ON public.comments
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.build_history 
      JOIN public.builds ON builds.build_id = build_history.build_id
      WHERE build_history.bhistory_id = comments.bhistory_id 
      AND auth.uid()::text = builds.user_id::text
    )
  );

CREATE POLICY "Users can create comments on own builds" ON public.comments
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.build_history 
      JOIN public.builds ON builds.build_id = build_history.build_id
      WHERE build_history.bhistory_id = comments.bhistory_id 
      AND auth.uid()::text = builds.user_id::text
    )
  );

-- Build guides policies
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

