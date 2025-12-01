CATEGORY_ORDER = [
    "CPU", "Motherboard", "CPU Cooler", "Memory",
    "Storage", "Video Card", "Case", "Power Supply"
]

class CSPBacktracking:
    def __init__(self, components):
        self.components = components
        self.by_cat = {cat: [c for c in components if c["category"] == cat]
                       for cat in CATEGORY_ORDER}
        
        # Log component counts per category
        import logging
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
        
        # If no TDP info available, use conservative defaults based on components present
        if total == 0:
            # Default power requirements (conservative estimates)
            defaults = {
                "CPU": 65,  # Average CPU TDP
                "Video Card": 150,  # Average GPU TDP
                "Memory": 5,  # RAM power
                "Storage": 5,  # SSD power
                "Motherboard": 30,  # Motherboard power
                "CPU Cooler": 5,  # Cooler power (fans)
            }
            for cat, comp in partial_build.items():
                if comp and cat in defaults:
                    total += defaults[cat]
        
        # Add 20% buffer for safety
        return int(total * 1.2) if total > 0 else 400  # Default 400W if nothing calculated

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
            # Return default if value is None
            return value if value is not None else default

        # CPU ↔ Motherboard (only check if both have socket info)
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

        # CPU Cooler ↔ CPU socket (only check if both have socket info)
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

        # Memory ↔ Motherboard (only check if both have ram_type info)
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

        # PSU ↔ Total Power (only check if PSU has wattage and power requirement > 0)
        if cat == "Power Supply":
            psu_wattage = get_attr(new_component, "wattage", 0)
            power_req = self.calculate_power_requirement(partial_build)
            # Only enforce if PSU has wattage specified and power requirement is significant
            if psu_wattage > 0 and power_req > 0 and psu_wattage < power_req:
                return False
            # If no wattage specified, allow it (assume it's sufficient)

        # GPU ↔ Case (only check if both have size info and case has max dimensions)
        if cat == "Video Card" and pc_case:
            gpu_length = get_attr(new_component, "length", 0)
            gpu_height = get_attr(new_component, "height", 0)
            max_length = get_attr(pc_case, "maxGpuLength", 0)
            max_height = get_attr(pc_case, "maxCoolerHeight", 0)
            # Only check if case has max dimensions specified (not 0)
            if max_length > 0 and gpu_length > 0 and gpu_length > max_length:
                return False
            if max_height > 0 and gpu_height > 0 and gpu_height > max_height:
                return False
        if cat == "Case" and gpu:
            gpu_length = get_attr(gpu, "length", 0)
            gpu_height = get_attr(gpu, "height", 0)
            max_length = get_attr(new_component, "maxGpuLength", 0)
            max_height = get_attr(new_component, "maxCoolerHeight", 0)
            # Only check if case has max dimensions specified (not 0)
            if max_length > 0 and gpu_length > 0 and gpu_length > max_length:
                return False
            if max_height > 0 and gpu_height > 0 and gpu_height > max_height:
                return False

        # Cooler ↔ Case height (only check if both have height info and case has max height)
        if cat == "CPU Cooler" and pc_case:
            cooler_height = get_attr(new_component, "height", 0)
            max_height = get_attr(pc_case, "maxCoolerHeight", 0)
            # Only check if case has max height specified (not 0) and cooler has height
            if max_height > 0 and cooler_height > 0 and cooler_height > max_height:
                return False
        if cat == "Case" and cooler:
            cooler_height = get_attr(cooler, "height", 0)
            max_height = get_attr(new_component, "maxCoolerHeight", 0)
            # Only check if case has max height specified (not 0) and cooler has height
            if max_height > 0 and cooler_height > 0 and cooler_height > max_height:
                return False

        # Storage ↔ Motherboard (skip this check - storage is usually compatible)
        # Most motherboards support both SATA and M.2, so we'll allow all storage

        return True

    # Generator version of backtracking with early budget pruning
    def backtrack(self, categories, partial_build, budget):
        # Early pruning: if current partial build already exceeds budget, stop exploring
        current_cost = sum(c["price"] for c in partial_build.values() if c)
        if current_cost > budget:
            return  # Already over budget, no point continuing
        
        if not categories:
            if current_cost <= budget:
                yield partial_build.copy()
            return

        next_cat = categories[0]

        if next_cat in partial_build:
            yield from self.backtrack(categories[1:], partial_build, budget)
            return

        # Sort components by price (cheapest first) to find solutions faster
        available_components = sorted(
            self.by_cat.get(next_cat, []),
            key=lambda c: c.get("price", float('inf'))
        )
        
        # Filter out components with invalid prices
        available_components = [c for c in available_components if c.get("price", 0) > 0]
        
        if not available_components:
            # No valid components for this category, skip it
            return
        
        for comp in available_components:
            comp_price = comp.get("price", 0)
            # Early budget check: skip if adding this component would exceed budget
            if current_cost + comp_price > budget:
                continue  # Skip expensive components that would exceed budget
            
            if self.is_compatible(partial_build, comp):
                partial_build[next_cat] = comp
                yield from self.backtrack(categories[1:], partial_build, budget)
                del partial_build[next_cat]

    def solve(self, budget, user_inputs={}):
        partial_build = {}
        id_map = {c["id"]: c for c in self.components}

        # Build partial build from user inputs
        for cat, comp_id in user_inputs.items():
            if comp_id in id_map:
                partial_build[cat] = id_map[comp_id]

        # Validate budget: check if pre-selected components already exceed budget
        pre_selected_cost = sum(c["price"] for c in partial_build.values() if c)
        if pre_selected_cost > budget:
            # Pre-selected components exceed budget, return empty generator
            # This will be handled by the API to show appropriate error message
            return
            # Empty generator - no solutions possible

        remaining_cats = [c for c in CATEGORY_ORDER if c not in partial_build]
        return self.backtrack(remaining_cats, partial_build, budget)  # returns a generator