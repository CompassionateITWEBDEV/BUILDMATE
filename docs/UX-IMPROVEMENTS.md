# UX & Loading Improvements

This document outlines the enhanced user experience and loading features implemented in BuildMate.

## Features

### 1. Enhanced Loading System

#### Top Progress Bar
- **YouTube/GitHub-style** progress bar at the top of the page
- Appears immediately when loading starts
- Smooth animation from 0% → 100%
- Auto-completes when loading finishes

#### Smart Full-Screen Loader
- Only appears if loading takes **more than 800ms**
- Prevents flash for quick operations
- Shows:
  - Animated BuildMate logo
  - Loading message
  - Progress percentage
  - Progress bar
  - Helpful tip

#### Usage
```typescript
import { useLoading } from '@/contexts/loading-context'

function MyComponent() {
  const { startLoading, stopLoading } = useLoading()
  
  const handleAction = async () => {
    startLoading('Saving your build...')
    try {
      await saveBuild()
    } finally {
      stopLoading()
    }
  }
}
```

### 2. Skeleton Loaders

Pre-built skeleton components for better perceived performance.

#### Available Skeletons
- `<Skeleton />` - Basic skeleton
- `<SkeletonCard />` - Generic card
- `<SkeletonBuildCard />` - Build card with image
- `<SkeletonComponentCard />` - Component card
- `<SkeletonTable />` - Table skeleton
- `<SkeletonAvatar />` - Avatar skeleton
- `<SkeletonText />` - Multi-line text
- `<SkeletonButton />` - Button skeleton
- `<SkeletonBadge />` - Badge skeleton
- `<SkeletonGrid />` - Grid of skeletons

#### Usage
```typescript
import { SkeletonBuildCard, SkeletonGrid } from '@/components/ui/skeleton'

function BuildsPage() {
  const { data, isLoading } = useBuilds()
  
  if (isLoading) {
    return <SkeletonGrid count={6} type="build" />
  }
  
  return <BuildsList builds={data} />
}
```

### 3. Toast Notifications

Beautiful, accessible toast notifications using Sonner.

#### Available Toasts
- `toast.success()` - Success message
- `toast.error()` - Error message
- `toast.warning()` - Warning message
- `toast.info()` - Info message
- `toast.loading()` - Loading toast
- `toast.promise()` - Promise-based toast

#### Custom Build Toasts
- `toast.buildSaved(buildName)` - Build saved
- `toast.buildDeleted(buildName)` - Build deleted
- `toast.componentAdded(name)` - Component added
- `toast.componentRemoved(name)` - Component removed
- `toast.compatibilityIssue(message)` - Compatibility warning
- `toast.buildLiked()` - Build liked
- `toast.buildUnliked()` - Build unliked
- `toast.copyToClipboard()` - Copy confirmation

#### Usage
```typescript
import { toast } from '@/lib/toast'

// Simple success
toast.success('Build saved successfully!')

// With description
toast.error('Failed to save', 'Please check your connection and try again')

// With action
toast.buildSaved('My Gaming PC')

// Promise-based (auto handles loading/success/error)
toast.promise(
  saveBuild(),
  {
    loading: 'Saving build...',
    success: 'Build saved!',
    error: 'Failed to save build'
  }
)
```

### 4. Async Hook

Enhanced hook for handling async operations with better UX.

#### Features
- Automatic loading states
- Built-in timeout handling (default 30s)
- Success/error toasts
- Error handling
- Loading message customization

#### Usage
```typescript
import { useAsync } from '@/hooks/use-async'

function MyComponent() {
  const { execute, isLoading, data, error } = useAsync(
    saveBuild,
    {
      loadingMessage: 'Saving your build...',
      successMessage: 'Build saved successfully!',
      errorMessage: 'Failed to save build',
      showSuccessToast: true,
      showErrorToast: true,
      timeout: 30000 // 30 seconds
    }
  )
  
  return (
    <Button onClick={() => execute(buildData)} disabled={isLoading}>
      Save Build
    </Button>
  )
}
```

