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

def fetch_all_components(performance_category=None):
    """Fetch all components with category and compatibility info.
    
    Args:
        performance_category: Optional performance category to filter by (gaming, academic, office)
    """
    # Build URL with optional performance category filter
    base_url = f"{SUPABASE_URL}/rest/v1/components?select=component_id,component_name,component_price,compatibility_information,category_id,component_purpose,component_categories(category_name)"
    
    # Add filter for performance category if specified
    if performance_category and performance_category != 'all':
        # Filter by component_purpose matching the performance category
        url = f"{base_url}&component_purpose=ilike.{performance_category}"
    else:
        url = base_url
    
    response = requests.get(url, headers=headers)

    if response.status_code == 200:
        components = response.json()
        # If performance category specified, also include components with null component_purpose (they work for all)
        if performance_category and performance_category != 'all':
            # Fetch components without component_purpose (null) - these work for all categories
            null_url = f"{SUPABASE_URL}/rest/v1/components?select=component_id,component_name,component_price,compatibility_information,category_id,component_purpose,component_categories(category_name)&component_purpose=is.null"
            null_response = requests.get(null_url, headers=headers)
            if null_response.status_code == 200:
                null_components = null_response.json()
                # Combine and remove duplicates
                component_ids = {c['component_id'] for c in components}
                for comp in null_components:
                    if comp['component_id'] not in component_ids:
                        components.append(comp)
        
        # LIMIT CPU, GPU, RAM components (50 max each) for performance
        # IMPORTANT: Include both cheap and expensive components to support all budgets
        cpu_components = [c for c in components if c.get('category_id') == 1]
        gpu_components = [c for c in components if c.get('category_id') == 5]  # GPU/Video Card is category_id 5
        memory_components = [c for c in components if c.get('category_id') == 3]  # Memory/RAM is category_id 3
        other_components = [c for c in components if c.get('category_id') not in [1, 3, 5]]
        
        # Keep 50 CPUs with mix of cheap and expensive (25 cheapest + 25 most expensive)
        print("🔄 NEW CODE RUNNING - Loading cheap + expensive components")
        original_cpu_count = len(cpu_components)
        if len(cpu_components) > 50:
            sorted_cpus = sorted(cpu_components, key=lambda x: float(x.get('component_price', 0) or 0))
            cheap_cpus = sorted_cpus[:25]  # 25 cheapest
            expensive_cpus = sorted_cpus[-25:]  # 25 most expensive
            cpu_components = cheap_cpus + expensive_cpus
            print(f"Limited CPUs from {original_cpu_count} to {len(cpu_components)} components (25 cheap + 25 expensive)")
        
        # Keep 50 GPUs with mix of cheap and expensive (25 cheapest + 25 most expensive)
        original_gpu_count = len(gpu_components)
        if len(gpu_components) > 50:
            sorted_gpus = sorted(gpu_components, key=lambda x: float(x.get('component_price', 0) or 0))
            cheap_gpus = sorted_gpus[:25]  # 25 cheapest
            expensive_gpus = sorted_gpus[-25:]  # 25 most expensive
            gpu_components = cheap_gpus + expensive_gpus
            print(f"Limited GPUs from {original_gpu_count} to {len(gpu_components)} components (25 cheap + 25 expensive)")
        
        # Keep 50 RAM modules with mix of cheap and expensive, ensure at least 12
        original_memory_count = len(memory_components)
        if len(memory_components) < 12:
            print(f"⚠️ Only {len(memory_components)} RAM/Memory components found. Expected at least 12.")
        elif len(memory_components) > 50:
            sorted_memory = sorted(memory_components, key=lambda x: float(x.get('component_price', 0) or 0))
            cheap_memory = sorted_memory[:25]  # 25 cheapest
            expensive_memory = sorted_memory[-25:]  # 25 most expensive
            memory_components = cheap_memory + expensive_memory
            print(f"Limited RAM from {original_memory_count} to {len(memory_components)} components (25 cheap + 25 expensive)")
        else:
            print(f"✅ RAM/Memory components: {len(memory_components)}")
        
        # Ensure at least 12 GPU/Graphics Card components
        if len(gpu_components) < 12:
            print(f"⚠️ Only {len(gpu_components)} GPU/Graphics Card components found. Expected at least 12.")
        else:
            print(f"✅ GPU/Graphics Card components: {len(gpu_components)}")
        
        components = cpu_components + gpu_components + memory_components + other_components
        return components
    else:
        print("Failed to fetch components:", response.text)
        return []

def fetch_component_by_id(component_id):
    """Fetch single component by ID."""
    url = f"{SUPABASE_URL}/rest/v1/components?component_id=eq.{component_id}&select=*"
    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        data = response.json()
        return data[0] if data else None
    else:
        print("Error fetching component:", response.text)
        return None

def fetch_components_by_category(category_name):
    """Fetch components by category name."""
    url = f"{SUPABASE_URL}/rest/v1/components?select=*,component_categories!inner(category_name=eq.{category_name})"
    response = requests.get(url, headers=headers)
    if response.status_code == 200:
        return response.json()
    else:
        print("Error fetching category:", response.text)
        return []
