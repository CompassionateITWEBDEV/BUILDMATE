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

        neighbors = [
            (n, G.nodes[n]["name"], G.nodes[n]["price"])
            for n in G.neighbors(comp_id)
            if G.nodes[n]["price"] > comp_price
        ]

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
