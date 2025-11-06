import networkx as nx

def generate_upgrade_recommendations(current_build, all_components):
    """
    Generates upgrade recommendations based on component prices
    and category similarity using a graph-based model.
    """

    # Build Graph
    G = nx.Graph()

    # Add nodes for all components
    for comp in all_components:
        G.add_node(
            comp["component_id"],
            name=comp["component_name"],
            category=comp["category_name"],
            price=comp["component_price"]
        )

    # Create edges between components of the same category (higher price = upgrade)
    for base in all_components:
        for candidate in all_components:
            if (
                base["category_name"] == candidate["category_name"]
                and candidate["component_price"] > base["component_price"]
            ):
                G.add_edge(base["component_id"], candidate["component_id"],
                           weight=candidate["component_price"] - base["component_price"])

    # Generate recommendations for the current build
    recommendations = []

    for comp in current_build:
        comp_id = comp["component_id"]
        comp_name = comp["component_name"]
        comp_price = comp["component_price"]

        # Check if component exists in the graph
        if comp_id not in G.nodes:
            recommendations.append({
                "current_component": comp_name,
                "recommended_upgrade": None,
                "new_price": None
            })
            continue

        # Get neighbors that are valid upgrades
        neighbors = []
        try:
            for n in G.neighbors(comp_id):
                if n in G.nodes and G.nodes[n].get("price", 0) > comp_price:
                    neighbors.append((
                        n, 
                        G.nodes[n].get("name", "Unknown"),
                        G.nodes[n].get("price", 0)
                    ))
        except (KeyError, AttributeError) as e:
            # If there's an error accessing neighbors, skip this component
            print(f"Warning: Could not get neighbors for component {comp_id}: {e}")
            neighbors = []

        if neighbors:
            # Pick the cheapest valid upgrade
            best_upgrade = sorted(neighbors, key=lambda x: x[2])[0]
            recommendations.append({
                "current_component": comp_name,
                "recommended_upgrade": best_upgrade[1],
                "new_price": best_upgrade[2]
            })
        else:
            recommendations.append({
                "current_component": comp_name,
                "recommended_upgrade": None,
                "new_price": None
            })

    return recommendations
