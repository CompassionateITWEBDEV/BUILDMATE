# BuildCores OpenDB Component Importer

This script imports components from the [BuildCores OpenDB repository](https://github.com/buildcores/buildcores-open-db) into your Supabase database.

## Features

- Imports at least 50 components per category:
  - Motherboard
  - RAM (Memory)
  - Storage
  - GPU (Graphics Card)
  - PSU (Power Supply)
  - Case
  - Cooling

- Converts BuildCores format to Supabase format
- Generates SQL insert statements
- Handles rate limiting

## Usage

### Option 1: Run the Node.js Script

```bash
node scripts/import-buildcores-components.js
```

This will:
1. Fetch component data from BuildCores OpenDB GitHub repository
2. Convert to Supabase format
3. Generate SQL file: `scripts/import-buildcores-components.sql`

### Option 2: Use the Generated SQL

After running the script, execute the generated SQL file in Supabase SQL Editor:

1. Open Supabase Dashboard
2. Go to SQL Editor
3. Copy and paste the contents of `scripts/import-buildcores-components.sql`
4. Run the SQL

### Option 3: Manual Import via Admin Page

You can also manually add components through the Admin page in the app.

## Notes

- **Prices**: Component prices are set to 0 by default. You'll need to update them manually.
- **Performance Category**: Components are imported without a performance category. You can set them to 'gaming', 'academic', or 'office' as needed.
- **Rate Limiting**: The script includes delays to avoid GitHub API rate limits.

## Component Data Structure

The script converts BuildCores format to Supabase format:

- **Component Name**: From `metadata.name`
- **Compatibility Information**: Extracted from various fields (socket, form factor, memory type, etc.)
- **Category**: Mapped from BuildCores category to Supabase category

## Troubleshooting

- If you get rate limit errors, wait a few minutes and try again
- Make sure you have internet connection to fetch from GitHub
- Verify that the component categories exist in your database

