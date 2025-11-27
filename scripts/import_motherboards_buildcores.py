#!/usr/bin/env python3
"""
Import motherboards from BuildCores OpenDB repository
Fetches at least 20 motherboards and converts them to Supabase format
"""

import requests
import json
import time
import os

# Configuration
BUILDORES_REPO = 'buildcores/buildcores-open-db'
BUILDORES_BASE_URL = f'https://api.github.com/repos/{BUILDORES_REPO}/contents/open-db/Motherboard'
MIN_MOTHERBOARDS = 20

def fetch_github_files(url):
    """Fetch files from GitHub API"""
    headers = {
        'User-Agent': 'BuildMate-Component-Importer',
        'Accept': 'application/vnd.github.v3+json'
    }
    response = requests.get(url, headers=headers)
    response.raise_for_status()
    return response.json()

def fetch_component_file(download_url):
    """Fetch and parse a component JSON file"""
    headers = {
        'User-Agent': 'BuildMate-Component-Importer',
        'Accept': 'application/vnd.github.v3.raw'
    }
    response = requests.get(download_url, headers=headers)
    response.raise_for_status()
    return response.json()

def convert_motherboard_to_supabase_format(component):
    """Convert BuildCores motherboard to Supabase format with full compatibility info"""
    compat_info = {
        'socket': component.get('socket'),
        'formFactor': component.get('form_factor') or component.get('formFactor') or 'Standard',
        'chipset': component.get('chipset'),
        'manufacturer': component.get('metadata', {}).get('manufacturer'),
    }

    # Memory compatibility
    if component.get('memory'):
        memory = component['memory']
        compat_info['memory'] = {
            'max': memory.get('max'),
            'ram_type': memory.get('ram_type'),
            'slots': memory.get('slots')
        }
        compat_info['memoryType'] = memory.get('ram_type') or 'DDR4'
        compat_info['memorySupport'] = memory.get('ram_type') or 'DDR4'

    # Storage compatibility
    if component.get('storage_devices'):
        storage = component['storage_devices']
        compat_info['storage_devices'] = storage
        sata_count = (storage.get('sata_6_gb_s', 0) + storage.get('sata_3_gb_s', 0))
        compat_info['sataPorts'] = str(sata_count)

    # M.2 slots
    if component.get('m2_slots'):
        compat_info['m2_slots'] = component['m2_slots']
        compat_info['m2Slots'] = str(len(component['m2_slots']))

    # PCIe slots
    if component.get('pcie_slots'):
        compat_info['pcie_slots'] = component['pcie_slots']

    # USB headers
    if component.get('usb_headers'):
        compat_info['usb_headers'] = component['usb_headers']

    # Onboard Ethernet
    if component.get('onboard_ethernet'):
        compat_info['onboard_ethernet'] = component['onboard_ethernet']

    # Audio
    if component.get('audio'):
        compat_info['audio'] = component['audio']

    # Additional features
    compat_info['raid_support'] = component.get('raid_support', False)
    compat_info['ecc_support'] = component.get('ecc_support', False)
    
    name = (component.get('metadata', {}).get('name') or '').lower()
    compat_info['wifi'] = 'wifi' in name

    # Determine performance category
    chipset = (component.get('chipset') or '').lower()
    if 'z' in chipset or 'x' in chipset or 'gaming' in name or 'rog' in name:
        performance_category = 'gaming'
    elif 'b' in chipset or 'h' in chipset:
        performance_category = 'office'
    else:
        performance_category = 'academic'

    component_name = component.get('metadata', {}).get('name') or component.get('name') or 'Unknown Motherboard'
    
    return {
        'component_name': component_name,
        'component_price': 0,
        'compatibility_information': json.dumps(compat_info),
        'component_purpose': performance_category,
        'availability_status': 'in_stock'
    }

def generate_sql_insert(motherboard_data):
    """Generate SQL INSERT statement"""
    component_name = motherboard_data['component_name'].replace("'", "''")
    compat_info = motherboard_data['compatibility_information'].replace("'", "''")
    purpose = motherboard_data['component_purpose'] or 'NULL'
    if purpose != 'NULL':
        purpose = f"'{purpose}'"
    
    return f"""
INSERT INTO components (
  component_name,
  component_price,
  compatibility_information,
  category_id,
  component_purpose,
  availability_status
)
SELECT 
  '{component_name}',
  {motherboard_data['component_price']},
  '{compat_info}',
  (SELECT category_id FROM component_categories WHERE LOWER(category_name) = 'motherboard' LIMIT 1),
  {purpose},
  '{motherboard_data['availability_status']}'
WHERE NOT EXISTS (
  SELECT 1 FROM components 
  WHERE LOWER(component_name) = LOWER('{component_name}')
)
RETURNING component_id, component_name;"""

def main():
    print('Starting BuildCores motherboard import...\n')

    try:
        # Fetch motherboard files
        print('Fetching motherboard files from BuildCores OpenDB...')
        files = fetch_github_files(BUILDORES_BASE_URL)
        
        # Filter for JSON files
        json_files = [f for f in files if f.get('type') == 'file' and f.get('name', '').endswith('.json')]
        
        print(f'   Found {len(json_files)} motherboard files')
        
        if len(json_files) < MIN_MOTHERBOARDS:
            print(f'   WARNING: Only found {len(json_files)} motherboards, wanted at least {MIN_MOTHERBOARDS}')

        sql_statements = []
        imported = 0
        skipped = 0

        # Process each motherboard
        for file in json_files[:max(MIN_MOTHERBOARDS, len(json_files))]:
            try:
                component = fetch_component_file(file['download_url'])
                if not component or not component.get('socket'):
                    skipped += 1
                    continue

                supabase_format = convert_motherboard_to_supabase_format(component)
                sql = generate_sql_insert(supabase_format)
                sql_statements.append(sql)
                imported += 1
                
                print(f'   OK: {supabase_format["component_name"]}')

                # Rate limiting
                time.sleep(0.2)
            except Exception as e:
                print(f'   ERROR processing {file.get("name", "unknown")}: {str(e)}')
                skipped += 1

        # Write SQL file
        script_dir = os.path.dirname(os.path.abspath(__file__))
        sql_file = os.path.join(script_dir, 'import-motherboards-buildcores.sql')
        
        sql_content = f"""-- Import {imported} motherboards from BuildCores OpenDB
-- Generated: {time.strftime('%Y-%m-%d %H:%M:%S')}
-- Source: https://github.com/{BUILDORES_REPO}
-- 
-- All motherboards include full compatibility information for:
-- - Compatibility checking (socket, form factor, memory type)
-- - CSP algorithm (all compatibility constraints)
-- - Performance category (gaming, academic, office)

{sql_statements.join('\n')}

-- Update prices manually after import
-- Example: UPDATE components SET component_price = 8500 WHERE component_name = 'ASUS B760M-AYW WIFI D4 DDR4 Micro ATX';
"""

        with open(sql_file, 'w', encoding='utf-8') as f:
            f.write(sql_content)
        
        print(f'\nImport complete!')
        print(f'   Imported: {imported} motherboards')
        print(f'   Skipped: {skipped} motherboards')
        print(f'   SQL file: {sql_file}')
        print(f'\nNOTE: You need to update prices manually after import.')
        print(f'   All motherboards have compatibility information for CSP and compatibility checking.')
        
    except Exception as error:
        print(f'ERROR during import: {error}')

if __name__ == '__main__':
    main()

