"""
Import RAM components from BuildCores Open Database GitHub Repository
https://github.com/buildcores/buildcores-open-db/tree/main/open-db/RAM
"""

import requests
import json
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

SUPABASE_URL = os.getenv("SUPABASE_URL", "https://sldiqjjgddegffbzjqma.supabase.co")
SUPABASE_KEY = os.getenv("SUPABASE_KEY", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNsZGlxampnZGRlZ2ZmYnpqcW1hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc1MjA1MDMsImV4cCI6MjA3MzA5NjUwM30.wir0lfBKEo0NimhsPjLmJvXexFjyQTmyHzGsE40xDmA")

headers = {
    "apikey": SUPABASE_KEY,
    "Authorization": f"Bearer {SUPABASE_KEY}",
    "Content-Type": "application/json",
    "Prefer": "return=representation"
}

# BuildCores GitHub API
BUILDCORES_API = "https://api.github.com/repos/buildcores/buildcores-open-db/contents/open-db/RAM"

def fetch_buildcores_ram():
    """Fetch RAM data from BuildCores GitHub repository"""
    print("📦 Fetching RAM components from BuildCores GitHub...")
    
    try:
        response = requests.get(BUILDCORES_API)
        if response.status_code == 200:
            files = response.json()
            ram_data = []
            
            # Get JSON files from the RAM directory
            for file in files:
                if file['name'].endswith('.json'):
                    print(f"  📄 Found: {file['name']}")
                    # Fetch the file content
                    file_response = requests.get(file['download_url'])
                    if file_response.status_code == 200:
                        try:
                            data = file_response.json()
                            if isinstance(data, list):
                                ram_data.extend(data)
                            else:
                                ram_data.append(data)
                        except:
                            print(f"  ⚠️ Skipping {file['name']} - invalid JSON")
            
            print(f"✅ Found {len(ram_data)} RAM components from BuildCores\n")
            return ram_data
        else:
            print(f"❌ Failed to access BuildCores: {response.status_code}")
            return []
    except Exception as e:
        print(f"❌ Error fetching from BuildCores: {e}")
        return []

def check_existing_ram():
    """Check current RAM count in database"""
    url = f"{SUPABASE_URL}/rest/v1/components?select=component_id,component_name,component_price&category_id=eq.3&order=component_price.desc"
    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        existing_ram = response.json()
        print(f"📊 Current RAM in database: {len(existing_ram)}")
        return len(existing_ram), existing_ram
    return 0, []

def import_top_rams(ram_data, target_count=40):
    """Import top RAM components to reach target count"""
    current_count, existing_ram = check_existing_ram()
    
    if current_count >= target_count:
        print(f"✅ Already have {current_count} RAM components (target: {target_count})")
        print(f"🎯 Top {target_count} will be shown on frontend")
        return
    
    needed = target_count - current_count
    print(f"\n📦 Need {needed} more RAM to reach {target_count}")
    print(f"📦 Available from BuildCores: {len(ram_data)}\n")
    
    # Get existing names to avoid duplicates
    existing_names = {ram['component_name'].lower() for ram in existing_ram}
    
    # Sort BuildCores RAM by price (if available)
    sorted_ram = sorted(ram_data, key=lambda x: float(x.get('price', 0) or 0), reverse=True)
    
    imported = 0
    skipped = 0
    
    for ram in sorted_ram:
        if imported >= needed:
            break
        
        name = ram.get('name', ram.get('component_name', 'Unknown RAM'))
        price = float(ram.get('price', ram.get('component_price', 2500)) or 2500)
        
        # Skip if already exists
        if name.lower() in existing_names:
            skipped += 1
            continue
        
        # Build compatibility info
        compatibility_info = {
            "type": ram.get('type', ram.get('ram_type', 'DDR4')),
            "capacity": ram.get('capacity', '16GB'),
            "speed": ram.get('speed', ram.get('frequency', '3200MHz')),
            "ram_type": ram.get('type', ram.get('ram_type', 'DDR4'))
        }
        
        # Prepare component data
        component_data = {
            "component_name": name,
            "component_price": price,
            "category_id": 3,  # RAM category
            "compatibility_information": json.dumps(compatibility_info),
            "component_purpose": ram.get('purpose', 'gaming'),
            "retailer_id": 1
        }
        
        # Insert into database
        url = f"{SUPABASE_URL}/rest/v1/components"
        response = requests.post(url, headers=headers, json=component_data)
        
        if response.status_code in [200, 201]:
            imported += 1
            print(f"✅ [{imported}/{needed}] Added: {name} - ₱{price:,.0f}")
        else:
            print(f"❌ Failed to add {name}: {response.text}")
    
    print(f"\n{'='*60}")
    print(f"🎉 Import Complete!")
    print(f"{'='*60}")
    print(f"✅ Imported: {imported} new RAM components")
    if skipped > 0:
        print(f"⏭️  Skipped: {skipped} duplicates")
    
    # Final count
    final_count, _ = check_existing_ram()
    print(f"\n📊 Total RAM in database: {final_count}")
    print(f"🎯 Frontend will show top {min(final_count, 40)} by price")

if __name__ == "__main__":
    print("="*60)
    print("  BuildCores RAM Importer (GitHub Direct)")
    print("="*60)
    print()
    
    # Fetch from BuildCores GitHub
    ram_data = fetch_buildcores_ram()
    
    if ram_data:
        import_top_rams(ram_data, target_count=40)
    else:
        print("❌ No RAM data available from BuildCores")

