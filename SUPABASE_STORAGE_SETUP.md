# Supabase Storage Setup for Photo Uploads

This guide explains how to set up Supabase Storage for the photo upload functionality in BuildMate.

## Prerequisites

1. A Supabase project (create at [supabase.com](https://supabase.com))
2. Admin access to your Supabase dashboard

## Step 1: Create Storage Bucket

1. Go to your Supabase Dashboard
2. Navigate to **Storage** in the left sidebar
3. Click **"New bucket"**
4. Enter bucket name: `profile_pictures`
5. **Important:** Make the bucket **Public** (or configure RLS policies)
6. Click **"Create bucket"**

## Step 2: Configure Storage Policies

Go to **Storage** → **Policies** → Select `profile_pictures` bucket

### Policy 1: Allow Authenticated Users to Upload

```sql
CREATE POLICY "Users can upload their own avatars"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'profile_pictures' AND
  (storage.foldername(name))[1] = 'avatars'
);
```

### Policy 2: Allow Public Read Access

```sql
CREATE POLICY "Public avatar access"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'profile_pictures');
```

### Policy 3: Allow Users to Update Their Own Avatars

```sql
CREATE POLICY "Users can update their own avatars"
ON storage.objects FOR UPDATE
TO authenticated
USING (
  bucket_id = 'profile_pictures' AND
  (storage.foldername(name))[1] = 'avatars'
);
```

### Policy 4: Allow Users to Delete Their Own Avatars

```sql
CREATE POLICY "Users can delete their own avatars"
ON storage.objects FOR DELETE
TO authenticated
USING (
  bucket_id = 'profile_pictures' AND
  (storage.foldername(name))[1] = 'avatars'
);
```

## Step 3: Verify Configuration

1. Go to **Storage** → **profile_pictures**
2. Check that the bucket exists
3. Go to **Policies** tab
4. Verify all 4 policies are active (green checkmark)

## Step 4: Test Upload (Optional)

1. In Supabase Dashboard → **Storage** → **profile_pictures**
2. Click **"Upload file"**
3. Upload a test image
4. Verify it appears in the bucket

## Folder Structure

The upload functionality stores files in this structure:
```
profile_pictures/
  └── avatars/
      └── {user_id}-{timestamp}.png
```

Example:
```
profile_pictures/
  └── avatars/
      └── 123e4567-e89b-12d3-a456-426614174000-1703123456789.png
```

## Environment Variables

Make sure these are set in your Vercel/Render environment:

```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
```

## Troubleshooting

### Error: "Bucket not found"
- **Solution:** Create the `profile_pictures` bucket in Supabase Storage

### Error: "Policy violation" or "Access denied"
- **Solution:** Check that RLS policies are configured correctly
- Verify the bucket is public OR policies allow authenticated access

### Error: "Failed to upload"
- **Check:** Browser console for specific error messages
- **Verify:** `NEXT_PUBLIC_SUPABASE_ANON_KEY` has storage permissions
- **Check:** File size (should be under 50MB for Supabase)

### Images not displaying
- **Check:** Bucket is set to **Public**
- **Verify:** Public URL is accessible
- **Check:** CORS settings if accessing from different domain

## File Size Limits

- **Supabase Free Tier:** 50MB per file
- **Recommended:** Keep avatar images under 2MB for best performance
- **Current Implementation:** Images are cropped and converted to PNG

## Security Notes

1. **Public Bucket:** Makes images accessible to anyone with the URL
2. **RLS Policies:** Provide additional security layer
3. **File Naming:** Uses user ID + timestamp to prevent conflicts
4. **Old File Cleanup:** Old avatars are deleted when new ones are uploaded

## Additional Resources

- [Supabase Storage Documentation](https://supabase.com/docs/guides/storage)
- [Storage Policies Guide](https://supabase.com/docs/guides/storage/security/access-control)
- [RLS Policies](https://supabase.com/docs/guides/auth/row-level-security)

