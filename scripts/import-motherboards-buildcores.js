/**
 * Import motherboards from BuildCores OpenDB repository
 * Fetches at least 20 motherboards and converts them to Supabase format
 * 
 * Usage: node scripts/import-motherboards-buildcores.js
 */

const https = require('https');
const fs = require('fs');
const path = require('path');

// Configuration
const BUILDORES_REPO = 'buildcores/buildcores-open-db';
const BUILDORES_BASE_URL = `https://api.github.com/repos/${BUILDORES_REPO}/contents/open-db/Motherboard`;
const MIN_MOTHERBOARDS = 20;

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

// Convert BuildCores motherboard to Supabase format with full compatibility info
function convertMotherboardToSupabaseFormat(component) {
  // Extract compatibility information
  const compatInfo = {
    socket: component.socket || null,
    formFactor: component.form_factor || component.formFactor || 'Standard',
    chipset: component.chipset || null,
    manufacturer: component.metadata?.manufacturer || null,
  };

  // Memory compatibility
  if (component.memory) {
    compatInfo.memory = {
      max: component.memory.max || null,
      ram_type: component.memory.ram_type || null,
      slots: component.memory.slots || null
    };
    compatInfo.memoryType = component.memory.ram_type || 'DDR4';
    compatInfo.memorySupport = component.memory.ram_type || 'DDR4';
  }

  // Storage compatibility
  if (component.storage_devices) {
    compatInfo.storage_devices = component.storage_devices;
    const sataCount = (component.storage_devices.sata_6_gb_s || 0) + 
                     (component.storage_devices.sata_3_gb_s || 0);
    compatInfo.sataPorts = sataCount.toString();
  }

  // M.2 slots
  if (component.m2_slots && Array.isArray(component.m2_slots)) {
    compatInfo.m2_slots = component.m2_slots;
    compatInfo.m2Slots = component.m2_slots.length.toString();
  }

  // PCIe slots
  if (component.pcie_slots && Array.isArray(component.pcie_slots)) {
    compatInfo.pcie_slots = component.pcie_slots;
  }

  // USB headers
  if (component.usb_headers) {
    compatInfo.usb_headers = component.usb_headers;
  }

  // Onboard Ethernet
  if (component.onboard_ethernet && Array.isArray(component.onboard_ethernet)) {
    compatInfo.onboard_ethernet = component.onboard_ethernet;
  }

  // Audio
  if (component.audio) {
    compatInfo.audio = component.audio;
  }

  // Additional features
  compatInfo.raid_support = component.raid_support || false;
  compatInfo.ecc_support = component.ecc_support || false;
  compatInfo.wifi = component.metadata?.name?.toLowerCase().includes('wifi') || false;

  // Determine performance category based on chipset and features
  let performanceCategory = null;
  const chipset = (component.chipset || '').toLowerCase();
  const name = (component.metadata?.name || '').toLowerCase();
  
  if (chipset.includes('z') || chipset.includes('x') || name.includes('gaming') || name.includes('rog')) {
    performanceCategory = 'gaming';
  } else if (chipset.includes('b') || chipset.includes('h')) {
    performanceCategory = 'office';
  } else {
    performanceCategory = 'academic';
  }

  return {
    component_name: component.metadata?.name || component.name || 'Unknown Motherboard',
    component_price: 0, // Needs to be set manually
    compatibility_information: JSON.stringify(compatInfo),
    category_id: `(SELECT category_id FROM component_categories WHERE LOWER(category_name) = 'motherboard' LIMIT 1)`,
    component_purpose: performanceCategory,
    availability_status: 'in_stock'
  };
}

// Main import function
async function importMotherboards() {
  console.log('🚀 Starting BuildCores motherboard import...\n');

  try {
    // Fetch motherboard files from GitHub
    console.log('📦 Fetching motherboard files from BuildCores OpenDB...');
    const files = await githubRequest(BUILDORES_BASE_URL);
    
    // Filter for JSON files only
    const jsonFiles = files.filter(file => 
      file.type === 'file' && file.name.endsWith('.json')
    );
    
    console.log(`   Found ${jsonFiles.length} motherboard files`);
    
    if (jsonFiles.length < MIN_MOTHERBOARDS) {
      console.warn(`   ⚠️  Only found ${jsonFiles.length} motherboards, wanted at least ${MIN_MOTHERBOARDS}`);
    }

    const sqlStatements = [];
    let imported = 0;
    let skipped = 0;

    // Process each motherboard file
    for (const file of jsonFiles.slice(0, Math.max(MIN_MOTHERBOARDS, jsonFiles.length))) {
      try {
        const component = await fetchComponentFile(file.download_url);
        if (!component || !component.socket) {
          skipped++;
          continue;
        }

        const supabaseFormat = convertMotherboardToSupabaseFormat(component);
        
        // Generate SQL insert statement
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
)
RETURNING component_id, component_name;`;

        sqlStatements.push(sql);
        imported++;

        // Add delay to avoid rate limiting
        await new Promise(resolve => setTimeout(resolve, 200));
      } catch (error) {
        console.error(`   ❌ Error processing ${file.name}:`, error.message);
        skipped++;
      }
    }

    // Write SQL file
    const sqlFile = path.join(__dirname, 'import-motherboards-buildcores.sql');
    const sqlContent = `-- Import ${imported} motherboards from BuildCores OpenDB
-- Generated: ${new Date().toISOString()}
-- Source: https://github.com/${BUILDORES_REPO}

${sqlStatements.join('\n\n')}

-- Update prices manually after import
-- Example: UPDATE components SET component_price = 8500 WHERE component_name = 'ASUS B760M-AYW WIFI D4 DDR4 Micro ATX';
`;

    fs.writeFileSync(sqlFile, sqlContent);
    
    console.log(`\n✅ Import complete!`);
    console.log(`   ✅ Imported: ${imported} motherboards`);
    console.log(`   ⏭️  Skipped: ${skipped} motherboards`);
    console.log(`   📄 SQL file: ${sqlFile}`);
    console.log(`\n⚠️  Note: You need to update prices manually after import.`);
    console.log(`   All motherboards have compatibility information for CSP and compatibility checking.`);
    
  } catch (error) {
    console.error('❌ Error during import:', error);
  }
}

// Run if executed directly
if (require.main === module) {
  importMotherboards().catch(console.error);
}

module.exports = { importMotherboards, convertMotherboardToSupabaseFormat };

