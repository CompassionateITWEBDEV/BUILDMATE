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

    # Generator version of backtracking
    def backtrack(self, categories, partial_build, budget):
        if not categories:
            total_cost = sum(c["price"] for c in partial_build.values())
            if total_cost <= budget:
                yield partial_build.copy()
            return

        next_cat = categories[0]

        if next_cat in partial_build:
            yield from self.backtrack(categories[1:], partial_build, budget)
            return

        for comp in self.by_cat.get(next_cat, []):
            if self.is_compatible(partial_build, comp):
                partial_build[next_cat] = comp
                yield from self.backtrack(categories[1:], partial_build, budget)
                del partial_build[next_cat]

    def solve(self, budget, user_inputs={}):
        partial_build = {}
        id_map = {c["id"]: c for c in self.components}

        for cat, comp_id in user_inputs.items():
            if comp_id in id_map:
                partial_build[cat] = id_map[comp_id]

        remaining_cats = [c for c in CATEGORY_ORDER if c not in partial_build]
        return self.backtrack(remaining_cats, partial_build, budget)  # returns a generator
