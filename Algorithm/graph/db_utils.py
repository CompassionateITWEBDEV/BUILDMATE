import requests

# Supabase configuration (Kani ra ireplace or naa kay suggestion nga mas better)
SUPABASE_URL = "https://sldiqjjgddegffbzjqma.supabase.co"
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNsZGlxampnZGRlZ2ZmYnpqcW1hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTc1MjA1MDMsImV4cCI6MjA3MzA5NjUwM30.wir0lfBKEo0NimhsPjLmJvXexFjyQTmyHzGsE40xDmA"
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
    url = f"{SUPABASE_URL}/rest/v1/components?select=component_id,component_name,component_price,category_id,component_categories(category_name)"
    res = requests.get(url, headers=headers)
    data = res.json()

    return [
        {
            "component_id": d["component_id"],
            "component_name": d["component_name"],
            "component_price": d["component_price"],
            "category_name": d["component_categories"]["category_name"]
        }
        for d in data
    ]
