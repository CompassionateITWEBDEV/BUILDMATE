from db_utils import fetch_all_components
from csp_recommender import CSPBacktracking, REQUIRED_CATEGORIES

def run_csp_example():
    components = fetch_all_components()
    print(f"Fetched {len(components)} components from Supabase.")

    recommender = CSPBacktracking(components)

    # Example: user pre-selects CPU id = 1
    user_cpu_id = 35
    id_map = {c["id"]: c for c in components}

    if user_cpu_id not in id_map:
        print("CPU with that ID not found.")
        return

    cpu = id_map[user_cpu_id]
    name = cpu.get("component_name") or cpu.get("name", "Unknown")
    attrs = cpu.get("attrs") or cpu.get("attributes", {})

    print(f"\nSelected CPU: {name} (Socket: {attrs.get('socket', 'N/A')})")

    # Check compatibility of other components with this CPU
    compatible = {}

    for cat, comps in recommender.by_cat.items():
        if cat == "CPU":
            continue  # skip itself
        compatible[cat] = []
        for comp in comps:
            comp_attrs = comp.get("attrs") or comp.get("attributes", {})
            comp_name = comp.get("component_name") or comp.get("name", "Unknown")

            # Check compatibility with CPU
            if recommender.is_compatible({"CPU": cpu}, comp):
                compatible[cat].append({
                    "name": comp_name,
                    "price": comp.get("component_price") or comp.get("price", 0)
                })

    # Print compatible parts
    print("\nCompatible components found:")
    for cat, comps in compatible.items():
        print(f"\n{cat}:")
        if comps:
            for c in comps:
                print(f" - {c['name']} (${c['price']})")
        else:
            print("   No compatible components found.")

if __name__ == "__main__":
    run_csp_example()
