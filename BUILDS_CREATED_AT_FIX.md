# Builds Table - created_at Fix

## ✅ Issue Fixed

**Error**: `column builds.created_at does not exist`

**Cause**: The `builds` table uses `date_created` as the column name, not `created_at`

## 🔧 Changes Made

### 1. Fixed Code References

**File: `app/api/purchase/send-email/route.ts`**
- Changed query: `created_at` → `date_created`
- Changed display: `buildData.created_at` → `buildData.date_created`

**File: `app/purchase/[id]/page.tsx`**
- Changed interface: `created_at: string` → `date_created: string`
- Changed query: `created_at` → `date_created`

### 2. Created SQL Script

**File: `create-build-history-table.sql`**
- Creates the `build_history` table
- Sets up foreign key relationship with `builds` table
- Configures CASCADE delete
- Sets up RLS policies

## 📊 Table Structures

### Builds Table
```sql
builds
├── build_id (serial, primary key)
├── user_id (integer, FK to users)
├── build_type_id (integer, FK to build_types)
├── build_name (varchar, not null)
└── date_created (timestamp, default now()) ← Note: 'date_created' not 'created_at'
```

### Build History Table
```sql
build_history
├── bhistory_id (serial, primary key)
├── build_id (integer, FK to builds, CASCADE delete)
├── change_description (text, nullable)
└── changed_at (timestamp with time zone, default now())
```

## 📋 Next Steps

1. **Run SQL Script in Supabase**:
   - Go to Supabase Dashboard → SQL Editor
   - Copy contents of `create-build-history-table.sql`
   - Run the script

2. **Verify**:
   - Check that `build_history` table exists
   - Verify `builds` table uses `date_created` (not `created_at`)

## ✅ All Fixed

All references to `builds.created_at` have been changed to `date_created` to match the database schema.

## 📝 Note

Other tables use `created_at` correctly:
- `users.created_at` ✅
- `build_comments.created_at` ✅
- `followers.created_at` ✅

Only the `builds` table uses `date_created`.

