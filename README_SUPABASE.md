# BUILDMATE - Supabase Integration

This document explains how to integrate your BUILDMATE application with Supabase for database functionality.

## 🚀 Quick Start

### 1. Set up Supabase Project

1. Go to [supabase.com](https://supabase.com) and create a new project
2. Wait for the project to be ready (usually 2-3 minutes)

### 2. Run Database Migration

1. In your Supabase dashboard, go to **SQL Editor**
2. Copy the contents of `supabase-migration.sql`
3. Paste and run the SQL script
4. This creates all tables, relationships, and security policies

### 3. Configure Environment Variables

Create a `.env.local` file in your project root:

```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_project_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key
```

You can find these values in your Supabase dashboard under **Settings > API**.

### 4. Seed the Database (Optional)

Run the seeder script to populate your database with sample data:

```bash
pnpm seed
```

This will create sample components, retailers, and categories.

## 📊 Database Schema

The database includes these main tables:

- **users** - User accounts and profiles
- **builds** - PC builds created by users
- **components** - PC components (CPU, GPU, etc.)
- **component_categories** - Categories for components
- **retailers** - Component retailers
- **build_components** - Many-to-many relationship between builds and components
- **build_types** - Types of builds (Gaming, Office, etc.)
- **build_history** - Change history for builds
- **comments** - Comments on build changes

## 🔧 Usage

### Basic Database Operations

```typescript
import { componentService, buildService, userService } from '@/lib/database'

// Get all components
const components = await componentService.getAll()

// Create a new build
const build = await buildService.create({
  user_id: 1,
  build_type_id: 1,
  build_name: 'My Gaming PC'
})

// Add component to build
await buildComponentService.addComponent(buildId, componentId)
```

### Using Supabase Components

```typescript
import { getSupabaseComponents } from '@/lib/supabase-components'

// Get components in app format
const components = await getSupabaseComponents()
```

### Authentication

```typescript
import { useSupabaseAuth } from '@/contexts/supabase-auth-context'

function MyComponent() {
  const { user, login, register, logout } = useSupabaseAuth()
  
  // Use authentication methods
}
```

## 🔒 Security

The database uses Row Level Security (RLS) to ensure:

- Users can only access their own builds
- Public read access to components and categories
- Secure authentication through Supabase Auth

## 🛠️ Development

### Adding New Components

1. Use the Supabase dashboard to add components directly
2. Or use the API:

```typescript
await componentService.create({
  component_name: 'New Component',
  component_price: 299.99,
  compatibility_information: 'Compatibility info',
  category_id: 1,
  retailer_id: 1
})
```

### Custom Queries

You can write custom queries using the Supabase client:

```typescript
import { supabase } from '@/lib/supabase'

const { data, error } = await supabase
  .from('components')
  .select('*')
  .eq('category_id', 1)
  .order('component_price', { ascending: true })
```

## 📝 Migration from Mock Data

To migrate from mock data to Supabase:

1. Set up Supabase as described above
2. Replace mock data imports with Supabase functions
3. Update components to use async data fetching
4. Test all functionality

### Example Migration

**Before (Mock Data):**
```typescript
import { mockComponents } from '@/lib/mock-data'
const components = mockComponents
```

**After (Supabase):**
```typescript
import { getSupabaseComponents } from '@/lib/supabase-components'
const components = await getSupabaseComponents()
```

## 🐛 Troubleshooting

### Common Issues

1. **Connection Error**: Check your environment variables
2. **Permission Denied**: Ensure RLS policies are set up correctly
3. **Missing Data**: Run the seeder script or check your data

### Debugging

Enable Supabase logging:

```typescript
const supabase = createClient(url, key, {
  auth: {
    debug: true
  }
})
```

## 📚 Resources

- [Supabase Documentation](https://supabase.com/docs)
- [Next.js with Supabase](https://supabase.com/docs/guides/getting-started/quickstarts/nextjs)
- [Row Level Security](https://supabase.com/docs/guides/auth/row-level-security)

## 🤝 Contributing

When adding new features:

1. Update the database schema if needed
2. Add corresponding TypeScript types
3. Create service functions for new operations
4. Update the migration script
5. Test with the seeder script




























