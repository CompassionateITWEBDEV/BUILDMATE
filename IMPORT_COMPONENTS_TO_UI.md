# How to Add 50 Components Per Category to UI

## ✅ SQL File Ready

**File:** `scripts/import-20-components-per-category.sql`
- **Total:** 400 components (50 per category)
- **All categories:** CPU, Motherboard, RAM, Storage, GPU, PSU, Case, Cooling

## 🚀 Step-by-Step Instructions

### Step 1: Open Supabase SQL Editor

1. Go to [Supabase Dashboard](https://supabase.com/dashboard)
2. Select your project
3. Click **SQL Editor** in the left sidebar
4. Click **New Query**

### Step 2: Run the SQL File

1. Open `scripts/import-20-components-per-category.sql` in your editor
2. **Copy the ENTIRE file** (all 8,015 lines)
3. **Paste into Supabase SQL Editor**
4. Click **Run** (or press Ctrl+Enter)

### Step 3: Wait for Completion

- The query will take a few minutes to complete (400 components)
- You should see "Success" message when done
- Check for any errors in the results panel

### Step 4: Verify Import

Run this query in Supabase to verify:

```sql
SELECT 
  c.category_id,
  cc.category_name,
  COUNT(*) as component_count
FROM components c
LEFT JOIN component_categories cc ON c.category_id = cc.category_id
GROUP BY c.category_id, cc.category_name
ORDER BY c.category_id;
```

**Expected result:**
- Category 1 (CPU): 50+ components
- Category 2 (Motherboard): 50+ components
- Category 3 (RAM): 50+ components
- Category 4 (Storage): 50+ components
- Category 5 (GPU): 50+ components
- Category 6 (PSU): 50+ components
- Category 7 (Case): 50+ components
- Category 8 (Cooling): 50+ components

### Step 5: Refresh UI

1. Go to your PC Builder: `http://localhost:3000/builder`
2. **Hard refresh** the page (Ctrl+Shift+R or Cmd+Shift+R)
3. Check each category tab:
   - **Motherboard:** Should show "Showing 1-10 of 50 components"
   - **Memory (RAM):** Should show "Showing 1-10 of 50 components"
   - **Storage:** Should show "Showing 1-10 of 50 components"
   - **Graphics Card:** Should show "Showing 1-10 of 50 components"
   - **Power Supply:** Should show "Showing 1-10 of 50 components"
   - **Case:** Should show "Showing 1-10 of 50 components"
   - **Cooling:** Should show "Showing 1-10 of 50 components"

## 🔍 Troubleshooting

### Issue: Still showing only 10 components

**Check 1: Verify components in database**
```sql
SELECT COUNT(*) FROM components WHERE category_id = 2; -- Should be 50+
```

**Check 2: Check browser console**
- Open DevTools (F12)
- Look for category distribution logs
- Should see: `Category distribution (by ID): { 1: 50, 2: 50, ... }`

**Check 3: Clear browser cache**
- Hard refresh: Ctrl+Shift+R
- Or clear cache and reload

### Issue: Components not appearing in correct category

**Fix:** The category mapping was already fixed to use `category_id` directly. If still having issues:
1. Check browser console for category mapping warnings
2. Verify category_id values in database match (1-8)

### Issue: SQL file too large

If Supabase SQL Editor has issues with the large file:
1. Split into smaller files (10 components per file)
2. Or run in batches using the SQL Editor's batch feature

## ✅ Expected Result

After successful import:
- **Each category tab** shows "Showing 1-10 of 50 components"
- **Pagination works** - can navigate through 5 pages per category
- **All components have prices** - no components filtered out
- **Category mapping correct** - components appear in right tabs

## 📝 Notes

- The SQL file uses `WHERE NOT EXISTS` to prevent duplicates
- Safe to run multiple times - won't create duplicates
- All components have default prices set (not 0)
- Component names truncated to 150 characters



