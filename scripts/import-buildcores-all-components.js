/**
 * Import components from BuildCores OpenDB repository
 * Fetches at least 20 components from each category
 * 
 * Usage: node scripts/import-buildcores-all-components.js
 */

const https = require('https');
const fs = require('fs');
const path = require('path');

// Configuration
const BUILDORES_REPO = 'buildcores/buildcores-open-db';
const BUILDORES_BASE_URL = `https://api.github.com/repos/${BUILDORES_REPO}/contents/open-db`;
const MIN_COMPONENTS_PER_CATEGORY = 20; // At least 20 components per category

// Category mapping: BuildCores category name -> App category name -> category_id
const CATEGORIES = {
  'CPU': { appCategory: 'CPU', categoryId: 1 },
  'Motherboard': { appCategory: 'Motherboard', categoryId: 2 },
  'RAM': { appCategory: 'RAM', categoryId: 3 },
  'Storage': { appCategory: 'Storage', categoryId: 4 },
  'GPU': { appCategory: 'GPU', categoryId: 5 },
  'PSU': { appCategory: 'PSU', categoryId: 6 },
  'PCCase': { appCategory: 'Case', categoryId: 7 },
  'CPUCooler': { appCategory: 'Cooling', categoryId: 8 }
};

// Helper function to make GitHub API request
function githubRequest(url) {
  return new Promise((resolve, reject) => {
    https.get(url, {
      headers: {
        'User-Agent': 'BuildMate-Component-Importer',
        'Accept': 'application/vnd.github.v3+json'
      }
    }, (res) => {
      let data = '';
      res.on('data', (chunk) => data += chunk);
      res.on('end', () => {
        try {
          resolve(JSON.parse(data));
        } catch (e) {
          reject(e);
        }
      });
    }).on('error', reject);
  });
}

// Fetch all files in a directory from GitHub
async function fetchCategoryFiles(category) {
  try {
    const url = `${BUILDORES_BASE_URL}/${category}`;
    const response = await githubRequest(url);
    
    // Check if response is an array
    if (!Array.isArray(response)) {
      console.error(`   ⚠️  Unexpected response format for ${category}:`, typeof response);
      if (response.message) {
        console.error(`   Error message: ${response.message}`);
      }
      return [];
    }
    
    // Filter for JSON files only
    const jsonFiles = response.filter(file => 
      file.type === 'file' && file.name.endsWith('.json')
    );
    
    return jsonFiles;
  } catch (error) {
    console.error(`Error fetching ${category} files:`, error.message);
    return [];
  }
}

// Fetch and parse a component JSON file
async function fetchComponentFile(downloadUrl) {
  try {
    return new Promise((resolve, reject) => {
      https.get(downloadUrl, {
        headers: {
          'User-Agent': 'BuildMate-Component-Importer',
          'Accept': 'application/vnd.github.v3.raw'
        }
      }, (res) => {
        let data = '';
        res.on('data', (chunk) => data += chunk);
        res.on('end', () => {
          try {
            const component = JSON.parse(data);
            resolve(component);
          } catch (e) {
            reject(e);
          }
        });
      }).on('error', reject);
    });
  } catch (error) {
    console.error(`Error fetching component:`, error.message);
    return null;
  }
}

