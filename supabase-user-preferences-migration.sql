-- Migration to add notification preferences and privacy settings to users table
-- Run this in Supabase SQL Editor

-- Add notification_preferences column (JSONB for flexibility)
ALTER TABLE public.users
ADD COLUMN IF NOT EXISTS notification_preferences JSONB DEFAULT '{
  "emailUpdates": true,
  "buildLikes": true,
  "comments": true,
  "followers": false,
  "newsletter": true
}'::jsonb;

-- Add privacy_settings column (JSONB for flexibility)
ALTER TABLE public.users
ADD COLUMN IF NOT EXISTS privacy_settings JSONB DEFAULT '{
  "profilePublic": true,
  "showBuilds": true,
  "showActivity": false,
  "showEmail": false
}'::jsonb;

-- Add comments for documentation
COMMENT ON COLUMN public.users.notification_preferences IS 'User notification preferences stored as JSON';
COMMENT ON COLUMN public.users.privacy_settings IS 'User privacy settings stored as JSON';

