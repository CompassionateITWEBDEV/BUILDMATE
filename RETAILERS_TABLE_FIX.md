# Retailers Table Fix

## ✅ Issue Fixed

**Error**: `column retailers_3.retailer_email does not exist`

**Cause**: Code was using `retailer_email` but the table column is named `email`

## 🔧 Changes Made

### 1. Fixed Code References

**File: `app/purchase/[id]/page.tsx`**
- Changed interface: `retailer_email?: string` → `email?: string`
- Changed query: `retailer_email` → `email`
- Changed display: `retailer.retailer_email` → `retailer.email` (2 places)

**File: `app/api/purchase/send-email/route.ts`**
- Changed query: `retailer_email` → `email`
- Changed email template: `retailer.retailer_email` → `retailer.email`

### 2. Created SQL Script

**File: `create-retailers-table.sql`**
- Creates the `retailers` table with correct column names
- Sets up RLS policies
- Grants necessary permissions

## 📊 Table Structure

```sql
retailers
├── retailer_id (serial, primary key)
├── retailer_name (varchar 150, not null)
├── email (varchar 150, nullable) ← Note: 'email' not 'retailer_email'
├── website (text, nullable)
├── retailer_address (text, nullable)
├── retailer_phone (varchar 20, nullable)
└── retailer_contact_person (varchar 100, nullable)
```

## 📋 Next Steps

1. **Run SQL Script in Supabase**:
   - Go to Supabase Dashboard → SQL Editor
   - Copy contents of `create-retailers-table.sql`
   - Run the script

2. **Verify**:
   - Check that `retailers` table exists
   - Verify column is named `email` (not `retailer_email`)

## ✅ All Fixed

All references to `retailer_email` have been changed to `email` to match the database schema.

