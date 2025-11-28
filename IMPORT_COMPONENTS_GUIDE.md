# Import 20 Components Per Category - Complete Guide

## ✅ SQL File Ready

**File:** `scripts/import-20-components-per-category.sql`

**Contents:**
- **Total:** 160 components (20 per category)
- **CPU (category_id 1):** 20 components
- **Motherboard (category_id 2):** 20 components  
- **RAM (category_id 3):** 20 components
- **Storage (category_id 4):** 20 components
- **GPU (category_id 5):** 20 components
- **PSU (category_id 6):** 20 components
- **Case (category_id 7):** 20 components
- **Cooling (category_id 8):** 20 components

**All components have:**
- ✅ Default prices set (not 0)
- ✅ Full compatibility information (JSONB)
- ✅ Component names truncated to 150 characters
- ✅ Correct category_id (1-8)

## 🚀 How to Import

### Step 1: Open Supabase SQL Editor

1. Go to [Supabase Dashboard](https://supabase.com/dashboard)
2. Select your project
3. Click **SQL Editor** in the left sidebar
4. Click **New Query**

### Step 2: Run the SQL File

1. Open `scripts/import-20-components-per-category.sql` in your editor
2. **Copy the entire file** (all 3,227 lines)
3. **Paste into Supabase SQL Editor**
4. Click **Run** (or press Ctrl+Enter)

### Step 3: Verify Import

After running, check the results:
- Should show "Success. No rows returned" or similar
- Check the **Table Editor** → **components** table
- You should see 160 new components

### Step 4: Verify in UI

1. Open your PC Builder: `http://localhost:3000/builder`
2. Check each category tab:
   - **Processors:** Should show 20+ components
   - **Motherboard:** Should show 20+ components
   - **Memory (RAM):** Should show 20+ components
   - **Storage:** Should show 20+ components
   - **Graphics Card:** Should show 20+ components
   - **Power Supply:** Should show 20+ components
   - **Case:** Should show 20+ components
   - **Cooling:** Should show 20+ components

## 🔍 Troubleshooting

### Issue: Components not showing in UI

**Check 1: Browser Console**
- Open browser DevTools (F12)
- Check Console tab
- Look for:
  - `Category distribution (by name):` - Should show all 8 categories
  - `Category distribution (by ID):` - Should show IDs 1-8
  - `Converted category distribution:` - Should show all categories

**Check 2: Database**
Run this SQL in Supabase to verify:
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

Expected output:
```
category_id | category_name | component_count
------------|---------------|-----------------
1           | CPU           | 20+
2           | Motherboard   | 20+
3           | RAM           | 20+
4           | Storage       | 20+
5           | GPU           | 20+
6           | PSU           | 20+
7           | Case          | 20+
8           | Cooling       | 20+
```

**Check 3: Category Name Mismatch**
If category names don't match, update the mapping in `lib/supabase-components.ts`:
```typescript
const categoryMap: Record<string, ComponentCategory> = {
  'cpu': 'cpu',
  'motherboard': 'motherboard',  // Make sure this matches your DB
  'ram': 'memory',
  // ... etc
}
```

### Issue: All components showing in one category

**Cause:** Category mapping failing - all defaulting to 'cpu'

**Fix:** Check browser console for warnings like:
```
⚠️ Unknown category name: "Motherboard" (lowercase: "motherboard")
```

If you see this, the category name in database doesn't match the mapping.

### Issue: Components filtered out (price = 0)

**Check:** All components should have prices > 0. If some show 0, update them:
```sql
UPDATE components 
SET component_price = 4000 
WHERE component_price = 0 AND category_id = 2;  -- Example for Motherboard
```

## 📝 Default Prices Set

- **CPU:** ₱5,000
- **Motherboard:** ₱4,000
- **RAM:** ₱2,000
- **Storage:** ₱3,000
- **GPU:** ₱15,000
- **PSU:** ₱3,000
- **Case:** ₱2,500
- **Cooling:** ₱1,500

*Note: These are default prices. Update manually with actual SRP after import.*

## ✅ Verification Checklist

After import, verify:
- [ ] SQL executed successfully in Supabase
- [ ] 160 components in database (check Table Editor)
- [ ] All 8 categories have components
- [ ] Components appear in UI for each category
- [ ] Prices are > 0 (not filtered out)
- [ ] Browser console shows correct category distribution
- [ ] CSP recommendations work with new components
- [ ] Graph-based upgrades work with new components

## 🎯 Next Steps

1. **Update Prices:** Set actual SRP prices for all components
2. **Add Images:** Upload component images to Supabase Storage
3. **Test CSP:** Try CSP recommendations with different budgets
4. **Test Graph:** Try upgrade recommendations with existing builds

## 📞 Support

If components still don't appear:
1. Check browser console for errors
2. Verify category names in database match the mapping
3. Check if components have prices > 0
4. Verify the SQL was executed completely (no errors)



