import requests
import os

# Supabase configuration from environment variables
SUPABASE_URL = os.getenv("SUPABASE_URL", "https://sldiqjjgddegffbzjqma.supabase.co")
SUPABASE_KEY = os.getenv("SUPABASE_KEY", "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNsZGlxampnZGRlZ2ZmYnpqcW1hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc1MjA1MDMsImV4cCI6MjA3MzA5NjUwM30.wir0lfBKEo0NimhsPjLmJvXexFjyQTmyHzGsE40xDmA")

headers = {
    "apikey": SUPABASE_KEY,
    "Authorization": f"Bearer {SUPABASE_KEY}",
    "Content-Type": "application/json",
}

def fetch_build_components(build_id):
    url = f"{SUPABASE_URL}/rest/v1/build_components?select=component_id,components(component_name,component_price,category_id,component_categories(category_name))&build_id=eq.{build_id}"
    res = requests.get(url, headers=headers)
    data = res.json()

    return [
        {
            "component_id": d["component_id"],
            "component_name": d["components"]["component_name"],
            "component_price": d["components"]["component_price"],
            "category_name": d["components"]["component_categories"]["category_name"]
        }
        for d in data
    ]

def fetch_all_components():
    url = f"{SUPABASE_URL}/rest/v1/components?select=component_id,component_name,component_price,compatibility_information,category_id,component_categories(category_name)"
    res = requests.get(url, headers=headers)
    data = res.json()

    components = [
        {
            "component_id": d["component_id"],
            "component_name": d["component_name"],
            "component_price": d["component_price"],
            "compatibility_information": d.get("compatibility_information"),
            "category_id": d.get("category_id"),
            "category_name": d["component_categories"]["category_name"]
        }
        for d in data
    ]
    
    # LIMIT CPU, GPU, RAM components (40 max each) for performance
    cpu_components = [c for c in components if c.get('category_id') == 1]
    gpu_components = [c for c in components if c.get('category_id') == 5]  # GPU/Video Card is category_id 5
    memory_components = [c for c in components if c.get('category_id') == 3]  # Memory/RAM is category_id 3
    other_components = [c for c in components if c.get('category_id') not in [1, 3, 5]]
    
    # Keep only top 40 CPUs sorted by price (descending)
    original_cpu_count = len(cpu_components)
    if len(cpu_components) > 40:
        cpu_components = sorted(cpu_components, key=lambda x: float(x.get('component_price', 0) or 0), reverse=True)[:40]
        print(f"Limited CPUs from {original_cpu_count} to {len(cpu_components)} components")
    
    # Keep only top 40 GPUs sorted by price (descending)
    original_gpu_count = len(gpu_components)
    if len(gpu_components) > 40:
        gpu_components = sorted(gpu_components, key=lambda x: float(x.get('component_price', 0) or 0), reverse=True)[:40]
        print(f"Limited GPUs from {original_gpu_count} to {len(gpu_components)} components")
    
    # Keep only top 40 RAM modules sorted by price (descending), ensure at least 12
    original_memory_count = len(memory_components)
    if len(memory_components) < 12:
        print(f"⚠️ Only {len(memory_components)} RAM/Memory components found. Expected at least 12.")
    elif len(memory_components) > 40:
        memory_components = sorted(memory_components, key=lambda x: float(x.get('component_price', 0) or 0), reverse=True)[:40]
        print(f"Limited RAM from {original_memory_count} to {len(memory_components)} components")
    else:
        print(f"✅ RAM/Memory components: {len(memory_components)}")
    
    # Ensure at least 12 GPU/Graphics Card components
    if len(gpu_components) < 12:
        print(f"⚠️ Only {len(gpu_components)} GPU/Graphics Card components found. Expected at least 12.")
    else:
        print(f"✅ GPU/Graphics Card components: {len(gpu_components)}")
    
    return cpu_components + gpu_components + memory_components + other_components
