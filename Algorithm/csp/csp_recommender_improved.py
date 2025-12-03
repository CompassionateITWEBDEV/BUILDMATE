CATEGORY_ORDER = [
    "CPU", "Motherboard", "CPU Cooler", "Memory",
    "Storage", "Video Card", "Case", "Power Supply"
]

import random
import logging

# Budget allocation percentages per category (as % of total budget)
# These are flexible guidelines, not hard constraints
BUDGET_ALLOCATION = {
    "academic": {
        "CPU": 0.25,          # 25% - Most important for basic tasks
        "Motherboard": 0.15,  # 15%
        "Memory": 0.15,       # 15%
        "Storage": 0.15,      # 15%
        "Video Card": 0.10,   # 10% - Budget/integrated graphics
        "Power Supply": 0.10, # 10%
        "Case": 0.05,         # 5%
        "CPU Cooler": 0.05,   # 5%
    },
    "office": {
        "CPU": 0.25,          # 25%
        "Motherboard": 0.15,  # 15%
        "Memory": 0.18,       # 18% - More RAM for multitasking
        "Storage": 0.17,      # 17% - SSD for faster boot
        "Video Card": 0.08,   # 8% - Integrated or basic
        "Power Supply": 0.10, # 10%
        "Case": 0.05,         # 5%
        "CPU Cooler": 0.02,   # 2%
    },
    "gaming": {
        "CPU": 0.20,          # 20%
        "Video Card": 0.35,   # 35% - Most important for gaming
        "Motherboard": 0.12,  # 12%
        "Memory": 0.12,       # 12%
        "Storage": 0.08,      # 8%
        "Power Supply": 0.08, # 8%
        "Case": 0.03,         # 3%
        "CPU Cooler": 0.02,   # 2%
    }
}

def get_budget_range_for_category(budget, category, performance_category="gaming"):
    """
    Calculate min and max budget for a category based on total budget
    Returns (min_budget, max_budget) as tuple
    """
    allocation = BUDGET_ALLOCATION.get(performance_category, BUDGET_ALLOCATION["gaming"])
    target_percent = allocation.get(category, 0.10)
    
    # Allow flexibility: -50% to +100% of target allocation
    min_percent = target_percent * 0.5
    max_percent = target_percent * 2.0
    
    min_budget = budget * min_percent
    max_budget = budget * max_percent
    
    return (min_budget, max_budget)

