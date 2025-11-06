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

def fetch_all_components():
    """Fetch all components with category and compatibility info."""
    url = f"{SUPABASE_URL}/rest/v1/components?select=component_id,component_name,component_price,compatibility_information,category_id,component_categories(category_name)"
    response = requests.get(url, headers=headers)

    if response.status_code == 200:
        return response.json()
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
