# Vercel Deployment Guide for BuildMate

This guide covers deploying BuildMate to Vercel, including the photo upload functionality.

## Prerequisites

1. A Vercel account (sign up at [vercel.com](https://vercel.com))
2. A GitHub repository with your code
3. A Supabase project with storage bucket configured

## Step 1: Connect Repository to Vercel

1. Go to [vercel.com](https://vercel.com) and sign in
2. Click **"Add New Project"**
3. Import your GitHub repository
4. Select the repository: `BUILDMATE-1f` (or your repo name)

## Step 2: Configure Environment Variables

In the Vercel project settings, go to **Settings** → **Environment Variables** and add:

### Required Supabase Variables:

```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key
```

### SMTP Configuration (for email verification):

```env
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASSWORD=your_gmail_app_password
SMTP_FROM_EMAIL=BUILDMATE <your-email@gmail.com>
SMTP_FROM_NAME=BUILDMATE
```

### Python Backend URL (if using):

```env
PYTHON_API_URL=https://your-python-backend-url.onrender.com
```

### Other Variables:

```env
NODE_ENV=production
```

## Step 3: Configure Supabase Storage for Photo Uploads

The photo upload feature requires a Supabase storage bucket. Follow these steps:

### 3.1 Create Storage Bucket

1. Go to your Supabase Dashboard
2. Navigate to **Storage** in the left sidebar
3. Click **"New bucket"**
4. Create a bucket named: `profile_pictures`
5. Set it to **Public** (or configure RLS policies)

### 3.2 Configure Bucket Policies

Go to **Storage** → **Policies** → `profile_pictures` and add:

**Policy 1: Allow authenticated users to upload**
```sql
CREATE POLICY "Users can upload their own avatars"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'profile_pictures' AND
  (storage.foldername(name))[1] = 'avatars' AND
  auth.uid()::text = (storage.foldername(name))[2]
);
```

**Policy 2: Allow public read access**
```sql
CREATE POLICY "Public avatar access"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'profile_pictures');
```

**Policy 3: Allow users to delete their own avatars**
```sql
CREATE POLICY "Users can delete their own avatars"
ON storage.objects FOR DELETE
TO authenticated
USING (
  bucket_id = 'profile_pictures' AND
  auth.uid()::text = (storage.foldername(name))[2]
);
```

### 3.3 Verify Storage Configuration

1. In Supabase Dashboard → **Storage** → **profile_pictures**
2. Check that the bucket exists
3. Verify policies are active
4. Test upload manually if needed

## Step 4: Configure Vercel Build Settings

In your Vercel project settings:

1. Go to **Settings** → **General**
2. **Framework Preset:** Next.js (auto-detected)
3. **Root Directory:** `./` (or leave blank)
4. **Build Command:** `pnpm build` (or `npm run build`)
5. **Output Directory:** `.next` (default)
6. **Install Command:** `pnpm install` (or `npm install`)

## Step 5: Deploy

1. Click **"Deploy"** in Vercel
2. Wait for the build to complete
3. Your app will be available at: `https://your-project.vercel.app`

## Step 6: Test Photo Upload Functionality

1. Navigate to your deployed app
2. Log in to your account
3. Go to **Profile Settings**
4. Click the camera icon on your avatar
5. Select an image
6. Crop the image
7. Click **"Upload"**
8. Verify the avatar updates successfully

## Troubleshooting

### Upload Not Working?

1. **Check Supabase Storage Bucket:**
   - Verify `profile_pictures` bucket exists
   - Check bucket policies are configured
   - Ensure bucket is public or RLS policies allow access

2. **Check Environment Variables:**
   - Go to Vercel → **Settings** → **Environment Variables**
   - Verify `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_ANON_KEY` are set
   - Redeploy after adding variables

3. **Check Browser Console:**
   - Open browser DevTools (F12)
   - Check Console for errors
   - Look for Supabase storage errors

4. **Check Vercel Logs:**
   - Go to Vercel Dashboard → **Deployments** → Select deployment → **Logs**
   - Look for build or runtime errors

### Common Errors

**Error: "Bucket not found"**
- Solution: Create the `profile_pictures` bucket in Supabase Storage

**Error: "Policy violation"**
- Solution: Check and update RLS policies for the storage bucket

**Error: "Failed to upload"**
- Solution: Verify `NEXT_PUBLIC_SUPABASE_ANON_KEY` has storage permissions

## File Size Limits

- **Vercel:** 4.5MB per file (for serverless functions)
- **Supabase Storage:** Default 50MB per file
- **Recommended:** Keep avatar images under 2MB for best performance

## Performance Optimization

1. **Image Optimization:**
   - The upload feature includes image cropping
   - Images are converted to PNG format
   - Consider adding image compression before upload

2. **CDN:**
   - Supabase Storage serves images via CDN
   - Images are automatically cached

## Additional Resources

- [Vercel Documentation](https://vercel.com/docs)
- [Supabase Storage Documentation](https://supabase.com/docs/guides/storage)
- [Next.js Deployment](https://nextjs.org/docs/deployment)

