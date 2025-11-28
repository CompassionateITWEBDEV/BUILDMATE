# Add 10 Components with SRP Prices - Guide

This guide explains how to add 10 pre-configured components with realistic SRP (Suggested Retail Price) prices and full compatibility information for CSP recommendations and graph-based upgrade algorithms.

## Components Included

1. **Intel Core i5-12400F** - ₱8,995 (CPU)
2. **NVIDIA GeForce RTX 4060 8GB** - ₱24,995 (GPU)
3. **MSI B660M PRO-VDH DDR4** - ₱6,995 (Motherboard)
4. **Corsair Vengeance LPX 16GB DDR4** - ₱3,495 (RAM)
5. **Samsung 980 500GB NVMe SSD** - ₱3,295 (Storage)
6. **Corsair CV650 650W PSU** - ₱3,995 (Power Supply)
7. **NZXT H510 Flow Case** - ₱5,495 (Case)
8. **Cooler Master Hyper 212 RGB** - ₱2,295 (CPU Cooler)
9. **AMD Radeon RX 6600 8GB** - ₱18,995 (GPU - Alternative)
10. **G.Skill Ripjaws V 32GB DDR4** - ₱6,995 (RAM - High-end)

**Total Value: ₱85,545**

## Prerequisites

1. Ensure you have access to your Supabase database
2. Make sure the `component_categories` table has the following categories:
   - CPU (category_id: 1)
   - Motherboard (category_id: 2)
   - RAM (category_id: 3)
   - Storage (category_id: 4)
   - GPU (category_id: 5)
   - PSU (category_id: 6)
   - Case (category_id: 7)
   - Cooling (category_id: 8)

## Installation Steps

### Step 1: Add component_purpose Column (if needed)

If the `component_purpose` column doesn't exist in your `components` table, run this first:

```sql
-- Run: add-component-purpose-column.sql
```

This will add the column if it doesn't exist. The column is used for performance category filtering (gaming, academic, office).

### Step 2: Add the 10 Components

Run the main SQL script in your Supabase SQL Editor:

```sql
-- Run: add-10-components-srp.sql
```

This script will:
- Insert 10 components with realistic SRP prices
- Include full compatibility information in JSON format
- Set all components to `gaming` performance category
- Set availability status to `in_stock`
- Skip components that already exist (safe to run multiple times)

## Compatibility Information

Each component includes comprehensive compatibility data:

### CPU
- Socket type (LGA1700)
- TDP (65W)
- Memory type support (DDR4)
- Core/thread count
- Clock speeds

### GPU
- VRAM amount
- Memory type
- TDP/power requirement
- Physical dimensions (length, height, width)
- PCIe version

### Motherboard
- Socket type
- Form factor
- Chipset
- RAM type and slots
- PCIe slots
- M.2 slots
- SATA ports

### RAM
- Memory type (DDR4)
- Capacity
- Speed (MHz)
- CAS latency
- Voltage

### Storage
- Capacity
- Interface (PCIe 3.0/4.0)
- Form factor (M.2)
- Read/write speeds

### PSU
- Wattage
- Efficiency rating
- Modular type
- Connector counts

### Case
- Form factor
- Motherboard support
- Max GPU length
- Max cooler height
- Fan/radiator support

### CPU Cooler
- Supported sockets
- Height
- TDP rating
- Fan size

## CSP Algorithm Integration

These components are fully compatible with the CSP (Constraint Satisfaction Problem) recommendation algorithm. The compatibility information includes:

- **Socket matching**: CPU ↔ Motherboard ↔ Cooler
- **RAM type matching**: RAM ↔ Motherboard
- **Power requirements**: PSU wattage vs. total system TDP
- **Physical dimensions**: GPU ↔ Case, Cooler ↔ Case

## Graph Algorithm Integration

The components also work with the graph-based upgrade recommendation algorithm, which uses:
- Component relationships
- Performance metrics
- Price points
- Compatibility constraints

## Verification

After running the scripts, verify the components were added:

```sql
SELECT 
  component_name,
  component_price,
  category_id,
  component_purpose,
  availability_status
FROM components
WHERE component_name IN (
  'Intel Core i5-12400F 6-Core 12-Thread Processor',
  'NVIDIA GeForce RTX 4060 8GB GDDR6',
  'MSI B660M PRO-VDH DDR4 Micro ATX',
  'Corsair Vengeance LPX 16GB (2x8GB) DDR4 3200MHz',
  'Samsung 980 500GB NVMe PCIe 3.0 M.2 SSD',
  'Corsair CV650 650W 80+ Bronze Certified PSU',
  'NZXT H510 Flow Mid Tower ATX Case',
  'Cooler Master Hyper 212 RGB CPU Air Cooler',
  'AMD Radeon RX 6600 8GB GDDR6',
  'G.Skill Ripjaws V 32GB (2x16GB) DDR4 3600MHz'
)
ORDER BY component_price DESC;
```

## Notes

- All prices are in PHP (Philippine Peso) based on realistic SRP
- Components are set to `gaming` performance category by default
- All components are marked as `in_stock`
- The script uses `WHERE NOT EXISTS` to prevent duplicates
- Compatibility information is stored as JSON text for flexibility

## Troubleshooting

### Error: column "component_purpose" does not exist
**Solution**: Run `add-component-purpose-column.sql` first

### Error: foreign key constraint fails
**Solution**: Ensure all category IDs exist in `component_categories` table

### Components not appearing in CSP recommendations
**Solution**: 
1. Check that compatibility information is properly formatted JSON
2. Verify category IDs match the expected values
3. Ensure `component_purpose` is set correctly for filtering

## Next Steps

After adding these components:
1. Test CSP recommendations with various budgets
2. Verify compatibility checking works correctly
3. Test graph-based upgrade recommendations
4. Add more components as needed using the same format



