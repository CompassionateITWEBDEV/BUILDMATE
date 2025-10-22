# Supabase Database Setup

This guide will help you set up the Supabase database for the BUILDMATE application.

## Prerequisites

1. A Supabase account (sign up at [supabase.com](https://supabase.com))
2. A new Supabase project created

## Setup Steps

### 1. Create a Supabase Project

1. Go to [supabase.com](https://supabase.com) and sign in
2. Click "New Project"
3. Choose your organization
4. Enter project details:
   - Name: `BUILDMATE-1f`
   - Database Password: (choose a strong password)
   - Region: (choose closest to your users)
5. Click "Create new project"

### 2. Run Database Migration

1. In your Supabase dashboard, go to the "SQL Editor"
2. Copy the contents of `supabase-migration.sql`
3. Paste it into the SQL editor
4. Click "Run" to execute the migration

This will create:
- All necessary tables
- Sequences for auto-incrementing IDs
- Foreign key relationships
- Row Level Security (RLS) policies
- Initial data for categories and build types

### 3. Configure Environment Variables

1. In your Supabase dashboard, go to "Settings" > "API"
2. Copy the following values:
   - Project URL
   - Anon (public) key
   - Service role key (keep this secret!)

3. Create a `.env.local` file in your project root:

```env
# Supabase Configuration
NEXT_PUBLIC_SUPABASE_URL=your_project_url_here
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_anon_key_here
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key_here
```

### 4. Enable Authentication (Optional)

If you want to use Supabase Auth:

1. Go to "Authentication" > "Settings" in your Supabase dashboard
2. Configure your preferred authentication providers
3. Set up email templates if needed

### 5. Test the Connection

Run the development server to test the connection:

```bash
pnpm dev
```

## Database Schema

The database includes the following tables:

- **users**: User accounts and profiles
- **build_types**: Types of builds (Gaming, Office, etc.)
- **component_categories**: Component categories (CPU, GPU, etc.)
- **retailers**: Component retailers and suppliers
- **components**: Individual PC components
- **builds**: User-created PC builds
- **build_components**: Many-to-many relationship between builds and components
- **build_history**: Change history for builds
- **comments**: Comments on build changes

## Security

The database uses Row Level Security (RLS) to ensure:
- Users can only access their own builds and data
- Public read access to components and categories
- Secure authentication and authorization

## API Usage

The database service functions are available in `lib/database.ts`:

```typescript
import { userService, buildService, componentService } from '@/lib/database'

// Get all components
const components = await componentService.getAll()

// Create a new build
const build = await buildService.create({
  user_id: userId,
  build_type_id: 1,
  build_name: 'My Gaming PC'
})

// Add component to build
await buildComponentService.addComponent(buildId, componentId)
```

## Troubleshooting

### Common Issues

1. **Connection Error**: Check your environment variables
2. **Permission Denied**: Ensure RLS policies are correctly set up
3. **Missing Tables**: Re-run the migration script

### Getting Help

- Check the [Supabase Documentation](https://supabase.com/docs)
- Review the migration script for any errors
- Check the Supabase logs in the dashboard