class CSPBacktracking:
    def __init__(self, components, performance_category="gaming"):
        self.components = components
        self.performance_category = performance_category
        self.by_cat = {cat: [c for c in components if c["category"] == cat]
                       for cat in CATEGORY_ORDER}
        
        # Shuffle components once at initialization for variety
        for cat in CATEGORY_ORDER:
            random.shuffle(self.by_cat[cat])
        
        # Log component counts per category
        for cat in CATEGORY_ORDER:
            count = len(self.by_cat.get(cat, []))
            if count > 0:
                logging.info("CSP: Category '%s' has %d components", cat, count)
            else:
                logging.warning("CSP: Category '%s' has NO components!", cat)

    def calculate_power_requirement(self, partial_build):
        total = 0
        for cat, comp in partial_build.items():
            if not comp or cat == "Power Supply":
                continue
            tdp = comp.get("attrs", {}).get("tdp", 0) or comp.get("attrs", {}).get("powerRequirement", 0)
            total += tdp
        
        # If no TDP info available, use conservative defaults
        if total == 0:
            defaults = {
                "CPU": 65,
                "Video Card": 150,
                "Memory": 5,
                "Storage": 5,
                "Motherboard": 30,
                "CPU Cooler": 5,
            }
            for cat, comp in partial_build.items():
                if comp and cat in defaults:
                    total += defaults[cat]
        
        return int(total * 1.2) if total > 0 else 400

    def get_case_max_gpu_length(self, case):
        return case.get("attrs", {}).get("maxGpuLength", 0)

    def get_case_max_gpu_height(self, case):
        return case.get("attrs", {}).get("maxCoolerHeight", 0)

    def is_compatible(self, partial_build, new_component):
        cat = new_component["category"]
        cpu = partial_build.get("CPU")
        mobo = partial_build.get("Motherboard")
        cooler = partial_build.get("CPU Cooler")
        ram = partial_build.get("Memory")
        gpu = partial_build.get("Video Card")
        pc_case = partial_build.get("Case")
        psu = partial_build.get("Power Supply")
        storage = partial_build.get("Storage")

        def get_attr(comp, key, default=None):
            if not comp:
                return default
            attrs = comp.get("attrs") or {}
            value = attrs.get(key, default)
            return value if value is not None else default

        # CPU ↔ Motherboard
        if cat == "Motherboard" and cpu:
            cpu_socket = get_attr(cpu, "socket")
            mobo_socket = get_attr(new_component, "socket")
            if cpu_socket and mobo_socket and cpu_socket != mobo_socket:
                return False
        if cat == "CPU" and mobo:
            cpu_socket = get_attr(new_component, "socket")
            mobo_socket = get_attr(mobo, "socket")
            if cpu_socket and mobo_socket and cpu_socket != mobo_socket:
                return False

        # CPU Cooler ↔ CPU socket
        if cat == "CPU Cooler" and cpu:
            cpu_socket = get_attr(cpu, "socket")
            supported = get_attr(new_component, "supported_sockets", [])
            if cpu_socket and supported and cpu_socket not in supported:
                return False
        if cat == "CPU" and cooler:
            cpu_socket = get_attr(new_component, "socket")
            supported = get_attr(cooler, "supported_sockets", [])
            if cpu_socket and supported and cpu_socket not in supported:
                return False

        # Memory ↔ Motherboard
        if cat == "Memory" and mobo:
            ram_type = get_attr(new_component, "ram_type")
            mobo_ram_type = get_attr(mobo, "ram_type")
            if ram_type and mobo_ram_type and ram_type != mobo_ram_type:
                return False
        if cat == "Motherboard" and ram:
            ram_type = get_attr(ram, "ram_type")
            mobo_ram_type = get_attr(new_component, "ram_type")
            if ram_type and mobo_ram_type and ram_type != mobo_ram_type:
                return False

        # PSU ↔ Total Power
        if cat == "Power Supply":
            psu_wattage = get_attr(new_component, "wattage", 0)
            power_req = self.calculate_power_requirement(partial_build)
            if psu_wattage > 0 and power_req > 0 and psu_wattage < power_req:
                return False

        # GPU ↔ Case
        if cat == "Video Card" and pc_case:
            gpu_length = get_attr(new_component, "length", 0)
            gpu_height = get_attr(new_component, "height", 0)
            max_length = get_attr(pc_case, "maxGpuLength", 0)
            max_height = get_attr(pc_case, "maxCoolerHeight", 0)
            if max_length > 0 and gpu_length > 0 and gpu_length > max_length:
                return False
            if max_height > 0 and gpu_height > 0 and gpu_height > max_height:
                return False
        if cat == "Case" and gpu:
            gpu_length = get_attr(gpu, "length", 0)
            gpu_height = get_attr(gpu, "height", 0)
            max_length = get_attr(new_component, "maxGpuLength", 0)
            max_height = get_attr(new_component, "maxCoolerHeight", 0)
            if max_length > 0 and gpu_length > 0 and gpu_length > max_length:
                return False
            if max_height > 0 and gpu_height > 0 and gpu_height > max_height:
                return False

        # Cooler ↔ Case height
        if cat == "CPU Cooler" and pc_case:
            cooler_height = get_attr(new_component, "height", 0)
            max_height = get_attr(pc_case, "maxCoolerHeight", 0)
            if max_height > 0 and cooler_height > 0 and cooler_height > max_height:
                return False
        if cat == "Case" and cooler:
            cooler_height = get_attr(cooler, "height", 0)
            max_height = get_attr(new_component, "maxCoolerHeight", 0)
            if max_height > 0 and cooler_height > 0 and cooler_height > max_height:
                return False

        return True

    def backtrack(self, categories, partial_build, budget):
        # Early pruning: if current partial build already exceeds budget
        current_cost = sum(c["price"] for c in partial_build.values() if c)
        if current_cost > budget:
            return
        
        if not categories:
            if current_cost <= budget:
                yield partial_build.copy()
            return

        next_cat = categories[0]
        remaining_budget = budget - current_cost
        remaining_categories = len(categories)

        if next_cat in partial_build:
            yield from self.backtrack(categories[1:], partial_build, budget)
            return

        # Get components for this category
        available_components = self.by_cat.get(next_cat, [])
        
        # Filter out components with invalid prices
        available_components = [c for c in available_components if c.get("price", 0) > 0]
        
        if not available_components:
            return
        
        # Get budget range for this category
        min_budget, max_budget = get_budget_range_for_category(
            budget, next_cat, self.performance_category
        )
        
        # Sort components by price to try cheaper ones first (more likely to fit budget)
        available_components_sorted = sorted(available_components, key=lambda x: x.get("price", 0))
        
        for comp in available_components_sorted:
            comp_price = comp.get("price", 0)
            
            # Skip if exceeds total budget
            if current_cost + comp_price > budget:
                continue
            
            # Smart budget check: 
            # - Allow components within budget range
            # - If below min, only use if it leaves enough budget for remaining categories
            # - If above max, skip (too expensive for this category)
            if comp_price > max_budget:
                continue  # Too expensive for this category
            
            if comp_price < min_budget:
                # Too cheap - check if it leaves enough for remaining categories
                avg_remaining_budget_per_category = remaining_budget / max(remaining_categories, 1)
                if comp_price < avg_remaining_budget_per_category * 0.3:
                    # Too cheap, might result in unbalanced build
                    continue
            
            if self.is_compatible(partial_build, comp):
                partial_build[next_cat] = comp
                yield from self.backtrack(categories[1:], partial_build, budget)
                del partial_build[next_cat]

    def solve(self, budget, user_inputs={}, performance_category="gaming"):
        # Update performance category
        self.performance_category = performance_category
        
        partial_build = {}
        id_map = {c["id"]: c for c in self.components}

        # Build partial build from user inputs
        for cat, comp_id in user_inputs.items():
            if comp_id in id_map:
                partial_build[cat] = id_map[comp_id]

        # Validate budget
        pre_selected_cost = sum(c["price"] for c in partial_build.values() if c)
        if pre_selected_cost > budget:
            return

        remaining_cats = [c for c in CATEGORY_ORDER if c not in partial_build]
        
        # Track unique solutions to avoid duplicates
        seen_solutions = set()
        
        for solution in self.backtrack(remaining_cats, partial_build, budget):
            solution_signature = tuple(sorted(
                (cat, comp["id"]) for cat, comp in solution.items() if comp
            ))
            
            if solution_signature not in seen_solutions:
                seen_solutions.add(solution_signature)
                yield solution