### 5. Optimistic UI Updates

Hook for implementing optimistic UI updates.

#### Usage
```typescript
import { useOptimistic } from '@/hooks/use-async'

function LikeButton({ initialLiked, buildId }) {
  const { data: isLiked, updateOptimistically, confirmUpdate, revertUpdate } = useOptimistic(initialLiked)
  
  const handleLike = async () => {
    // Update UI immediately
    updateOptimistically(!isLiked)
    
    try {
      // Send request to server
      const result = await likeBuild(buildId)
      // Confirm update with server response
      confirmUpdate(result.liked)
      toast.buildLiked()
    } catch (error) {
      // Revert on error
      revertUpdate()
      toast.error('Failed to like build')
    }
  }
  
  return (
    <Button onClick={handleLike}>
      {isLiked ? 'Unlike' : 'Like'}
    </Button>
  )
}
```

### 6. Debounced Loading

Prevents loading flashes for operations that complete quickly.

#### Usage
```typescript
import { useDebouncedLoading } from '@/hooks/use-async'

function SearchComponent() {
  const { showLoading, setIsLoading } = useDebouncedLoading(300) // 300ms delay
  
  const handleSearch = async (query) => {
    setIsLoading(true)
    try {
      const results = await searchBuilds(query)
      // If search completes in <300ms, loading never shows
    } finally {
      setIsLoading(false)
    }
  }
  
  return (
    <>
      {showLoading && <Loader />}
      <SearchResults />
    </>
  )
}
```

## Best Practices

### 1. Use Skeletons for Initial Load
```typescript
// ✅ Good
if (isLoading) return <SkeletonBuildCard />

// ❌ Avoid
if (isLoading) return <Spinner />
```

### 2. Use Top Progress Bar for Navigation
- Automatically handled by GlobalLoading
- Shows immediately when navigating

### 3. Use Toasts for User Actions
```typescript
// ✅ Good
const handleSave = async () => {
  try {
    await saveBuild()
    toast.success('Build saved!')
  } catch (error) {
    toast.error('Failed to save', error.message)
  }
}

// ❌ Avoid
const handleSave = async () => {
  await saveBuild()
  alert('Build saved!') // Don't use alerts
}
```

### 4. Use Optimistic Updates for Likes/Favorites
```typescript
// ✅ Good - Instant feedback
updateOptimistically(!isLiked)
await likeBuild()
confirmUpdate()

// ❌ Avoid - Slow feedback
await likeBuild()
setIsLiked(!isLiked)
```

### 5. Handle Timeouts Gracefully
```typescript
// ✅ Good
const { execute } = useAsync(fetchData, {
  timeout: 10000,
  errorMessage: 'Request timed out'
})

// ❌ Avoid
const fetchData = async () => {
  // No timeout handling
}
```

## Configuration

### Global Loading
Configure in `components/global-loading.tsx`:
- Progress animation speed
- Full-screen delay (default: 800ms)
- Colors and styling

### Toast Notifications
Configure in `app/layout.tsx`:
- Position (default: top-right)
- Duration (default: 4000ms)
- Theme and colors

### Async Timeout
Configure per hook usage:
```typescript
useAsync(fn, { timeout: 30000 }) // 30 seconds
```

## Examples

See the following components for implementation examples:
- `/app/builder/page.tsx` - Component selection with skeletons
- `/app/builds/page.tsx` - Build cards with loading states
- `/app/dashboard/page.tsx` - Optimistic updates for likes

## Performance Tips

1. **Skeleton Loaders**: Use for initial page load
2. **Debounced Loading**: Use for search/filter operations
3. **Optimistic Updates**: Use for like/favorite actions
4. **Progress Bar**: Auto-handles navigation
5. **Toast Duration**: Keep under 5 seconds for success, longer for errors

## Accessibility

All loading states are accessible:
- ✅ Screen reader announcements
- ✅ Keyboard navigation
- ✅ ARIA labels
- ✅ Focus management
- ✅ Color contrast (WCAG AA compliant)





