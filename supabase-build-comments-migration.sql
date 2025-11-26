-- Migration to create build_comments table
-- Run this in Supabase SQL Editor

-- Create sequence for build_comments
CREATE SEQUENCE IF NOT EXISTS build_comments_comment_id_seq;

-- Create build_comments table
CREATE TABLE IF NOT EXISTS public.build_comments (
  comment_id integer NOT NULL DEFAULT nextval('build_comments_comment_id_seq'::regclass),
  build_id integer NOT NULL,
  user_id integer NOT NULL,
  content text NOT NULL,
  likes integer DEFAULT 0,
  created_at timestamp with time zone DEFAULT now(),
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT build_comments_pkey PRIMARY KEY (comment_id),
  CONSTRAINT fk_build_comment_build FOREIGN KEY (build_id) REFERENCES public.builds(build_id) ON DELETE CASCADE,
  CONSTRAINT fk_build_comment_user FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_build_comments_build_id ON public.build_comments(build_id);
CREATE INDEX IF NOT EXISTS idx_build_comments_user_id ON public.build_comments(user_id);
CREATE INDEX IF NOT EXISTS idx_build_comments_created_at ON public.build_comments(created_at DESC);

-- Enable Row Level Security
ALTER TABLE public.build_comments ENABLE ROW LEVEL SECURITY;

-- Create RLS policies
-- Anyone can view comments
DROP POLICY IF EXISTS "Anyone can view build comments" ON public.build_comments;
CREATE POLICY "Anyone can view build comments" ON public.build_comments
  FOR SELECT USING (true);

-- Authenticated users can insert comments
DROP POLICY IF EXISTS "Authenticated users can insert comments" ON public.build_comments;
CREATE POLICY "Authenticated users can insert comments" ON public.build_comments
  FOR INSERT TO authenticated WITH CHECK (true);

-- Users can update their own comments
DROP POLICY IF EXISTS "Users can update their own comments" ON public.build_comments;
CREATE POLICY "Users can update their own comments" ON public.build_comments
  FOR UPDATE TO authenticated USING (
    auth.uid()::text = (SELECT supabase_id::text FROM public.users WHERE user_id = build_comments.user_id)
  );

-- Users can delete their own comments
DROP POLICY IF EXISTS "Users can delete their own comments" ON public.build_comments;
CREATE POLICY "Users can delete their own comments" ON public.build_comments
  FOR DELETE TO authenticated USING (
    auth.uid()::text = (SELECT supabase_id::text FROM public.users WHERE user_id = build_comments.user_id)
  );

-- Grant necessary permissions
GRANT SELECT ON public.build_comments TO anon;
GRANT SELECT, INSERT, UPDATE, DELETE ON public.build_comments TO authenticated;

-- Add comments for documentation
COMMENT ON TABLE public.build_comments IS 'Comments on community builds';
COMMENT ON COLUMN public.build_comments.comment_id IS 'Primary key for comment';
COMMENT ON COLUMN public.build_comments.build_id IS 'Foreign key to builds table';
COMMENT ON COLUMN public.build_comments.user_id IS 'Foreign key to users table (comment author)';
COMMENT ON COLUMN public.build_comments.content IS 'Comment text content';
COMMENT ON COLUMN public.build_comments.likes IS 'Number of likes on the comment';

