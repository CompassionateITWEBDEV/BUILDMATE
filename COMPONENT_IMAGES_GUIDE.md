# Component Images Guide

This guide explains how to add images for PC components in BuildMate.

## Database Setup

First, run the migration to add the `component_image` field to your database:

```sql
-- Run this in your Supabase SQL Editor
ALTER TABLE public.components 
ADD COLUMN IF NOT EXISTS component_image TEXT;
```

Or use the provided SQL file: `add-component-image-field.sql`

## Image Storage Options

You have two options for storing component images:

### Option 1: Supabase Storage (Recommended)

1. **Create a Storage Bucket:**
   - Go to Supabase Dashboard → Storage
   - Create a new bucket named `component-images`
   - Set it to **Public** (so images can be accessed without authentication)

2. **Upload Images:**
   - Upload component images to the bucket
   - Organize by category (e.g., `cpu/`, `gpu/`, `ram/`, etc.)
   - Recommended naming: `{component-name}-{id}.jpg` or `{component-name}-{id}.png`

3. **Get Image URL:**
   - After uploading, Supabase provides a public URL
   - Format: `https://{project-id}.supabase.co/storage/v1/object/public/component-images/{path-to-image}`

4. **Update Component:**
   - Use the Admin page or directly update the database:
   ```sql
   UPDATE components 
   SET component_image = 'https://{project-id}.supabase.co/storage/v1/object/public/component-images/cpu/intel-i7-13700k.jpg'
   WHERE component_id = 1;
   ```

### Option 2: External URLs

You can use external image URLs from:
- Manufacturer websites
- Retailer websites (e.g., Amazon, Newegg)
- CDN services (e.g., Cloudinary, Imgur)

**Example:**
```sql
UPDATE components 
SET component_image = 'https://example.com/images/intel-i7-13700k.jpg'
WHERE component_id = 1;
```

## Image Requirements

- **Format:** JPG, PNG, or WebP
- **Size:** Recommended 300x300px to 800x800px
- **Aspect Ratio:** Square (1:1) works best
- **File Size:** Keep under 500KB for faster loading
- **Quality:** Use high-quality images for better user experience

## Bulk Update Script

To update multiple components at once, you can use this SQL template:

```sql
-- Example: Update CPU images
UPDATE components 
SET component_image = 'https://{project-id}.supabase.co/storage/v1/object/public/component-images/cpu/' || 
                     LOWER(REPLACE(component_name, ' ', '-')) || '.jpg'
WHERE category_id = 1; -- 1 = CPU category
```

## Using the Admin Page

1. Navigate to `/admin` (admin access required)
2. Go to the "Components" tab
3. View components with their images (if set)
4. To update images, you'll need to use SQL or the Supabase dashboard

## Image Display

Images are automatically displayed in:
- **PC Builder** (`/builder`) - Component selection cards
- **Build Details** (`/mybuilds/[id]`, `/builds/[id]`) - Component lists
- **Admin Page** (`/admin`) - Component management

If no image is set, a placeholder image (`/placeholder.svg`) will be shown.

## Best Practices

1. **Consistent Naming:** Use a consistent naming convention for all images
2. **Optimize Images:** Compress images before uploading to reduce load times
3. **Organize by Category:** Store images in folders by component category
4. **Update Regularly:** Keep images up-to-date with current product versions
5. **Fallback Handling:** The app automatically shows a placeholder if an image fails to load

## Troubleshooting

**Images not showing?**
- Check that the URL is accessible (try opening in a new tab)
- Verify the Supabase Storage bucket is set to **Public**
- Check browser console for CORS or 404 errors

**Supabase Storage not working?**
- Ensure the bucket exists and is public
- Check RLS (Row Level Security) policies allow public access
- Verify the URL format is correct

**Need to update many images?**
- Use the Supabase dashboard for bulk uploads
- Or create a script to update the database programmatically


