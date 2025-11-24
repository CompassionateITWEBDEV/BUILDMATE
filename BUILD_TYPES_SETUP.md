# Build Types Table Setup Guide

## ✅ What's Been Fixed

1. **Created SQL script** - `create-build-types-table.sql` for Supabase
2. **Fixed code references** - Changed `build_type_name` to `type_name` in:
   - `app/purchase/[id]/page.tsx`
   - `app/api/purchase/send-email/route.ts`

## 📋 How to Create the Table in Supabase

### Step 1: Open Supabase Dashboard
1. Go to [https://supabase.com/dashboard](https://supabase.com/dashboard)
2. Select your project: `sldiqjjgddegffbzjqma`

### Step 2: Open SQL Editor
1. Click on **SQL Editor** in the left sidebar
2. Click **New Query**

### Step 3: Run the SQL Script
1. Open `create-build-types-table.sql` from your project
2. Copy the entire contents
3. Paste into the SQL Editor
4. Click **Run** (or press Ctrl+Enter)

### Step 4: Verify the Table
1. Go to **Table Editor** in the left sidebar
2. You should see `build_types` table
3. It should have 6 default build types:
   - Gaming
   - Office
   - Budget
   - Workstation
   - HTPC
   - Server

## 📊 Table Structure

```sql
build_types
├── build_type_id (serial, primary key)
├── type_name (varchar(100), not null)
└── description (text, nullable)
```

## 🔗 Foreign Key Relationship

The `builds` table references `build_types`:
- `builds.build_type_id` → `build_types.build_type_id`

## ✅ Permissions

- **Public Read Access**: Anyone can view build types
- **RLS Enabled**: Row Level Security is enabled
- **Policy**: "Public can view build types" allows SELECT for all users

## 🐛 Error Fixed

The error `column build_types_1.build_type_name does not exist` was caused by:
- Code was using `build_type_name` instead of `type_name`
- The actual column name in the table is `type_name`

All references have been updated to use `type_name` correctly.

## 🧪 Testing

After creating the table, test it:

```typescript
// In your code
const { data, error } = await supabase
  .from('build_types')
  .select('*')

console.log(data) // Should show all build types
```

## 📝 Notes

- The table uses `IF NOT EXISTS` so it's safe to run multiple times
- Default build types are inserted only if they don't already exist
- The sequence is created automatically if it doesn't exist

