# CSP Diversity Improvements

## Problem
CSP solutions were **redundant** - same components appearing repeatedly in different solutions.

Example (BAD):
- Solution 1: CPU A, GPU A, RAM A
- Solution 2: CPU A, GPU A, RAM B
- Solution 3: CPU A, GPU A, RAM C
- (GPU A and CPU A repeating too much!)

## Solution Implemented

### 1. **Component Usage Limiting**
Each component can only appear a **limited number of times**:
- **First 20 solutions**: Max 2 times per component
- **After 20 solutions**: Max 5 times per component

This ensures variety across solutions!

### 2. **Diverse Price Range Selection**
Instead of always trying cheap first, we now **mix price ranges**:
- **30% from cheap range** (budget-friendly)
- **40% from mid range** (balanced)
- **30% from expensive range** (high-end)

Then **interleave them**: mid → cheap → expensive → mid → cheap...

### 3. **Randomization within Groups**
Each price group is shuffled for extra variety.

## Result

### Before:
```
Solution 1: Intel i7-13700K, RTX 4060, Corsair 16GB, Samsung 1TB
Solution 2: Intel i7-13700K, RTX 4060, G.Skill 16GB, WD 1TB
Solution 3: Intel i7-13700K, RTX 4060, Kingston 16GB, Crucial 1TB
```
❌ i7-13700K and RTX 4060 repeating in all solutions!

### After:
```
Solution 1: Intel i7-13700K, RTX 4060, Corsair 16GB, Samsung 1TB
Solution 2: AMD Ryzen 7 7700X, RX 7800 XT, G.Skill 32GB, WD 2TB
Solution 3: Intel i5-13600K, RTX 4070, Kingston 16GB, Crucial 2TB
```
✅ Mixed CPUs, GPUs, RAM brands, storage options!

## How It Works

1. **During Backtracking**:
   - Components are selected from mixed price ranges
   - Creates variety in initial combinations

2. **During Solution Generation**:
   - Tracks how many times each component is used
   - Skips solutions with overused components
   - Yields diverse solutions

## Benefits

✅ **More Variety**: Different brands, models, price points
✅ **Better User Experience**: Users see real alternatives
✅ **Still Budget-Aware**: Respects budget allocation per category
✅ **Still Compatible**: All compatibility checks still apply

## Testing

Try CSP with ₱30,000 gaming budget:
- Should see different CPUs: Intel i7, Ryzen 7, i5, Ryzen 5
- Should see different GPUs: RTX 4060, 4070, RX 7800 XT
- Should see different RAM: Corsair, G.Skill, Kingston
- NOT just one CPU/GPU repeated 10 times!

## Files Modified

- `Algorithm/csp/csp_recommender.py`
  - Added diversity tracking in `solve()` method
  - Added price range mixing in `backtrack()` method







