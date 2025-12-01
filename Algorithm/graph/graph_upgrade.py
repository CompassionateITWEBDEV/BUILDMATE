import networkx as nx
import json

def get_attr(comp, key, default=None):
    """Helper to get attribute from component's compatibility_information"""
    compat_str = comp.get("compatibility_information")
    if not compat_str:
        return default
    try:
        if isinstance(compat_str, str):
            compat_data = json.loads(compat_str)
        else:
            compat_data = compat_str
        return compat_data.get(key, default)
    except:
        return default

def calculate_power_requirement(current_build):
    """Calculate total power requirement from current build"""
    total = 0
    defaults = {
        "CPU": 65,
        "Video Card": 150,
        "GPU": 150,
        "Memory": 5,
        "RAM": 5,
        "Storage": 5,
        "Motherboard": 30,
        "CPU Cooler": 5,
        "Cooling": 5,
    }
    
    for comp in current_build:
        category = comp.get("category_name", "")
        # Try to get TDP from compatibility info
        tdp = get_attr(comp, "tdp", 0) or get_attr(comp, "powerRequirement", 0)
        if tdp:
            total += tdp
        elif category in defaults:
            total += defaults[category]
    
    # Add 20% buffer
    return int(total * 1.2) if total > 0 else 400

def check_component_compatibility(candidate_comp, comp_category, current_build, current_socket=None, current_memory_type=None):
    """
    Check if a candidate component is compatible with the current build.
    Implements same compatibility rules as CSP recommender.
    """
    is_compatible = True
    compat_str = candidate_comp.get("compatibility_information")
    
    # Build a dict of current build components by category for easier lookup
    build_dict = {}
    for comp in current_build:
        cat = comp.get("category_name")
        if cat:
            build_dict[cat] = comp
    
    # Get candidate component's compatibility data
    candidate_attrs = {}
    if compat_str:
        try:
            if isinstance(compat_str, str):
                candidate_attrs = json.loads(compat_str)
            else:
                candidate_attrs = compat_str
        except Exception as e:
            print(f"Warning: Could not parse compatibility for candidate: {e}")
    
    # === CPU/Motherboard socket compatibility ===
    if comp_category == "CPU":
        candidate_socket = candidate_attrs.get("socket")
        mobo = build_dict.get("Motherboard")
        if mobo and candidate_socket:
            mobo_socket = get_attr(mobo, "socket")
            if mobo_socket and candidate_socket != mobo_socket:
                return False
        # Also check against current_socket if provided
        if current_socket and candidate_socket and candidate_socket != current_socket:
            return False
    
    elif comp_category == "Motherboard":
        candidate_socket = candidate_attrs.get("socket")
        candidate_memory = candidate_attrs.get("memoryType")
        
        # Check CPU socket compatibility
        cpu = build_dict.get("CPU")
        if cpu and candidate_socket:
            cpu_socket = get_attr(cpu, "socket")
            if cpu_socket and candidate_socket != cpu_socket:
                return False
        
        # Check memory type compatibility
        ram = build_dict.get("Memory") or build_dict.get("RAM")
        if ram and candidate_memory:
            ram_type = get_attr(ram, "ram_type") or get_attr(ram, "type") or get_attr(ram, "memoryType")
            if ram_type:
                if isinstance(candidate_memory, list):
                    if ram_type not in candidate_memory:
                        return False
                elif candidate_memory != ram_type:
                    return False
        
        # Check against current_memory_type if provided
        if current_memory_type and candidate_memory:
            if isinstance(candidate_memory, list):
                if current_memory_type not in candidate_memory:
                    return False
            elif candidate_memory != current_memory_type:
                return False
    
    # === CPU Cooler socket and height compatibility ===
    elif comp_category == "CPU Cooler" or comp_category == "Cooling":
        # Check socket compatibility
        candidate_sockets = candidate_attrs.get("supported_sockets", [])
        cpu = build_dict.get("CPU")
        if cpu and candidate_sockets:
            cpu_socket = get_attr(cpu, "socket")
            if cpu_socket and cpu_socket not in candidate_sockets:
                return False
        if current_socket and candidate_sockets and current_socket not in candidate_sockets:
            return False
        
        # Check case height compatibility
        candidate_height = candidate_attrs.get("height", 0)
        case = build_dict.get("Case")
        if case and candidate_height:
            max_height = get_attr(case, "maxCoolerHeight", 0)
            if max_height > 0 and candidate_height > max_height:
                return False
    
    # === Memory/RAM compatibility ===
    elif comp_category in ["Memory", "RAM"]:
        candidate_memory = candidate_attrs.get("type") or candidate_attrs.get("memoryType") or candidate_attrs.get("ram_type")
        mobo = build_dict.get("Motherboard")
        if mobo and candidate_memory:
            mobo_memory = get_attr(mobo, "memoryType") or get_attr(mobo, "ram_type")
            if mobo_memory:
                if isinstance(mobo_memory, list):
                    if candidate_memory not in mobo_memory:
                        return False
                elif candidate_memory != mobo_memory:
                    return False
        
        if current_memory_type and candidate_memory:
            if candidate_memory != current_memory_type:
                return False
    
    # === GPU/Video Card case size compatibility ===
    elif comp_category in ["Video Card", "GPU"]:
        candidate_length = candidate_attrs.get("length", 0)
        candidate_height = candidate_attrs.get("height", 0)
        case = build_dict.get("Case")
        if case:
            max_length = get_attr(case, "maxGpuLength", 0)
            max_height = get_attr(case, "maxCoolerHeight", 0)
            if max_length > 0 and candidate_length > 0 and candidate_length > max_length:
                return False
            if max_height > 0 and candidate_height > 0 and candidate_height > max_height:
                return False
    
    # === Power Supply wattage compatibility ===
    elif comp_category == "Power Supply":
        candidate_wattage = candidate_attrs.get("wattage", 0)
        if candidate_wattage > 0:
            power_req = calculate_power_requirement(current_build)
            if power_req > 0 and candidate_wattage < power_req:
                return False
    
    # === Case compatibility checks ===
    elif comp_category == "Case":
        max_gpu_length = candidate_attrs.get("maxGpuLength", 0)
        max_cooler_height = candidate_attrs.get("maxCoolerHeight", 0)
        
        # Check GPU size
        gpu = build_dict.get("Video Card") or build_dict.get("GPU")
        if gpu and max_gpu_length > 0:
            gpu_length = get_attr(gpu, "length", 0)
            if gpu_length > 0 and gpu_length > max_gpu_length:
                return False
        
        # Check CPU cooler height
        cooler = build_dict.get("CPU Cooler") or build_dict.get("Cooling")
        if cooler and max_cooler_height > 0:
            cooler_height = get_attr(cooler, "height", 0)
            if cooler_height > 0 and cooler_height > max_cooler_height:
                return False
    
    return is_compatible

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
                    is_compatible = check_component_compatibility(
                        candidate_comp, comp_category, current_build, 
                        current_socket, current_memory_type
                    )
                    
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
