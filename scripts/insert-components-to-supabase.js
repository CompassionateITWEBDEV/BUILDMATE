const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');

// Supabase configuration
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://sldiqjjgddegffbzjqma.supabase.co';
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNsZGlxampnZGRlZ2ZmYnpqcW1hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc1MjA1MDMsImV4cCI6MjA3MzA5NjUwM30.wir0lfBKEo0NimhsPjLmJvXexFjyQTmyHzGsE40xDmA';

const supabase = createClient(supabaseUrl, supabaseServiceKey);

// Parse SQL file and extract component data
function parseSQLFile(sqlFilePath) {
  const sqlContent = fs.readFileSync(sqlFilePath, 'utf8');
  const components = [];
  
  // Match the pattern: SELECT 'name',\n  price,\n  'json'::jsonb,\n  category_id,
  // Using a more flexible regex that handles multiline
  const pattern = /SELECT\s+['"]([^'"]+(?:''[^'"]*)*)['"],\s*\n\s*(\d+),\s*\n\s*['"]([^'"]+(?:''[^'"]*)*)['"]::jsonb,\s*\n\s*(\d+),/g;
  let match;
  
  while ((match = pattern.exec(sqlContent)) !== null) {
    try {
      let componentName = match[1].replace(/''/g, "'");
      const price = parseInt(match[2]);
      let compatInfo = match[3].replace(/''/g, "'");
      const categoryId = parseInt(match[4]);
      
      // Parse JSON compatibility info
      const compatJson = JSON.parse(compatInfo);
      
      components.push({
        component_name: componentName,
        component_price: price,
        compatibility_information: compatJson,
        category_id: categoryId,
        component_purpose: null,
        retailer_id: null
      });
    } catch (e) {
      console.warn(`⚠️  Could not parse component: ${e.message}`);
      continue;
    }
  }
  
  return components;
}

// Insert components to Supabase
async function insertComponents() {
  console.log('🚀 Starting component insertion to Supabase...\n');
  
  const sqlFile = path.join(__dirname, 'import-20-components-per-category.sql');
  
  if (!fs.existsSync(sqlFile)) {
    console.error(`❌ SQL file not found: ${sqlFile}`);
    console.error('Please run: node scripts/import-20-components-per-category.js first');
    return;
  }
  
  console.log('📖 Parsing SQL file...');
  const components = parseSQLFile(sqlFile);
  console.log(`   Found ${components.length} components to insert\n`);
  
  if (components.length === 0) {
    console.error('❌ No components found in SQL file!');
    return;
  }
  
  // Group by category for better logging
  const byCategory = {};
  components.forEach(comp => {
    const catId = comp.category_id;
    if (!byCategory[catId]) byCategory[catId] = [];
    byCategory[catId].push(comp);
  });
  
  console.log('📊 Components by category:');
  Object.entries(byCategory).forEach(([catId, comps]) => {
    console.log(`   Category ${catId}: ${comps.length} components`);
  });
  console.log('');
  
  let inserted = 0;
  let skipped = 0;
  let errors = 0;
  
  // Insert in batches of 10 to avoid overwhelming the API
  const batchSize = 10;
  for (let i = 0; i < components.length; i += batchSize) {
    const batch = components.slice(i, i + batchSize);
    
    try {
      // Check which components already exist (by name, case-insensitive)
      const batchNames = batch.map(c => c.component_name);
      const { data: existing } = await supabase
        .from('components')
        .select('component_name')
        .or(batchNames.map(name => `component_name.ilike.${name}`).join(','));
      
      const existingNames = new Set(
        (existing || []).map(c => c.component_name.toLowerCase())
      );
      
      // Filter out existing components
      const toInsert = batch.filter(c => 
        !existingNames.has(c.component_name.toLowerCase())
      );
      
      if (toInsert.length === 0) {
        skipped += batch.length;
        console.log(`   ⏭️  Batch ${Math.floor(i/batchSize) + 1}: All ${batch.length} components already exist`);
        continue;
      }
      
      // Insert new components - convert compatibility_information to JSON string for Supabase
      const toInsertFormatted = toInsert.map(comp => ({
        ...comp,
        compatibility_information: typeof comp.compatibility_information === 'object' 
          ? comp.compatibility_information 
          : JSON.parse(comp.compatibility_information)
      }));
      
      const { data, error } = await supabase
        .from('components')
        .insert(toInsertFormatted)
        .select();
      
      if (error) {
        console.error(`   ❌ Error inserting batch ${Math.floor(i/batchSize) + 1}:`, error.message);
        errors += toInsert.length;
      } else {
        inserted += data?.length || 0;
        skipped += (batch.length - (data?.length || 0));
        console.log(`   ✅ Batch ${Math.floor(i/batchSize) + 1}: Inserted ${data?.length || 0} components (${batch.length - (data?.length || 0)} skipped)`);
      }
      
      // Small delay to avoid rate limiting
      await new Promise(resolve => setTimeout(resolve, 500));
    } catch (error) {
      console.error(`   ❌ Error processing batch ${Math.floor(i/batchSize) + 1}:`, error.message);
      errors += batch.length;
    }
  }
  
  console.log('\n✅ Insertion complete!');
  console.log(`   Inserted: ${inserted}`);
  console.log(`   Skipped (already exist): ${skipped}`);
  console.log(`   Errors: ${errors}`);
  console.log(`   Total processed: ${components.length}`);
}

// Run the script
insertComponents().catch(console.error);