// Convert BuildCores component to Supabase format
function convertToSupabaseFormat(component, category, dbCategoryId) {
  const compatInfo = {};

  // Common fields
  compatInfo.manufacturer = component.metadata?.manufacturer || null;
  
  // Category-specific compatibility info
  if (category === 'CPU') {
    compatInfo.socket = component.socket || null;
    compatInfo.cpuSocket = component.socket || null;
    compatInfo.tdp = component.tdp || null;
    compatInfo.tdpRating = component.tdp ? `${component.tdp}W` : null;
    compatInfo.cores = component.cores || null;
    compatInfo.threads = component.threads || null;
    compatInfo.baseClock = component.base_clock || null;
    compatInfo.boostClock = component.boost_clock || null;
    compatInfo.memoryType = component.memory_type || 'DDR4';
    compatInfo.ramType = component.memory_type || 'DDR4';
  } else if (category === 'Motherboard') {
    compatInfo.socket = component.socket || null;
    compatInfo.cpuSocket = component.socket || null;
    compatInfo.formFactor = component.form_factor || null;
    compatInfo.chipset = component.chipset || null;
    compatInfo.memory = component.memory || {};
    compatInfo.memoryType = component.memory?.ram_type || 'DDR4';
    compatInfo.ram_type = component.memory?.ram_type || 'DDR4';
    compatInfo.memorySupport = component.memory?.ram_type || 'DDR4';
    compatInfo.m2Slots = component.m2_slots?.length?.toString() || '0';
    compatInfo.sataPorts = (component.storage_devices?.sata_6_gb_s || 0).toString();
    compatInfo.pcieSlots = component.pcie_slots || [];
    compatInfo.wifi = component.metadata?.name?.toLowerCase().includes('wifi') || false;
  } else if (category === 'RAM') {
    compatInfo.memoryType = component.speed?.includes('DDR4') ? 'DDR4' : 
                           component.speed?.includes('DDR5') ? 'DDR5' : 'DDR4';
    compatInfo.ram_type = compatInfo.memoryType;
    compatInfo.capacity = component.capacity || null;
    compatInfo.speed = component.speed || null;
    compatInfo.speedMhz = component.speed || null;
    compatInfo.modules = component.modules || null;
    compatInfo.casLatency = component.cas_latency || null;
  } else if (category === 'Storage') {
    compatInfo.interface = component.interface || null;
    compatInfo.capacity = component.capacity || null;
    compatInfo.capacityGB = component.capacity ? `${component.capacity}GB` : null;
    compatInfo.formFactor = component.form_factor || component.formFactor || null;
    compatInfo.readSpeed = component.read_speed || null;
    compatInfo.writeSpeed = component.write_speed || null;
  } else if (category === 'GPU') {
    compatInfo.memory = component.memory || null;
    compatInfo.vram = component.memory || null;
    compatInfo.memoryType = component.memory_type || 'GDDR6';
    compatInfo.powerRequirement = component.tdp || component.power_consumption || null;
    compatInfo.tdp = component.tdp || null;
    compatInfo.tdpRating = component.tdp ? `${component.tdp}W` : null;
    compatInfo.length = component.length || null;
    compatInfo.width = component.width || null;
    compatInfo.height = component.height || null;
    compatInfo.dimensions = component.length ? {
      length: component.length,
      width: component.width || null,
      height: component.height || null
    } : null;
    compatInfo.pcieVersion = component.pcie_version || '4.0';
  } else if (category === 'PSU') {
    compatInfo.wattage = component.wattage || null;
    compatInfo.powerRequirement = component.wattage || null;
    compatInfo.efficiency = component.efficiency || null;
    compatInfo.efficiencyRating = component.efficiency || null;
    compatInfo.modular = component.modular || null;
    compatInfo.modularType = component.modular ? 'Fully Modular' : 'Non-Modular';
  } else if (category === 'PCCase') {
    compatInfo.formFactor = component.form_factor || component.formFactor || null;
    compatInfo.maxGpuLength = component.max_gpu_length || null;
    compatInfo.max_gpu_length = component.max_gpu_length || null;
    compatInfo.maxCoolerHeight = component.max_cooler_height || null;
    compatInfo.max_cooler_height = component.max_cooler_height || null;
    compatInfo.motherboardSupport = component.motherboard_support || ['ATX', 'Micro-ATX', 'Mini-ITX'];
  } else if (category === 'CPUCooler') {
    compatInfo.supported_sockets = component.supported_sockets || component.socket || [];
    compatInfo.supportedSockets = compatInfo.supported_sockets;
    compatInfo.sockets = compatInfo.supported_sockets;
    compatInfo.tdp = component.tdp || null;
    compatInfo.tdpRating = component.tdp ? `${component.tdp}W` : null;
    compatInfo.height = component.height || null;
    compatInfo.type = component.type || 'Air Cooler';
    compatInfo.coolerType = compatInfo.type;
  }

  const componentName = component.metadata?.name || component.name || 'Unknown Component';
  
  return {
    component_name: componentName,
    component_brand: component.metadata?.manufacturer || null,
    component_price: 0, // Price needs to be set manually
    component_description: component.metadata?.description || null,
    compatibility_information: JSON.stringify(compatInfo),
    category_id: dbCategoryId,
    component_purpose: null, // Can be set to 'gaming', 'academic', 'office'
    availability_status: 'in_stock'
  };
}

