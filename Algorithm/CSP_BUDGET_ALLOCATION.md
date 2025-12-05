# Improved CSP Budget Allocation

## What Changed?

The CSP algorithm now **smartly distributes the budget** based on the performance category (academic/office/gaming).

## Budget Distribution

### Academic Build (₱20,000 example):
- **CPU**: ₱5,000 (25%) - Most important
- **Motherboard**: ₱3,000 (15%)
- **RAM**: ₱3,000 (15%)
- **Storage**: ₱3,000 (15%)
- **GPU**: ₱2,000 (10%) - Basic only
- **PSU**: ₱2,000 (10%)
- **Case**: ₱1,000 (5%)
- **Cooler**: ₱1,000 (5%)

### Office Build (₱30,000 example):
- **CPU**: ₱7,500 (25%)
- **RAM**: ₱5,400 (18%) - More for multitasking
- **Storage**: ₱5,100 (17%) - SSD for speed
- **Motherboard**: ₱4,500 (15%)
- **PSU**: ₱3,000 (10%)
- **GPU**: ₱2,400 (8%) - Integrated OK
- **Case**: ₱1,500 (5%)
- **Cooler**: ₱600 (2%)

### Gaming Build (₱50,000 example):
- **GPU**: ₱17,500 (35%) - MOST IMPORTANT! 🎮
- **CPU**: ₱10,000 (20%)
- **Motherboard**: ₱6,000 (12%)
- **RAM**: ₱6,000 (12%)
- **Storage**: ₱4,000 (8%)
- **PSU**: ₱4,000 (8%)
- **Case**: ₱1,500 (3%)
- **Cooler**: ₱1,000 (2%)

## How It Works

1. **Flexible Ranges**: Each category allows 50% below to 200% above the target
   - Example: Gaming GPU (35% of ₱50K = ₱17,500)
     - Min: ₱8,750
     - Max: ₱35,000

2. **Smart Filtering**:
   - ✅ Skips components too expensive for their category
   - ✅ Prevents unbalanced builds (e.g., ₱35K CPU + ₱2K GPU for gaming)
   - ✅ Ensures realistic distribution

3. **Priority Order**:
   - Tries cheaper components first (more solutions possible)
   - Checks compatibility
   - Validates budget constraints

## Benefits

- ❌ **Before**: Could suggest ₱28K CPU with ₱2K GPU for gaming (bad!)
- ✅ **After**: Suggests ₱10K CPU with ₱17K GPU for gaming (balanced!)

## Testing

Try these scenarios:
1. **Gaming ₱30K**: Should prioritize GPU (₱10-15K range)
2. **Office ₱25K**: Should prioritize CPU & RAM
3. **Academic ₱15K**: Should balance all components

## Files Modified

1. `Algorithm/csp/csp_recommender.py` - Added budget allocation logic
2. `Algorithm/python-backend/api.py` - Pass performance_category to solver






