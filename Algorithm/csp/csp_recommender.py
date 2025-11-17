CATEGORY_ORDER = [
    "CPU", "Motherboard", "CPU Cooler", "Memory",
    "Storage", "Video Card", "Case", "Power Supply"
]

class CSPBacktracking:
    def __init__(self, components):
        self.components = components
        self.by_cat = {cat: [c for c in components if c["category"] == cat]
                       for cat in CATEGORY_ORDER}

    def calculate_power_requirement(self, partial_build):
        total = 0
        for cat, comp in partial_build.items():
            if not comp or cat == "Power Supply":
                continue
            total += comp.get("attrs", {}).get("tdp", 0) or comp.get("attrs", {}).get("powerRequirement", 0)
        return total

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
            return (comp.get("attrs") or {}).get(key, default) if comp else default

        # CPU ↔ Motherboard
        if cat == "Motherboard" and cpu:
            if get_attr(cpu, "socket") != get_attr(new_component, "socket"):
                return False
        if cat == "CPU" and mobo:
            if get_attr(new_component, "socket") != get_attr(mobo, "socket"):
                return False

        # CPU Cooler ↔ CPU socket
        if cat == "CPU Cooler" and cpu:
            if get_attr(cpu, "socket") not in get_attr(new_component, "supported_sockets", []):
                return False
        if cat == "CPU" and cooler:
            if get_attr(new_component, "socket") not in get_attr(cooler, "supported_sockets", []):
                return False

        # Memory ↔ Motherboard
        if cat == "Memory" and mobo:
            if get_attr(new_component, "ram_type") != get_attr(mobo, "ram_type"):
                return False
        if cat == "Motherboard" and ram:
            if get_attr(new_component, "ram_type") != get_attr(ram, "ram_type"):
                return False

        # PSU ↔ Total Power
        if cat == "Power Supply":
            if get_attr(new_component, "wattage", 0) < self.calculate_power_requirement(partial_build):
                return False

        # GPU ↔ Case
        if cat == "Video Card" and pc_case:
            if get_attr(new_component, "length", 0) > get_attr(pc_case, "maxGpuLength", 0) or \
               get_attr(new_component, "height", 0) > get_attr(pc_case, "maxCoolerHeight", 0):
                return False
        if cat == "Case" and gpu:
            if get_attr(gpu, "length", 0) > get_attr(new_component, "maxGpuLength", 0) or \
               get_attr(gpu, "height", 0) > get_attr(new_component, "maxCoolerHeight", 0):
                return False

        # Cooler ↔ Case height
        if cat == "CPU Cooler" and pc_case:
            if get_attr(new_component, "height", 0) > get_attr(pc_case, "maxCoolerHeight", 0):
                return False
        if cat == "Case" and cooler:
            if get_attr(cooler, "height", 0) > get_attr(new_component, "maxCoolerHeight", 0):
                return False

        # Storage ↔ Motherboard
        if cat == "Storage" and mobo:
            interface = (new_component.get("specs") or {}).get("interface", "")
            if interface == "M.2" and int((mobo.get("specs") or {}).get("m2Slots", 0)) == 0:
                return False
            if interface == "SATA" and int((mobo.get("specs") or {}).get("sataPorts", 0)) == 0:
                return False

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
        
        for comp in available_components:
            # Early budget check: skip if adding this component would exceed budget
            if current_cost + comp.get("price", 0) > budget:
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
