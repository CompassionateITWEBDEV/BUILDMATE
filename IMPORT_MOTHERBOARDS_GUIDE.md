# Import Motherboards from BuildCores OpenDB

This guide explains how to import at least 20 motherboards from [BuildCores OpenDB](https://github.com/buildcores/buildcores-open-db) with full compatibility information for CSP and compatibility checking.

## Method 1: Using Python Script (Recommended)

1. **Install required library** (if not already installed):
   ```bash
   pip install requests
   ```

2. **Run the import script**:
   ```bash
   python scripts/import_motherboards_buildcores.py
   ```

3. **This will generate**: `scripts/import-motherboards-buildcores.sql`

4. **Run the SQL in Supabase**:
   - Open Supabase Dashboard → SQL Editor
   - Copy and paste the contents of the generated SQL file
   - Execute the SQL

5. **Update prices manually** after import (all prices are set to 0 initially)

## Method 2: Manual Import via GitHub

1. **Visit**: https://github.com/buildcores/buildcores-open-db/tree/main/open-db/Motherboard

2. **Download JSON files** for at least 20 motherboards

3. **Convert each JSON** using the format in `add-asus-b760-motherboard-direct.sql` as a template

4. **Run SQL inserts** in Supabase SQL Editor

## Compatibility Information Included

Each imported motherboard includes:

- **Socket**: For CPU compatibility checking
- **Form Factor**: For case compatibility
- **Memory Type**: DDR4/DDR5 for RAM compatibility
- **Memory Slots**: Number of RAM slots
- **M.2 Slots**: For storage compatibility
- **SATA Ports**: For storage compatibility
- **PCIe Slots**: For GPU compatibility
- **Chipset**: For performance categorization
- **WiFi**: Boolean flag
- **RAID Support**: Boolean flag

## CSP Algorithm Compatibility

All imported motherboards work with:
- ✅ Compatibility checking (socket, form factor, memory type matching)
- ✅ CSP algorithm (all constraints included in compatibility_information)
- ✅ Performance category filtering (gaming, academic, office)

## Notes

- Prices need to be updated manually after import
- Performance categories are auto-assigned based on chipset:
  - Z/X series chipsets → Gaming
  - B/H series chipsets → Office
  - Others → Academic
- All motherboards are set to 'in_stock' by default

