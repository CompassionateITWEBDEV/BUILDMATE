import networkx as nx
import json

def generate_upgrade_recommendations(current_build, all_components, budget=None, compatibility_info=None):
    """
    Generates upgrade recommendations based on component prices
    and category similarity using a graph-based model.
    Only recommends components that are within budget and compatible.
    
    Args:
        current_build: List of dicts with keys: component_id, component_name, component_price, category_name
        all_components: List of dicts with keys: component_id, component_name, component_price, category_name, compatibility_information
        budget: Optional budget limit (remaining budget after current build)
        compatibility_info: Optional dict with current build compatibility info (socket, memoryType, etc.)
    
    Returns:
        List of recommendation dicts with keys: current_component, recommended_upgrade, new_price, upgrade_cost
    """
    
    # Validate inputs
    if not all_components:
        print("Warning: No components available in database")
        return []
    
    if not current_build:
        print("Warning: No components in current build")
        return []

    # Build Graph
    G = nx.Graph()

    # Add nodes for all components (filter out None prices)
    for comp in all_components:
        comp_id = comp.get("component_id")
        comp_price = comp.get("component_price")
        
        # Skip components with missing data
        if comp_id is None or comp_price is None:
            continue
            
        G.add_node(
            comp_id,
            name=comp.get("component_name", "Unknown"),
            category=comp.get("category_name", "Unknown"),
            price=float(comp_price) if comp_price is not None else 0.0
        )

    # Create edges between components of the same category (higher price = upgrade)
    for base in all_components:
        base_id = base.get("component_id")
        base_price = base.get("component_price")
        base_category = base.get("category_name")
        
        if base_id is None or base_price is None or base_category is None:
            continue
            
        for candidate in all_components:
            candidate_id = candidate.get("component_id")
            candidate_price = candidate.get("component_price")
            candidate_category = candidate.get("category_name")
            
            if candidate_id is None or candidate_price is None or candidate_category is None:
                continue
                
            if (
                base_category == candidate_category
                and float(candidate_price) > float(base_price)
                and base_id != candidate_id
            ):
                G.add_edge(
                    base_id, 
                    candidate_id,
                    weight=float(candidate_price) - float(base_price)
                )

    # Calculate current build total price
    current_total = sum(float(c.get("component_price", 0) or 0) for c in current_build)
    remaining_budget = budget - current_total if budget else None
    
    # Parse compatibility info from current build
    current_socket = None
    current_memory_type = None
    if compatibility_info:
        current_socket = compatibility_info.get("socket")
        current_memory_type = compatibility_info.get("memoryType")
    else:
        # Try to extract from current build components
        for comp in current_build:
            compat_str = comp.get("compatibility_information")
            if compat_str:
                try:
                    if isinstance(compat_str, str):
                        compat_data = json.loads(compat_str)
                    else:
                        compat_data = compat_str
                    if not current_socket and "socket" in compat_data:
                        current_socket = compat_data["socket"]
                    if not current_memory_type and "memoryType" in compat_data:
                        current_memory_type = compat_data["memoryType"]
                except:
                    pass

    # Generate recommendations for the current build
    recommendations = []

    for comp in current_build:
        comp_id = comp.get("component_id")
        comp_name = comp.get("component_name", "Unknown Component")
        comp_price = comp.get("component_price")
        comp_category = comp.get("category_name")

        # Validate current build component
        if comp_id is None:
            recommendations.append({
                "current_component": comp_name,
                "recommended_upgrade": None,
                "new_price": None,
                "upgrade_cost": None
            })
            continue
            
        comp_price = float(comp_price) if comp_price is not None else 0.0

        # Check if component exists in the graph
        if comp_id not in G.nodes:
            recommendations.append({
                "current_component": comp_name,
                "recommended_upgrade": None,
                "new_price": None,
                "upgrade_cost": None
            })
            continue

        # Get neighbors that are valid upgrades
        valid_upgrades = []
        try:
            for n in G.neighbors(comp_id):
                if n not in G.nodes:
                    continue
                    
                neighbor_price = G.nodes[n].get("price", 0)
                neighbor_category = G.nodes[n].get("category", "")
                
                # Basic checks: same category and higher price
                if neighbor_price <= comp_price or neighbor_category != comp_category:
                    continue
                
                # Budget check: only recommend if within remaining budget
                upgrade_cost = neighbor_price - comp_price
                if remaining_budget is not None and upgrade_cost > remaining_budget:
                    continue
                
                # Compatibility check: find the component in all_components to check compatibility
                candidate_comp = next((c for c in all_components if c.get("component_id") == n), None)
                if candidate_comp:
                    # Check compatibility based on category
                    is_compatible = True
                    compat_str = candidate_comp.get("compatibility_information")
                    
                    if compat_str:
                        try:
                            if isinstance(compat_str, str):
                                compat_data = json.loads(compat_str)
                            else:
                                compat_data = compat_str
                            
                            # CPU/Motherboard: check socket and memory type
                            if comp_category in ["CPU", "Motherboard"]:
                                candidate_socket = compat_data.get("socket")
                                candidate_memory = compat_data.get("memoryType")
                                
                                if current_socket and candidate_socket and candidate_socket != current_socket:
                                    # For CPU upgrades, socket must match current motherboard
                                    # For motherboard upgrades, socket must match current CPU
                                    if comp_category == "CPU" or (comp_category == "Motherboard" and candidate_socket != current_socket):
                                        is_compatible = False
                                
                                if current_memory_type and candidate_memory:
                                    if isinstance(candidate_memory, list):
                                        if current_memory_type not in candidate_memory:
                                            is_compatible = False
                                    elif candidate_memory != current_memory_type:
                                        is_compatible = False
                            
                            # Memory: check memory type compatibility
                            elif comp_category == "Memory":
                                candidate_memory = compat_data.get("type") or compat_data.get("memoryType")
                                if current_memory_type and candidate_memory:
                                    if isinstance(candidate_memory, list):
                                        if current_memory_type not in candidate_memory:
                                            is_compatible = False
                                    elif candidate_memory != current_memory_type:
                                        is_compatible = False
                        except Exception as e:
                            print(f"Warning: Could not parse compatibility for component {n}: {e}")
                    
                    if is_compatible:
                        valid_upgrades.append((
                            n, 
                            G.nodes[n].get("name", "Unknown"),
                            neighbor_price,
                            upgrade_cost
                        ))
        except (KeyError, AttributeError) as e:
            # If there's an error accessing neighbors, skip this component
            print(f"Warning: Could not get neighbors for component {comp_id}: {e}")
            valid_upgrades = []

        if valid_upgrades:
            # Pick the cheapest valid upgrade (lowest upgrade cost)
            best_upgrade = sorted(valid_upgrades, key=lambda x: x[3])[0]
            recommendations.append({
                "current_component": comp_name,
                "recommended_upgrade": best_upgrade[1],
                "new_price": float(best_upgrade[2]),
                "upgrade_cost": float(best_upgrade[3])
            })
        else:
            recommendations.append({
                "current_component": comp_name,
                "recommended_upgrade": None,
                "new_price": None,
                "upgrade_cost": None
            })

    return recommendations
