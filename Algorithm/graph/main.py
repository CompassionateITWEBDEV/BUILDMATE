from graph_upgrade import generate_upgrade_recommendations
from db_utils import fetch_build_components, fetch_all_components

def run_graph_upgrade_test(build_id):
    print(f"\n Testing Graph Algorithm for Build ID: {build_id}\n")

    # Step 1: Get the current build’s components
    current_build = fetch_build_components(build_id)
    print(" Current Build Components:")
    for comp in current_build:
        print(f"- {comp['component_name']} (${comp['component_price']})")

    # Step 2: Fetch all components from DB
    all_components = fetch_all_components()

    # Step 3: Run the graph-based upgrade algorithm
    recommendations = generate_upgrade_recommendations(current_build, all_components)

    # Step 4: Display results
    print("\n Recommended Upgrades:")
    for rec in recommendations:
        if rec["recommended_upgrade"]:
            print(f"{rec['current_component']} -> {rec['recommended_upgrade']} (${rec['new_price']})")
        else:
            print(f" No upgrade available for {rec['current_component']}")

if __name__ == "__main__":
    run_graph_upgrade_test(2)
