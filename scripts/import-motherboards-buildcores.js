const https = require('https');
const fs = require('fs');
const path = require('path');

const GITHUB_API_BASE = 'https://api.github.com/repos/buildcores/buildcores-open-db/contents';
const COMPONENTS_TO_FETCH = 20;

// Category mapping
const CATEGORY_INFO = {
  categoryId: 2, // Motherboard
  appCategory: 'motherboard'
};

// Fetch files from a GitHub directory
async function fetchCategoryFiles(category) {
  return new Promise((resolve, reject) => {
    const url = `${GITHUB_API_BASE}/open-db/${category}`;
    
    https.get(url, {
      headers: {
        'User-Agent': 'BuildMate-Import-Script',
        'Accept': 'application/vnd.github.v3+json'
      }
    }, (res) => {
      let data = '';
      
      res.on('data', (chunk) => {
        data += chunk;
      });
      
      res.on('end', () => {
        if (res.statusCode !== 200) {
          reject(new Error(`GitHub API error: ${res.statusCode} - ${data}`));
          return;
        }
        
        try {
          const files = JSON.parse(data);
          // Filter for JSON files only
          const jsonFiles = files.filter(file => 
            file.type === 'file' && file.name.endsWith('.json')
          );
          resolve(jsonFiles);
        } catch (e) {
          reject(new Error(`Failed to parse GitHub response: ${e.message}`));
        }
      });
    }).on('error', (err) => {
      reject(err);
    });
  });
}

// Fetch a single component file
async function fetchComponentFile(downloadUrl) {
  return new Promise((resolve, reject) => {
    https.get(downloadUrl, {
      headers: {
        'User-Agent': 'BuildMate-Import-Script',
        'Accept': 'application/vnd.github.v3.raw'
      }
    }, (res) => {
      let data = '';
      
      res.on('data', (chunk) => {
        data += chunk;
      });
      
      res.on('end', () => {
        if (res.statusCode !== 200) {
          reject(new Error(`Failed to fetch file: ${res.statusCode}`));
          return;
        }
        
        try {
          const component = JSON.parse(data);
          resolve(component);
        } catch (e) {
          reject(new Error(`Failed to parse JSON: ${e.message}`));
        }
      });
    }).on('error', (err) => {
      reject(err);
    });
  });
}

// Convert BuildCores format to Supabase format
function convertToSupabaseFormat(component, category, dbCategoryId) {
  const compatInfo = {};
  
  // Extract metadata
  const metadata = component.metadata || {};
  const componentName = metadata.name || component.name || 'Unknown Motherboard';
  
  // Truncate name to 150 characters
  const truncatedName = componentName.length > 150 ? componentName.substring(0, 150) : componentName;
  
  // Socket information
  if (component.socket) {
    compatInfo.socket = component.socket;
    compatInfo.cpuSocket = component.socket;
  }
  
  // Form factor
  if (component.form_factor) {
    compatInfo.formFactor = component.form_factor;
  }
  
  // Chipset
  if (component.chipset) {
    compatInfo.chipset = component.chipset;
  }
  
  // Memory support
  if (component.memory) {
    compatInfo.memory = component.memory;
    if (component.memory.ram_type) {
      compatInfo.memoryType = component.memory.ram_type;
      compatInfo.ram_type = component.memory.ram_type;
      compatInfo.memorySupport = component.memory.ram_type;
    }
    if (component.memory.max) {
      compatInfo.maxMemory = component.memory.max;
    }
    if (component.memory.slots) {
      compatInfo.memorySlots = component.memory.slots;
    }
  }
  
  // M.2 slots
  if (component.m2_slots && Array.isArray(component.m2_slots)) {
    compatInfo.m2Slots = component.m2_slots.length.toString();
  }
  
  // SATA ports
  if (component.storage_devices) {
    const sata6 = component.storage_devices.sata_6_gb_s || 0;
    const sata3 = component.storage_devices.sata_3_gb_s || 0;
    compatInfo.sataPorts = (sata6 + sata3).toString();
  }
  
  // PCIe slots
  if (component.pcie_slots && Array.isArray(component.pcie_slots)) {
    compatInfo.pcieSlots = component.pcie_slots;
  }
  
  // WiFi
  if (component.onboard_ethernet || component.wifi) {
    compatInfo.wifi = true;
  }
  
  // Manufacturer
  if (metadata.manufacturer) {
    compatInfo.manufacturer = metadata.manufacturer;
  }
  
  // Color
  if (component.color && Array.isArray(component.color)) {
    compatInfo.color = component.color;
  }
  
  // Default price for motherboard (4000 PHP)
  const defaultPrice = 4000;
  
  return {
    component_name: truncatedName,
    component_brand: metadata.manufacturer || null,
    component_price: defaultPrice,
    component_description: metadata.description || null,
    compatibility_information: JSON.stringify(compatInfo),
    category_id: dbCategoryId,
    component_purpose: null,
    retailer_id: null
  };
}

