/**
 * Import components from BuildCores OpenDB repository
 * Fetches components from GitHub and imports them into Supabase
 * 
 * Usage: node scripts/import-buildcores-components.js
 */

const https = require('https');
const fs = require('fs');
const path = require('path');

// Configuration
const BUILDORES_REPO = 'buildcores/buildcores-open-db';
const BUILDORES_BASE_URL = `https://api.github.com/repos/${BUILDORES_REPO}/contents/open-db`;
const COMPONENTS_PER_CATEGORY = 50;
const MIN_PER_PAGE = 10;

// Categories to import
const CATEGORIES = {
  'Motherboard': 'motherboard',
  'RAM': 'memory',
  'Storage': 'storage',
  'GPU': 'gpu',
  'PSU': 'psu',
  'Case': 'case',
  'Cooling': 'cooling'
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
    const files = await githubRequest(url);
    
    // Filter for JSON files only
    const jsonFiles = files.filter(file => 
      file.type === 'file' && file.name.endsWith('.json')
    );
    
    return jsonFiles.slice(0, COMPONENTS_PER_CATEGORY);
  } catch (error) {
    console.error(`Error fetching ${category} files:`, error.message);
    return [];
  }
}

// Fetch and parse a component JSON file
async function fetchComponentFile(category, fileName, downloadUrl) {
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
    console.error(`Error fetching component ${fileName}:`, error.message);
    return null;
  }
}

// Convert BuildCores component to Supabase format
function convertToSupabaseFormat(component, category, dbCategoryId) {
  const compatInfo = {
    socket: component.socket || null,
    formFactor: component.form_factor || component.formFactor || null,
    chipset: component.chipset || null,
    manufacturer: component.metadata?.manufacturer || null,
  };

  // Add category-specific compatibility info
  if (category === 'Motherboard') {
    compatInfo.memory = component.memory || {};
    compatInfo.memoryType = component.memory?.ram_type || 'DDR4';
    compatInfo.memorySupport = component.memory?.ram_type || 'DDR4';
    compatInfo.m2Slots = component.m2_slots?.length?.toString() || '0';
    compatInfo.sataPorts = (component.storage_devices?.sata_6_gb_s || 0).toString();
    compatInfo.pcieSlots = component.pcie_slots || [];
    compatInfo.wifi = component.metadata?.name?.toLowerCase().includes('wifi') || false;
  } else if (category === 'RAM') {
    compatInfo.memoryType = component.speed?.includes('DDR4') ? 'DDR4' : 
                           component.speed?.includes('DDR5') ? 'DDR5' : 'DDR4';
    compatInfo.capacity = component.capacity || null;
    compatInfo.speed = component.speed || null;
  } else if (category === 'Storage') {
    compatInfo.interface = component.interface || null;
    compatInfo.capacity = component.capacity || null;
    compatInfo.formFactor = component.form_factor || component.formFactor || null;
  } else if (category === 'GPU') {
    compatInfo.memory = component.memory || null;
    compatInfo.powerRequirement = component.tdp || component.power_consumption || null;
    compatInfo.dimensions = component.length ? {
      length: component.length,
      width: component.width || null,
      height: component.height || null
    } : null;
  } else if (category === 'PSU') {
    compatInfo.wattage = component.wattage || null;
    compatInfo.efficiency = component.efficiency || null;
    compatInfo.modular = component.modular || null;
  } else if (category === 'Case') {
    compatInfo.formFactor = component.form_factor || component.formFactor || null;
    compatInfo.maxGpuLength = component.max_gpu_length || null;
    compatInfo.maxCoolerHeight = component.max_cooler_height || null;
  } else if (category === 'Cooling') {
    compatInfo.supportedSockets = component.supported_sockets || component.socket || [];
    compatInfo.tdp = component.tdp || null;
    compatInfo.height = component.height || null;
  }

  return {
    component_name: component.metadata?.name || component.name || 'Unknown',
    component_price: 0, // Price needs to be set manually
    compatibility_information: JSON.stringify(compatInfo),
    category_id: dbCategoryId,
    component_purpose: null, // Can be set to 'gaming', 'academic', 'office'
    availability_status: 'in_stock'
  };
}

// Main import function
async function importComponents() {
  console.log('🚀 Starting BuildCores component import...\n');

  // This would need to be run in a Node.js environment with Supabase client
  // For now, we'll generate SQL insert statements
  
  const sqlStatements = [];
  let totalImported = 0;

  for (const [buildcoresCategory, appCategory] of Object.entries(CATEGORIES)) {
    console.log(`📦 Fetching ${buildcoresCategory} components...`);
    
    const files = await fetchCategoryFiles(buildcoresCategory);
    console.log(`   Found ${files.length} ${buildcoresCategory} files`);

    let imported = 0;
    for (const file of files.slice(0, COMPONENTS_PER_CATEGORY)) {
      try {
        const component = await fetchComponentFile(buildcoresCategory, file.name, file.download_url);
        if (!component) continue;

        // Generate SQL insert statement
        const supabaseFormat = convertToSupabaseFormat(component, buildcoresCategory, `(SELECT category_id FROM component_categories WHERE LOWER(category_name) = '${appCategory.toLowerCase()}' LIMIT 1)`);
        
        const sql = `
INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  availability_status
)
SELECT 
  ${JSON.stringify(supabaseFormat.component_name)},
  ${supabaseFormat.component_price},
  ${JSON.stringify(supabaseFormat.compatibility_information)},
  ${supabaseFormat.category_id},
  ${supabaseFormat.component_purpose ? `'${supabaseFormat.component_purpose}'` : 'NULL'},
  '${supabaseFormat.availability_status}'
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER(${JSON.stringify(supabaseFormat.component_name)})
);`;

        sqlStatements.push(sql);
        imported++;
        totalImported++;

        // Add delay to avoid rate limiting
        await new Promise(resolve => setTimeout(resolve, 100));
      } catch (error) {
        console.error(`   Error processing ${file.name}:`, error.message);
      }
    }

    console.log(`   ✅ Imported ${imported} ${buildcoresCategory} components\n`);
  }

  // Write SQL file
  const sqlFile = path.join(__dirname, 'import-buildcores-components.sql');
  fs.writeFileSync(sqlFile, sqlStatements.join('\n\n'));
  
  console.log(`\n✅ Import complete!`);
  console.log(`   Total components: ${totalImported}`);
  console.log(`   SQL file generated: ${sqlFile}`);
  console.log(`\n⚠️  Note: You need to update prices manually after import.`);
}

// Run if executed directly
if (require.main === module) {
  importComponents().catch(console.error);
}

module.exports = { importComponents, convertToSupabaseFormat };

