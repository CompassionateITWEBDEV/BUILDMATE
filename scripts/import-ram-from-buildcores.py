"""
Import RAM components from BuildCores Open DB
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

# BuildCores RAM data - Sample high-quality RAM modules
BUILDCORES_RAM = [
    {
        "name": "Corsair Vengeance RGB Pro 32GB (2x16GB) DDR4-3600",
        "price": 6500,
        "type": "DDR4",
        "capacity": "32GB",
        "speed": "3600MHz",
        "purpose": "gaming"
    },
    {
        "name": "G.Skill Trident Z RGB 32GB (2x16GB) DDR4-3200",
        "price": 6200,
        "type": "DDR4",
        "capacity": "32GB",
        "speed": "3200MHz",
        "purpose": "gaming"
    },
    {
        "name": "Kingston FURY Beast 16GB (2x8GB) DDR4-3200",
        "price": 2800,
        "type": "DDR4",
        "capacity": "16GB",
        "speed": "3200MHz",
        "purpose": "gaming"
    },
    {
        "name": "Corsair Vengeance LPX 16GB (2x8GB) DDR4-3000",
        "price": 2600,
        "type": "DDR4",
        "capacity": "16GB",
        "speed": "3000MHz",
        "purpose": "office"
    },
    {
        "name": "Crucial Ballistix 32GB (2x16GB) DDR4-3600",
        "price": 5800,
        "type": "DDR4",
        "capacity": "32GB",
        "speed": "3600MHz",
        "purpose": "gaming"
    },
    {
        "name": "TeamGroup T-Force Delta RGB 16GB (2x8GB) DDR4-3200",
        "price": 2900,
        "type": "DDR4",
        "capacity": "16GB",
        "speed": "3200MHz",
        "purpose": "gaming"
    },
    {
        "name": "Kingston ValueRAM 8GB DDR4-2666",
        "price": 1200,
        "type": "DDR4",
        "capacity": "8GB",
        "speed": "2666MHz",
        "purpose": "office"
    },
    {
        "name": "Corsair Dominator Platinum RGB 32GB (2x16GB) DDR4-3600",
        "price": 8500,
        "type": "DDR4",
        "capacity": "32GB",
        "speed": "3600MHz",
        "purpose": "gaming"
    },
    {
        "name": "G.Skill Ripjaws V 16GB (2x8GB) DDR4-3600",
        "price": 3200,
        "type": "DDR4",
        "capacity": "16GB",
        "speed": "3600MHz",
        "purpose": "gaming"
    },
    {
        "name": "ADATA XPG Spectrix D60G 16GB (2x8GB) DDR4-3200",
        "price": 3100,
        "type": "DDR4",
        "capacity": "16GB",
        "speed": "3200MHz",
        "purpose": "gaming"
    },
    {
        "name": "Crucial 8GB DDR4-2400",
        "price": 1100,
        "type": "DDR4",
        "capacity": "8GB",
        "speed": "2400MHz",
        "purpose": "office"
    },
    {
        "name": "HyperX Fury RGB 32GB (2x16GB) DDR4-3200",
        "price": 6000,
        "type": "DDR4",
        "capacity": "32GB",
        "speed": "3200MHz",
        "purpose": "gaming"
    }
]

def check_existing_ram():
    """Check how many RAM components are currently in the database"""
    url = f"{SUPABASE_URL}/rest/v1/components?select=component_id,component_name&category_id=eq.3"
    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        existing_ram = response.json()
        print(f"✅ Current RAM components in database: {len(existing_ram)}")
        return len(existing_ram), existing_ram
    else:
        print(f"❌ Error checking RAM: {response.text}")
        return 0, []

def import_ram_components():
    """Import RAM components from BuildCores data"""
    
    # Check current RAM count
    current_count, existing_ram = check_existing_ram()
    
    if current_count >= 40:
        print(f"✅ Already have {current_count} RAM components (target: 40)")
        return
    
    needed = 40 - current_count
    print(f"\n📦 Need to add {needed} more RAM components to reach 40")
    print(f"📦 Will import {min(needed, len(BUILDCORES_RAM))} RAM components from BuildCores\n")
    
    # Get existing names to avoid duplicates
    existing_names = {ram['component_name'].lower() for ram in existing_ram}
    
    # Import RAM components
    imported = 0
    skipped = 0
    
    for i, ram in enumerate(BUILDCORES_RAM):
        if imported >= needed:
            break
        
        # Check if already exists
        if ram['name'].lower() in existing_names:
            print(f"⏭️  Skipping duplicate: {ram['name']}")
            skipped += 1
            continue
        
        # Build compatibility information
        compatibility_info = {
            "type": ram['type'],
            "capacity": ram['capacity'],
            "speed": ram['speed'],
            "ram_type": ram['type']
        }
        
        # Prepare component data
        component_data = {
            "component_name": ram['name'],
            "component_price": ram['price'],
            "category_id": 3,  # RAM category
            "compatibility_information": json.dumps(compatibility_info),
            "component_purpose": ram['purpose'],
            "retailer_id": 1  # Default retailer (Central Juan Solution)
        }
        
        # Insert into database
        url = f"{SUPABASE_URL}/rest/v1/components"
        response = requests.post(url, headers=headers, json=component_data)
        
        if response.status_code in [200, 201]:
            imported += 1
            print(f"✅ [{imported}/{needed}] Added: {ram['name']} - ₱{ram['price']:,}")
        else:
            print(f"❌ Failed to add {ram['name']}: {response.text}")
    
    print(f"\n{'='*60}")
    print(f"🎉 Import Complete!")
    print(f"{'='*60}")
    print(f"✅ Successfully imported: {imported} RAM components")
    if skipped > 0:
        print(f"⏭️  Skipped duplicates: {skipped}")
    
    # Check final count
    final_count, _ = check_existing_ram()
    print(f"\n📊 Final RAM count: {final_count}/40")
    
    if final_count >= 40:
        print("🎯 Target reached! You now have 40 RAM components!")
    elif final_count >= 12:
        print(f"✅ Above minimum requirement (12+)")

if __name__ == "__main__":
    print("="*60)
    print("  BuildCores RAM Importer")
    print("="*60)
    print()
    
    import_ram_components()

