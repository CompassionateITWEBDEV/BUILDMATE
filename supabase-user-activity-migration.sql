-- Migration for User Activity Tracking
-- Run this in Supabase SQL Editor

-- Create sequence for user_activity
CREATE SEQUENCE IF NOT EXISTS user_activity_activity_id_seq;

-- Create user_activity table
CREATE TABLE IF NOT EXISTS public.user_activity (
  activity_id integer NOT NULL DEFAULT nextval('user_activity_activity_id_seq'::regclass),
  user_id integer NOT NULL,
  activity_type character varying(50) NOT NULL CHECK (activity_type IN ('login', 'logout', 'build_created', 'build_updated', 'build_deleted', 'component_viewed', 'guide_viewed', 'profile_updated')),
  activity_description text NOT NULL,
  ip_address character varying(45),
  user_agent text,
  created_at timestamp without time zone DEFAULT now(),
  CONSTRAINT user_activity_pkey PRIMARY KEY (activity_id),
  CONSTRAINT fk_user_activity_user FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE
);

-- Create indexes for faster queries
CREATE INDEX IF NOT EXISTS idx_user_activity_user_id ON public.user_activity(user_id);
CREATE INDEX IF NOT EXISTS idx_user_activity_type ON public.user_activity(activity_type);
CREATE INDEX IF NOT EXISTS idx_user_activity_created_at ON public.user_activity(created_at DESC);

-- Enable Row Level Security
ALTER TABLE public.user_activity ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
CREATE POLICY "Users can view own activity" ON public.user_activity
  FOR SELECT USING (auth.uid()::text = (SELECT supabase_id::text FROM public.users WHERE users.user_id = user_activity.user_id));

CREATE POLICY "Admins can view all activity" ON public.user_activity
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.users 
      WHERE users.supabase_id::text = auth.uid()::text 
      AND users.user_type = 'admin'
    )
  );

CREATE POLICY "System can insert activity" ON public.user_activity
  FOR INSERT WITH CHECK (true);

-- Grant permissions
GRANT SELECT ON public.user_activity TO authenticated;
GRANT INSERT ON public.user_activity TO authenticated;

-- Add comments
COMMENT ON TABLE public.user_activity IS 'Tracks user activities for monitoring and analytics';
COMMENT ON COLUMN public.user_activity.activity_type IS 'Type of activity: login, logout, build_created, build_updated, build_deleted, component_viewed, guide_viewed, profile_updated';

