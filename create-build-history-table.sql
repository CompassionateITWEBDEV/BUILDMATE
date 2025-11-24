-- Create build_history table in Supabase
-- Run this in Supabase SQL Editor

-- Create sequence if it doesn't exist
CREATE SEQUENCE IF NOT EXISTS build_history_bhistory_id_seq;

-- Create build_history table
CREATE TABLE IF NOT EXISTS public.build_history (
  bhistory_id integer NOT NULL DEFAULT nextval('build_history_bhistory_id_seq'::regclass),
  build_id integer NOT NULL,
  change_description text NULL,
  changed_at timestamp with time zone NULL DEFAULT now(),
  CONSTRAINT build_history_pkey PRIMARY KEY (bhistory_id),
  CONSTRAINT fk_build_history FOREIGN KEY (build_id) REFERENCES public.builds (build_id) ON DELETE CASCADE
) TABLESPACE pg_default;

-- Enable Row Level Security
ALTER TABLE public.build_history ENABLE ROW LEVEL SECURITY;

-- Create policy for users to view their own build history
DROP POLICY IF EXISTS "Users can view own build history" ON public.build_history;
CREATE POLICY "Users can view own build history" ON public.build_history
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.builds 
      WHERE builds.build_id = build_history.build_id 
      AND builds.user_id = auth.uid()::text::integer
    )
  );

-- Create policy for users to create their own build history
DROP POLICY IF EXISTS "Users can create own build history" ON public.build_history;
CREATE POLICY "Users can create own build history" ON public.build_history
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.builds 
      WHERE builds.build_id = build_history.build_id 
      AND builds.user_id = auth.uid()::text::integer
    )
  );

-- Grant necessary permissions
GRANT SELECT, INSERT ON public.build_history TO authenticated;
GRANT USAGE ON SEQUENCE build_history_bhistory_id_seq TO authenticated;

