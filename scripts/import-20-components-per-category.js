/**
 * Import 20 components per category from BuildCores OpenDB
 * Matches exact database schema
 */

const https = require('https');
const fs = require('fs');
const path = require('path');

const BUILDORES_REPO = 'buildcores/buildcores-open-db';
const BUILDORES_BASE_URL = `https://api.github.com/repos/${BUILDORES_REPO}/contents/open-db`;
const COMPONENTS_PER_CATEGORY = 120; // 120 components per category for maximum variety

const CATEGORIES = {
  'CPU': { categoryId: 1 },
  'Motherboard': { categoryId: 2 },
  'RAM': { categoryId: 3 },
  'Storage': { categoryId: 4 },
  'GPU': { categoryId: 5 },
  'PSU': { categoryId: 6 },
  'PCCase': { categoryId: 7 },
  'CPUCooler': { categoryId: 8 }
};

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

async function fetchCategoryFiles(category) {
  try {
    const url = `${BUILDORES_BASE_URL}/${category}`;
    const response = await githubRequest(url);
    if (!Array.isArray(response)) return [];
    return response.filter(file => file.type === 'file' && file.name.endsWith('.json'));
  } catch (error) {
    console.error(`Error fetching ${category}:`, error.message);
    return [];
  }
}

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
            resolve(JSON.parse(data));
          } catch (e) {
            reject(e);
          }
        });
      }).on('error', reject);
    });
  } catch (error) {
    return null;
  }
}

function convertToSupabaseFormat(component, category, dbCategoryId) {
  const compatInfo = {};
  compatInfo.manufacturer = component.metadata?.manufacturer || null;

  if (category === 'CPU') {
    compatInfo.socket = component.socket || null;
    compatInfo.cpuSocket = component.socket || null;
    compatInfo.tdp = component.tdp || null;
    compatInfo.tdpRating = component.tdp ? `${component.tdp}W` : null;
    compatInfo.cores = component.cores?.total || component.cores || null;
    compatInfo.threads = component.cores?.threads || component.threads || null;
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
    // Fix: Handle speed as number or string
    const speed = component.speed;
    let speedStr = '';
    if (typeof speed === 'number') {
      speedStr = speed.toString();
    } else if (typeof speed === 'string') {
      speedStr = speed;
    } else if (speed && typeof speed === 'object') {
      speedStr = JSON.stringify(speed);
    }
    
    compatInfo.memoryType = speedStr.includes('DDR4') ? 'DDR4' : 
                           speedStr.includes('DDR5') ? 'DDR5' : 'DDR4';
    compatInfo.ram_type = compatInfo.memoryType;
    compatInfo.capacity = component.capacity || null;
    compatInfo.speed = speedStr || null;
    compatInfo.speedMhz = speedStr || null;
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
    compatInfo.supported_sockets = component.supported_sockets || (component.socket ? [component.socket] : []) || [];
    compatInfo.supportedSockets = compatInfo.supported_sockets;
    compatInfo.sockets = compatInfo.supported_sockets;
    compatInfo.tdp = component.tdp || null;
    compatInfo.tdpRating = component.tdp ? `${component.tdp}W` : null;
    compatInfo.height = component.height || null;
    compatInfo.type = component.type || 'Air Cooler';
    compatInfo.coolerType = compatInfo.type;
  }

  let componentName = component.metadata?.name || component.name || 'Unknown Component';
  
  // Truncate to 150 characters to match database schema
  if (componentName.length > 150) {
    componentName = componentName.substring(0, 147) + '...';
  }
  
  // Set default prices based on category (in PHP)
  const defaultPrices = {
    1: 5000,   // CPU - ₱5,000 default
    2: 4000,   // Motherboard - ₱4,000 default
    3: 2000,   // RAM - ₱2,000 default
    4: 3000,   // Storage - ₱3,000 default
    5: 15000,  // GPU - ₱15,000 default
    6: 3000,   // PSU - ₱3,000 default
    7: 2500,   // Case - ₱2,500 default
    8: 1500    // Cooling - ₱1,500 default
  };
  
  const defaultPrice = defaultPrices[dbCategoryId] || 1000;
  
  return {
    component_name: componentName,
    component_price: defaultPrice,
    compatibility_information: JSON.stringify(compatInfo),
    category_id: dbCategoryId,
    component_purpose: null,
    retailer_id: null
  };
}

async function importComponents() {
  console.log('🚀 Starting BuildCores import (20 per category)...\n');

  const sqlStatements = [];
  let totalImported = 0;
  const categoryStats = {};

  for (const [buildcoresCategory, categoryInfo] of Object.entries(CATEGORIES)) {
    console.log(`📦 Fetching ${buildcoresCategory}...`);
    
    const files = await fetchCategoryFiles(buildcoresCategory);
    const filesToProcess = files.slice(0, COMPONENTS_PER_CATEGORY);
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

        const supabaseFormat = convertToSupabaseFormat(component, buildcoresCategory, categoryInfo.categoryId);
        
        const escapedName = supabaseFormat.component_name.replace(/'/g, "''");
        const escapedCompat = supabaseFormat.compatibility_information.replace(/'/g, "''");

        const sql = `INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  retailer_id
)
SELECT 
  '${escapedName}',
  ${supabaseFormat.component_price},
  '${escapedCompat}'::jsonb,
  ${categoryInfo.categoryId},
  ${supabaseFormat.component_purpose ? `'${supabaseFormat.component_purpose}'` : 'NULL'},
  ${supabaseFormat.retailer_id || 'NULL'}
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('${escapedName}')
);`;

        sqlStatements.push(sql);
        imported++;
        totalImported++;

        await new Promise(resolve => setTimeout(resolve, 200));
      } catch (error) {
        console.error(`   ⚠️  Error: ${file.name}`, error.message);
        skipped++;
      }
    }

    categoryStats[buildcoresCategory] = { imported, skipped };
    console.log(`   ✅ ${imported} imported (${skipped} skipped)\n`);
  }

  const sqlFile = path.join(__dirname, 'import-20-components-per-category.sql');
  const sqlContent = `-- Import ${COMPONENTS_PER_CATEGORY} components per category from BuildCores OpenDB
-- Generated: ${new Date().toISOString()}
-- Total: ${totalImported} components (${COMPONENTS_PER_CATEGORY} per category)
-- Schema matches: component_name, component_price, compatibility_information (jsonb), category_id, component_purpose, retailer_id

${sqlStatements.join('\n\n')}

-- Summary:
${Object.entries(categoryStats).map(([cat, stats]) => 
  `-- ${cat}: ${stats.imported} imported, ${stats.skipped} skipped`
).join('\n')}
`;

  fs.writeFileSync(sqlFile, sqlContent, 'utf8');
  
  console.log(`\n✅ Complete!`);
  console.log(`   Total: ${totalImported} components`);
  console.log(`   File: ${sqlFile}`);
  console.log(`\n📊 Summary:`);
  Object.entries(categoryStats).forEach(([cat, stats]) => {
    console.log(`   ${cat}: ${stats.imported}`);
  });
  console.log(`\n✅ Default prices set per category. Update manually if needed.`);
}

if (require.main === module) {
  importComponents().catch(console.error);
}

module.exports = { importComponents };

