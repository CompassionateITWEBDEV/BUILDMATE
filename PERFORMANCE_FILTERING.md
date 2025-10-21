# Performance-Based Filtering Feature

## Overview
The PC Builder now includes performance-based filtering that allows users to select a performance category (Gaming, Office, Academic) to filter components based on their intended use case. This makes PC building faster and more personalized.

## Features

### Performance Categories

1. **Gaming** 🎮
   - High-performance components for gaming and entertainment
   - Requirements: 6+ CPU cores, 16GB+ RAM, 8GB+ GPU memory, 500GB+ storage, 650W+ PSU
   - Focus on high-end CPUs, powerful GPUs, and fast storage

2. **Office** 💼
   - Efficient components for productivity and business tasks
   - Requirements: 4-8 CPU cores, 8-32GB RAM, optional GPU, 250GB-1TB storage, 400-650W PSU
   - Focus on cost-effective, reliable components

3. **Academic** 🎓
   - Balanced components for research, coding, and educational work
   - Requirements: 6-16 CPU cores, 16-64GB RAM, 4-12GB GPU memory, 500GB-2TB storage, 550-850W PSU
   - Focus on multi-threaded performance and expandability

4. **All Components** 📦
   - Shows all available components without filtering
   - Default option for users who want full control

### How It Works

1. **Component Tagging**: Each component is tagged with performance categories it's suitable for
2. **Requirement Matching**: Components are filtered based on technical specifications matching the selected category's requirements
3. **Real-time Filtering**: Components are filtered in real-time as users change the performance category
4. **Visual Feedback**: Clear indicators show which performance category is active and how many components match

### Technical Implementation

- **Performance Filter**: `lib/performance-filter.ts` - Core filtering logic
- **Component Data**: Extended `lib/mock-data.ts` with performance tags and requirements
- **UI Integration**: Updated `app/builder/page.tsx` with performance category selector
- **Type Safety**: Full TypeScript support with proper type definitions

### Usage

1. Navigate to the PC Builder page
2. Select a performance category from the dropdown
3. Browse components - only those matching your selected category will be shown
4. Switch categories anytime to see different component options
5. Use "All Components" to see everything without filtering

### Benefits

- **Faster Building**: Reduces decision fatigue by showing only relevant components
- **Better Matches**: Ensures components are appropriate for the intended use case
- **Educational**: Helps users understand what components are needed for different purposes
- **Personalized**: Adapts the experience based on user's specific needs

### Future Enhancements

- Budget-based filtering within performance categories
- Custom performance requirements
- Performance category recommendations based on selected components
- Integration with build templates and guides
