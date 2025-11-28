const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');

// Supabase configuration
const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://sldiqjjgddegffbzjqma.supabase.co';
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNsZGlxampnZGRlZ2ZmYnpqcW1hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc1MjA1MDMsImV4cCI6MjA3MzA5NjUwM30.wir0lfBKEo0NimhsPjLmJvXexFjyQTmyHzGsE40xDmA';

const supabase = createClient(supabaseUrl, supabaseKey);

// Simple SQL parser - extracts INSERT statements
function parseSQLFile(sqlFilePath) {
  const sqlContent = fs.readFileSync(sqlFilePath, 'utf8');
  const components = [];
  
  // Split by INSERT INTO components blocks
  const blocks = sqlContent.split(/INSERT INTO components\s*\(/gi);
  
  for (let i = 1; i < blocks.length; i++) {
    const block = blocks[i];
    const lines = block.split('\n').map(l => l.trim()).filter(l => l);
    
    // Find SELECT statement - it might be on same line or next line
    let selectIdx = -1;
    for (let j = 0; j < lines.length; j++) {
      if (lines[j].includes('SELECT')) {
        selectIdx = j;
        break;
      }
    }
    
    if (selectIdx === -1) continue;
    
    try {
      // The SELECT line might have the first value or be empty
      // Look for the pattern: 'name', or SELECT 'name',
      let nameLine = lines[selectIdx];
      if (nameLine.includes('SELECT') && !nameLine.match(/['"]/)) {
        // SELECT is on its own line, next line has the name
        nameLine = lines[selectIdx + 1] || '';
      }
      
      const nameMatch = nameLine.match(/['"]([^'"]+(?:''[^'"]*)*)['"]/);
      if (!nameMatch) continue;
      const componentName = nameMatch[1].replace(/''/g, "'");
      
      // Find price - look for a line with just a number
      let priceLineIdx = selectIdx + 1;
      while (priceLineIdx < lines.length && !lines[priceLineIdx].match(/^\d+,?\s*$/)) {
        priceLineIdx++;
      }
      if (priceLineIdx >= lines.length) continue;
      const price = parseInt(lines[priceLineIdx].trim().replace(',', ''));
      
      // Find JSON line - look for ::jsonb
      let jsonLineIdx = priceLineIdx + 1;
      while (jsonLineIdx < lines.length && !lines[jsonLineIdx].includes('::jsonb')) {
        jsonLineIdx++;
      }
      if (jsonLineIdx >= lines.length) continue;
      const jsonLine = lines[jsonLineIdx];
      const jsonMatch = jsonLine.match(/['"]([^'"]+(?:''[^'"]*)*)['"]/);
      if (!jsonMatch) continue;
      const jsonStr = jsonMatch[1].replace(/''/g, "'");
      const compatJson = JSON.parse(jsonStr);
      
      // Find category_id - look for a line with just a number after JSON
      let categoryLineIdx = jsonLineIdx + 1;
      while (categoryLineIdx < lines.length && !lines[categoryLineIdx].match(/^\d+,?\s*$/)) {
        categoryLineIdx++;
      }
      if (categoryLineIdx >= lines.length) continue;
      const categoryId = parseInt(lines[categoryLineIdx].trim().replace(',', ''));
      
      components.push({
        component_name: componentName,
        component_price: price,
        compatibility_information: compatJson,
        category_id: categoryId,
        component_purpose: null,
        retailer_id: null
      });
    } catch (e) {
      console.warn(`⚠️  Error parsing component ${i}: ${e.message}`);
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
  
  // Insert in batches of 20 to avoid overwhelming the API
  const batchSize = 20;
  for (let i = 0; i < components.length; i += batchSize) {
    const batch = components.slice(i, i + batchSize);
    const batchNum = Math.floor(i / batchSize) + 1;
    const totalBatches = Math.ceil(components.length / batchSize);
    
    try {
      // Check which components already exist
      const batchNames = batch.map(c => c.component_name);
      const { data: existing, error: checkError } = await supabase
        .from('components')
        .select('component_name')
        .in('component_name', batchNames);
      
      if (checkError) {
        console.error(`   ❌ Error checking existing components (batch ${batchNum}):`, checkError.message);
        errors += batch.length;
        continue;
      }
      
      const existingNames = new Set(
        (existing || []).map(c => c.component_name.toLowerCase())
      );
      
      // Filter out existing components
      const toInsert = batch.filter(c => 
        !existingNames.has(c.component_name.toLowerCase())
      );
      
      if (toInsert.length === 0) {
        skipped += batch.length;
        console.log(`   ⏭️  Batch ${batchNum}/${totalBatches}: All ${batch.length} components already exist`);
        continue;
      }
      
      // Insert new components
      const { data, error } = await supabase
        .from('components')
        .insert(toInsert)
        .select();
      
      if (error) {
        console.error(`   ❌ Error inserting batch ${batchNum}/${totalBatches}:`, error.message);
        if (error.details) console.error(`      Details: ${error.details}`);
        errors += toInsert.length;
      } else {
        inserted += data?.length || 0;
        skipped += (batch.length - (data?.length || 0));
        console.log(`   ✅ Batch ${batchNum}/${totalBatches}: Inserted ${data?.length || 0} components (${batch.length - (data?.length || 0)} skipped)`);
      }
      
      // Small delay to avoid rate limiting
      await new Promise(resolve => setTimeout(resolve, 500));
    } catch (error) {
      console.error(`   ❌ Error processing batch ${batchNum}/${totalBatches}:`, error.message);
      errors += batch.length;
    }
  }
  
  console.log('\n✅ Insertion complete!');
  console.log(`   Inserted: ${inserted}`);
  console.log(`   Skipped (already exist): ${skipped}`);
  console.log(`   Errors: ${errors}`);
  console.log(`   Total processed: ${components.length}`);
  
  if (inserted > 0) {
    console.log('\n🎉 Components successfully added to Supabase!');
    console.log('   Refresh your PC Builder UI to see the new components.');
  }
}

// Run the script
insertComponents().catch(console.error);