// Main import function
async function importComponents() {
  console.log('🚀 Starting BuildCores component import...\n');
  console.log(`📋 Target: At least ${MIN_COMPONENTS_PER_CATEGORY} components per category\n`);

  const sqlStatements = [];
  let totalImported = 0;
  const categoryStats = {};

  for (const [buildcoresCategory, categoryInfo] of Object.entries(CATEGORIES)) {
    console.log(`📦 Fetching ${categoryInfo.appCategory} (${buildcoresCategory}) components...`);
    
    const files = await fetchCategoryFiles(buildcoresCategory);
    console.log(`   Found ${files.length} ${buildcoresCategory} files`);

    // Take at least MIN_COMPONENTS_PER_CATEGORY, or all if less
    const filesToProcess = files.slice(0, Math.max(MIN_COMPONENTS_PER_CATEGORY, files.length));
    console.log(`   Processing ${filesToProcess.length} files...`);

    let imported = 0;
    let skipped = 0;

    for (const file of filesToProcess) {
      try {
        const component = await fetchComponentFile(file.download_url);
        if (!component) {
          skipped++;
          continue;
        }

        // Generate SQL insert statement
        const supabaseFormat = convertToSupabaseFormat(
          component, 
          buildcoresCategory, 
          categoryInfo.categoryId
        );
        
        // Escape single quotes in component name and description
        const escapedName = supabaseFormat.component_name.replace(/'/g, "''");
        const escapedDesc = supabaseFormat.component_description 
          ? supabaseFormat.component_description.replace(/'/g, "''") 
          : null;
        const escapedCompat = supabaseFormat.compatibility_information.replace(/'/g, "''");
        const escapedBrand = supabaseFormat.component_brand 
          ? supabaseFormat.component_brand.replace(/'/g, "''") 
          : null;

        const sql = `INSERT INTO components (
  component_name,
  component_brand,
  component_price,
  component_description,
  compatibility_information,
  category_id,
  component_purpose,
  availability_status
)
SELECT 
  '${escapedName}',
  ${escapedBrand ? `'${escapedBrand}'` : 'NULL'},
  ${supabaseFormat.component_price},
  ${escapedDesc ? `'${escapedDesc}'` : 'NULL'},
  '${escapedCompat}',
  ${categoryInfo.categoryId},
  ${supabaseFormat.component_purpose ? `'${supabaseFormat.component_purpose}'` : 'NULL'},
  '${supabaseFormat.availability_status}'
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('${escapedName}')
);`;

        sqlStatements.push(sql);
        imported++;
        totalImported++;

        // Add delay to avoid rate limiting (GitHub allows 60 requests/hour for unauthenticated)
        await new Promise(resolve => setTimeout(resolve, 200));
      } catch (error) {
        console.error(`   ⚠️  Error processing ${file.name}:`, error.message);
        skipped++;
      }
    }

    categoryStats[categoryInfo.appCategory] = { imported, skipped, total: files.length };
    console.log(`   ✅ Imported ${imported} ${categoryInfo.appCategory} components (${skipped} skipped)\n`);
  }

  // Write SQL file
  const sqlFile = path.join(__dirname, 'import-buildcores-all-components.sql');
  const sqlContent = `-- Import components from BuildCores OpenDB
-- Generated: ${new Date().toISOString()}
-- Total components: ${totalImported}
-- Categories: ${Object.keys(CATEGORIES).join(', ')}

${sqlStatements.join('\n\n')}

-- Summary:
${Object.entries(categoryStats).map(([cat, stats]) => 
  `-- ${cat}: ${stats.imported} imported, ${stats.skipped} skipped, ${stats.total} available`
).join('\n')}
`;

  fs.writeFileSync(sqlFile, sqlContent, 'utf8');
  
  console.log(`\n✅ Import complete!`);
  console.log(`   Total components: ${totalImported}`);
  console.log(`   SQL file generated: ${sqlFile}`);
  console.log(`\n📊 Category Summary:`);
  Object.entries(categoryStats).forEach(([cat, stats]) => {
    console.log(`   ${cat}: ${stats.imported} imported`);
  });
  console.log(`\n⚠️  Note: You need to update prices manually after import.`);
  console.log(`   Run the SQL file in your Supabase SQL Editor.`);
}

// Run if executed directly
if (require.main === module) {
  importComponents().catch(console.error);
}

module.exports = { importComponents, convertToSupabaseFormat };