// Main import function
async function importMotherboards() {
  console.log('🚀 Starting Motherboard import from BuildCores OpenDB...\n');
  
  const sqlStatements = [];
  let totalImported = 0;
  let skipped = 0;
  
  try {
    console.log('📦 Fetching Motherboard files from GitHub...');
    const files = await fetchCategoryFiles('Motherboard');
    console.log(`   Found ${files.length} motherboard files`);
    
    const filesToProcess = files.slice(0, COMPONENTS_TO_FETCH);
    console.log(`   Processing ${filesToProcess.length} files...\n`);
    
    for (const file of filesToProcess) {
      try {
        const component = await fetchComponentFile(file.download_url);
        if (!component) {
          skipped++;
          continue;
        }
        
        const supabaseFormat = convertToSupabaseFormat(
          component,
          'Motherboard',
          CATEGORY_INFO.categoryId
        );
        
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
  ${CATEGORY_INFO.categoryId},
  ${supabaseFormat.component_purpose ? `'${supabaseFormat.component_purpose}'` : 'NULL'},
  ${supabaseFormat.retailer_id || 'NULL'}
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('${escapedName}')
);`;
        
        sqlStatements.push(sql);
        totalImported++;
        
        console.log(`   ✅ ${totalImported}/${filesToProcess.length}: ${supabaseFormat.component_name.substring(0, 60)}...`);
        
        // Add delay to avoid rate limiting
        await new Promise(resolve => setTimeout(resolve, 300));
      } catch (error) {
        console.error(`   ⚠️  Error processing ${file.name}:`, error.message);
        skipped++;
      }
    }
    
    // Write SQL file
    const sqlFile = path.join(__dirname, 'import-motherboards-buildcores.sql');
    const sqlContent = `-- Import ${totalImported} Motherboard components from BuildCores OpenDB
-- Generated: ${new Date().toISOString()}
-- Category: Motherboard (category_id: ${CATEGORY_INFO.categoryId})
-- Total: ${totalImported} components
-- Schema matches: component_name, component_price, compatibility_information (jsonb), category_id, component_purpose, retailer_id
-- All components have default price of ₱4,000 to ensure they appear in the UI

${sqlStatements.join('\n\n')}

-- Summary:
-- Motherboard: ${totalImported} imported, ${skipped} skipped
`;

    fs.writeFileSync(sqlFile, sqlContent, 'utf8');
    
    console.log(`\n✅ Complete!`);
    console.log(`   Total: ${totalImported} motherboards imported`);
    console.log(`   Skipped: ${skipped}`);
    console.log(`   File: ${sqlFile}`);
    console.log(`\n📝 Next steps:`);
    console.log(`   1. Run the SQL file in Supabase SQL Editor`);
    console.log(`   2. Refresh the PC Builder UI`);
    console.log(`   3. Check the Motherboard tab - should show ${totalImported} components`);
    
  } catch (error) {
    console.error('\n❌ Import failed:', error.message);
    process.exit(1);
  }
}

// Run the import
importMotherboards().catch(console.error);
