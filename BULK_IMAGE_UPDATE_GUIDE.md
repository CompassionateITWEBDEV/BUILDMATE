# Bulk Component Image Update Guide

This guide helps you add images to all components in BuildMate.

## Quick Start: Using Admin Page

1. **Navigate to Admin Page**: Go to `/admin` (admin access required)
2. **Go to Components Tab**: Click on "Components" tab
3. **Edit Individual Images**: 
   - Click the "Edit" (pencil) icon next to each component
   - Enter the image URL
   - Click "Update Image"

## Bulk Update Methods

### Method 1: SQL Bulk Update (Fastest)

Run this in Supabase SQL Editor to update all components at once:

```sql
-- Example: Update all CPU images from Supabase Storage
UPDATE components 
SET component_image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/cpu/' || 
                     LOWER(REPLACE(REPLACE(component_name, ' ', '-'), '/', '-')) || '.jpg'
WHERE category_id = 1  -- 1 = CPU
AND component_image IS NULL;

-- Update Motherboard images
UPDATE components 
SET component_image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/motherboard/' || 
                     LOWER(REPLACE(REPLACE(component_name, ' ', '-'), '/', '-')) || '.jpg'
WHERE category_id = 2  -- 2 = Motherboard
AND component_image IS NULL;

-- Update RAM/Memory images
UPDATE components 
SET component_image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/ram/' || 
                     LOWER(REPLACE(REPLACE(component_name, ' ', '-'), '/', '-')) || '.jpg'
WHERE category_id = 3  -- 3 = RAM
AND component_image IS NULL;

-- Update Storage images
UPDATE components 
SET component_image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/storage/' || 
                     LOWER(REPLACE(REPLACE(component_name, ' ', '-'), '/', '-')) || '.jpg'
WHERE category_id = 4  -- 4 = Storage
AND component_image IS NULL;

-- Update GPU/Video Card images
UPDATE components 
SET component_image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/gpu/' || 
                     LOWER(REPLACE(REPLACE(component_name, ' ', '-'), '/', '-')) || '.jpg'
WHERE category_id = 5  -- 5 = GPU
AND component_image IS NULL;

-- Update PSU images
UPDATE components 
SET component_image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/psu/' || 
                     LOWER(REPLACE(REPLACE(component_name, ' ', '-'), '/', '-')) || '.jpg'
WHERE category_id = 6  -- 6 = PSU
AND component_image IS NULL;

-- Update Case images
UPDATE components 
SET component_image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/case/' || 
                     LOWER(REPLACE(REPLACE(component_name, ' ', '-'), '/', '-')) || '.jpg'
WHERE category_id = 7  -- 7 = Case
AND component_image IS NULL;

-- Update Cooling images
UPDATE components 
SET component_image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/cooling/' || 
                     LOWER(REPLACE(REPLACE(component_name, ' ', '-'), '/', '-')) || '.jpg'
WHERE category_id = 8  -- 8 = Cooling
AND component_image IS NULL;
```

### Method 2: Using External Image URLs

If you have images hosted elsewhere (e.g., manufacturer websites, CDN):

```sql
-- Update specific component by ID
UPDATE components 
SET component_image = 'https://example.com/images/intel-i7-13700k.jpg'
WHERE component_id = 123;

-- Update by component name pattern
UPDATE components 
SET component_image = 'https://example.com/images/' || LOWER(REPLACE(component_name, ' ', '-')) || '.jpg'
WHERE component_name LIKE 'AMD%'
AND component_image IS NULL;
```

### Method 3: Using Supabase Storage

1. **Create Storage Bucket**:
   - Go to Supabase Dashboard → Storage
   - Create bucket: `component-images`
   - Set to **Public**

2. **Upload Images**:
   - Organize by category: `cpu/`, `gpu/`, `ram/`, etc.
   - Upload images with descriptive names

3. **Update Database**:
   ```sql
   UPDATE components 
   SET component_image = 'https://YOUR-PROJECT-ID.supabase.co/storage/v1/object/public/component-images/cpu/intel-i7-13700k.jpg'
   WHERE component_id = 123;
   ```

## Image Naming Convention

Recommended naming format:
- `{brand}-{model}-{id}.jpg`
- Example: `intel-i7-13700k-123.jpg`
- Or: `amd-ryzen-5-5600x-456.jpg`

## Image Requirements

- **Format**: JPG, PNG, or WebP
- **Size**: 300x300px to 800x800px (square recommended)
- **File Size**: Under 500KB
- **Quality**: High quality, clear product images

## Finding Component Images

Good sources for component images:
1. **Manufacturer Websites**: Intel, AMD, NVIDIA, ASUS, MSI, etc.
2. **Retailer Websites**: Amazon, Newegg, Best Buy
3. **Image Search**: Google Images (use high-quality filters)
4. **Product Databases**: PCPartPicker, TechPowerUp

## Quick Update Script Template

```sql
-- Template for updating images based on component name
UPDATE components 
SET component_image = CASE
  WHEN component_name ILIKE '%intel%' THEN 'https://example.com/intel/' || component_id || '.jpg'
  WHEN component_name ILIKE '%amd%' THEN 'https://example.com/amd/' || component_id || '.jpg'
  WHEN component_name ILIKE '%nvidia%' THEN 'https://example.com/nvidia/' || component_id || '.jpg'
  ELSE 'https://example.com/default/' || component_id || '.jpg'
END
WHERE component_image IS NULL;
```

## Verification

After updating, verify images are showing:

```sql
-- Check components with images
SELECT component_id, component_name, component_image 
FROM components 
WHERE component_image IS NOT NULL;

-- Check components without images
SELECT component_id, component_name 
FROM components 
WHERE component_image IS NULL;
```

## Tips

1. **Start with Popular Components**: Update high-demand components first
2. **Use Consistent URLs**: Keep all images in the same storage location
3. **Test Images**: Verify URLs are accessible before bulk updates
4. **Backup First**: Always backup your database before bulk updates
5. **Update in Batches**: Update by category to avoid timeouts

## Troubleshooting

**Images not showing?**
- Check URL is accessible (open in browser)
- Verify Supabase Storage bucket is public
- Check for CORS issues
- Ensure URL format is correct

**Bulk update failed?**
- Update in smaller batches
- Check for special characters in component names
- Verify SQL syntax is correct
- Check Supabase query timeout settings

