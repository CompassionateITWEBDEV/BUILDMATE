-- Migration to create followers table
-- Run this in Supabase SQL Editor

-- Create sequence for followers
CREATE SEQUENCE IF NOT EXISTS followers_follow_id_seq;

-- Create followers table
CREATE TABLE IF NOT EXISTS public.followers (
  follow_id integer NOT NULL DEFAULT nextval('followers_follow_id_seq'::regclass),
  user_id integer NOT NULL, -- The user being followed
  follower_user_id integer NOT NULL, -- The user who is following
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT followers_pkey PRIMARY KEY (follow_id),
  CONSTRAINT fk_followers_user FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE,
  CONSTRAINT fk_followers_follower FOREIGN KEY (follower_user_id) REFERENCES public.users(user_id) ON DELETE CASCADE,
  CONSTRAINT unique_follow_relationship UNIQUE (user_id, follower_user_id) -- Prevent duplicate follows
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_followers_user_id ON public.followers(user_id);
CREATE INDEX IF NOT EXISTS idx_followers_follower_user_id ON public.followers(follower_user_id);
CREATE INDEX IF NOT EXISTS idx_followers_created_at ON public.followers(created_at DESC);

-- Enable Row Level Security
ALTER TABLE public.followers ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
-- Anyone can view followers (public information)
DROP POLICY IF EXISTS "Anyone can view followers" ON public.followers;
CREATE POLICY "Anyone can view followers" ON public.followers
  FOR SELECT USING (true);

-- Authenticated users can insert (follow) other users
DROP POLICY IF EXISTS "Authenticated users can follow" ON public.followers;
CREATE POLICY "Authenticated users can follow" ON public.followers
  FOR INSERT TO authenticated WITH CHECK (
    auth.uid()::text = (SELECT supabase_id::text FROM public.users WHERE user_id = followers.follower_user_id)
    AND user_id != follower_user_id -- Prevent self-follow
  );

-- Users can delete (unfollow) their own follow relationships
DROP POLICY IF EXISTS "Users can unfollow" ON public.followers;
CREATE POLICY "Users can unfollow" ON public.followers
  FOR DELETE TO authenticated USING (
    auth.uid()::text = (SELECT supabase_id::text FROM public.users WHERE user_id = followers.follower_user_id)
  );

-- Grant necessary permissions
GRANT SELECT ON public.followers TO anon;
GRANT SELECT, INSERT, DELETE ON public.followers TO authenticated;

-- Add comments for documentation
COMMENT ON TABLE public.followers IS 'User follow relationships';
COMMENT ON COLUMN public.followers.user_id IS 'The user being followed';
COMMENT ON COLUMN public.followers.follower_user_id IS 'The user who is following';
COMMENT ON COLUMN public.followers.created_at IS 'When the follow relationship was created';

