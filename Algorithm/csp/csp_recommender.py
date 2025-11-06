# Components will be passed in, no need to import db_utils here

# Define the essential categories for a full build
REQUIRED_CATEGORIES = [
    "CPU", "CPU Cooler", "Motherboard", "Memory", 
    "Storage", "Video Card", "Case", "Power Supply"
]

class CSPBacktracking:
    def __init__(self, components):
        self.components = components
        self.by_cat = {cat: [c for c in components if c["category"] == cat] 
                       for cat in REQUIRED_CATEGORIES}

    def is_compatible(self, partial_build, new_component):
        """
        Check compatibility of the new component with the partial build.
        Extend rules as needed.
        """
        cat = new_component["category"]

        # CPU ↔ Motherboard
        if cat == "Motherboard":
            cpu = partial_build.get("CPU")
            if cpu and new_component["attrs"].get("socket") != cpu["attrs"].get("socket"):
                return False
        if cat == "CPU":
            mobo = partial_build.get("Motherboard")
            if mobo and new_component["attrs"].get("socket") != mobo["attrs"].get("socket"):
                return False

        # CPU Cooler ↔ CPU socket
        if cat == "CPU Cooler":
            cpu = partial_build.get("CPU")
            if cpu:
                supported_sockets = new_component["attrs"].get("supported_sockets", [])
                if cpu["attrs"].get("socket") not in supported_sockets:
                    return False
        if cat == "CPU":
            cooler = partial_build.get("CPU Cooler")
            if cooler:
                supported_sockets = cooler["attrs"].get("supported_sockets", [])
                if new_component["attrs"].get("socket") not in supported_sockets:
                    return False

        # Memory ↔ Motherboard
        if cat == "Memory":
            mobo = partial_build.get("Motherboard")
            if mobo and new_component["attrs"].get("ram_type") != mobo["attrs"].get("ram_type"):
                return False
        if cat == "Motherboard":
            ram = partial_build.get("Memory")
            if ram and new_component["attrs"].get("ram_type") != ram["attrs"].get("ram_type"):
                return False

        # PSU ↔ total power draw
        if cat == "Power Supply":
            cpu = partial_build.get("CPU")
            gpu = partial_build.get("Video Card")
            total_tdp = 0
            if cpu:
                total_tdp += cpu["attrs"].get("tdp", 0)
            if gpu:
                total_tdp += gpu["attrs"].get("tdp", 0)
            if total_tdp > new_component["attrs"].get("wattage", 0):
                return False

        return True

    def backtrack(self, categories, partial_build, budget, solutions):
        if not categories:  # all categories filled
            total_cost = sum(c["price"] for c in partial_build.values())
            if total_cost <= budget:
                solutions.append(dict(partial_build))
            return

        next_cat = categories[0]
        for comp in self.by_cat.get(next_cat, []):
            # Budget pruning
            current_cost = sum(c["price"] for c in partial_build.values())
            if current_cost + comp["price"] > budget:
                continue

            # Compatibility pruning
            if not self.is_compatible(partial_build, comp):
                continue

            # Assign and recurse
            partial_build[next_cat] = comp
            self.backtrack(categories[1:], partial_build, budget, solutions)
            del partial_build[next_cat]  # backtrack

    def solve(self, budget, user_inputs):
        """
        user_inputs = { "CPU": <component_id>, "Video Card": <component_id> }
        Only fill missing categories.
        """
        partial_build = {}
        id_map = {c["id"]: c for c in self.components}

        # Fill pre-selected parts
        for cat, comp_id in user_inputs.items():
            if comp_id in id_map:
                partial_build[cat] = id_map[comp_id]

        # Remaining categories
        remaining_cats = [c for c in REQUIRED_CATEGORIES if c not in partial_build]

        solutions = []
        self.backtrack(remaining_cats, partial_build, budget, solutions)
        return solutions
