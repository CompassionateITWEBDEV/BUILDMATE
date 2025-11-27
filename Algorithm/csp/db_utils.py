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
