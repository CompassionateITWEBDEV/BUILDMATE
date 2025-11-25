import logging
from flask import Flask, request, jsonify
from flask_cors import CORS
import sys, os, json
import importlib.util
import re

# Configure logging
logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(message)s")

# Add both 'csp' and 'graph' directories to Python path
csp_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'csp'))
graph_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'graph'))
sys.path.insert(0, csp_path)
sys.path.insert(0, graph_path)

# Import CSP solver and graph upgrade modules
from csp_recommender import CSPBacktracking
from graph_upgrade import generate_upgrade_recommendations

# Load db_utils modules dynamically
csp_db_spec = importlib.util.spec_from_file_location("csp_db_utils", os.path.join(csp_path, "db_utils.py"))
csp_db = importlib.util.module_from_spec(csp_db_spec)
csp_db_spec.loader.exec_module(csp_db)

graph_db_spec = importlib.util.spec_from_file_location("graph_db_utils", os.path.join(graph_path, "db_utils.py"))
graph_db = importlib.util.module_from_spec(graph_db_spec)
graph_db_spec.loader.exec_module(graph_db)

app = Flask(__name__)
CORS(app)

# Essential categories for a full build
REQUIRED_CATEGORIES = [
    "CPU", "CPU Cooler", "Motherboard", "Memory",
    "Storage", "Video Card", "Case", "Power Supply"
]

CATEGORY_MAP_FRONTEND = {
    1: "CPU",
    2: "Motherboard",
    3: "RAM",
    4: "Storage",
    5: "GPU",
    6: "PSU",
    7: "Case",
    8: "Cooling"
}


def parse_power(value):
    """Convert string like '35W' or numeric to float."""
    if value is None:
        return 0.0
    if isinstance(value, (int, float)):
        return float(value)
    # Extract digits and optional decimal point
    match = re.search(r'[\d.]+', str(value))
    if match:
        return float(match.group())
    return 0.0

def transform_component_for_csp(comp):
    """
    Transform raw component data from DB into CSP format.
    Handles socket compatibility, TDP, wattage, and case/GPU/cooler attributes.
    """
    category_map = {
        1: "CPU",
        2: "Motherboard",
        3: "Memory",
        4: "Storage",
        5: "Video Card",
        6: "Power Supply",
        7: "Case",
        8: "CPU Cooler"
    }
    csp_category = category_map.get(comp.get("category_id"), "Unknown")

    attrs = {}
    if comp.get('compatibility_information'):
        try:
            raw_attrs = comp['compatibility_information']
            if isinstance(raw_attrs, str):
                raw_attrs = json.loads(raw_attrs)
        except Exception:
            raw_attrs = {}

        # CPU / Motherboard attributes
        attrs['socket'] = (
            raw_attrs.get('socket') or
            raw_attrs.get('cpu_socket') or
            raw_attrs.get('cpuSocket')
        )
        attrs['ram_type'] = raw_attrs.get('ram_type') or raw_attrs.get('ramType')
        attrs['tdp'] = parse_power(raw_attrs.get('tdp')) or parse_power(raw_attrs.get('tdpRating'))
        attrs['wattage'] = parse_power(raw_attrs.get('wattage')) or parse_power(raw_attrs.get('powerRequirement'))

        # CPU Cooler supported sockets (handles snake_case and camelCase)
        supported = (
            raw_attrs.get('supported_sockets') or
            raw_attrs.get('socket_support') or
            raw_attrs.get('supportedSockets') or
            raw_attrs.get('sockets') or
            []
        )
        if isinstance(supported, str):
            supported = [s.strip() for s in supported.split(',')]
        attrs['supported_sockets'] = supported

        # Case / GPU / Cooler attributes
        attrs['maxGpuLength'] = raw_attrs.get('maxGpuLength') or raw_attrs.get('max_gpu_length') or 0
        attrs['maxCoolerHeight'] = raw_attrs.get('maxCoolerHeight') or raw_attrs.get('max_cooler_height') or 0
        attrs['height'] = raw_attrs.get('height', 0)
        attrs['length'] = raw_attrs.get('length', 0)

    component_id = comp.get('component_id')
    component_name = comp.get('component_name', '')
    component_price = float(comp.get('component_price', 0) or 0)

    return {
        "id": component_id,
        "name": component_name,
        "price": component_price,
        "category": csp_category,
        "attrs": attrs
    }



@app.route('/health', methods=['GET'])
def health_check():
    return jsonify({"status": "ok", "message": "Python backend is running"}), 200

@app.route('/', methods=['GET'])
def root():
    return jsonify({
        "message": "Python Algorithm Backend",
        "endpoints": ["/api/csp", "/api/graph", "/api/components", "/health"]
    }), 200

@app.route('/api/csp', methods=['POST'])
def run_csp():
    try:
        data = request.json
        budget = data.get("budget", 0)
        user_inputs = data.get("user_inputs", {})

        # Validate budget
        if budget <= 0:
            return jsonify({"error": "Budget must be greater than 0"}), 400

        # Fetch components from Supabase
        raw_components = csp_db.fetch_all_components()

        # Transform to CSP format
        components = [transform_component_for_csp(comp) for comp in raw_components]

        # Check if pre-selected components exceed budget
        id_map = {c.get("component_id"): c for c in raw_components}
        pre_selected_cost = 0
        pre_selected_names = []
        for cat, comp_id in user_inputs.items():
            if comp_id in id_map:
                comp = id_map[comp_id]
                price = float(comp.get("component_price", 0) or 0)
                pre_selected_cost += price
                pre_selected_names.append(f"{cat}: {comp.get('component_name', 'Unknown')} (₱{price:,.2f})")
        
        if pre_selected_cost > budget:
            logging.warning("CSP: Pre-selected components (₱%.2f) exceed budget (₱%.2f)", pre_selected_cost, budget)
            return jsonify({
                "error": f"Pre-selected components cost ₱{pre_selected_cost:,.2f}, which exceeds your budget of ₱{budget:,.2f}. Please remove some components or increase your budget.",
                "pre_selected_cost": pre_selected_cost,
                "budget": budget,
                "over_budget_by": pre_selected_cost - budget
            }), 400

        solver = CSPBacktracking(components)

        # Use generator to limit solutions (reduced to 10 for faster results)
        solutions = []
        solution_count = 0
        for i, sol in enumerate(solver.solve(budget, user_inputs)):
            if i >= 10:  # limit to 10 solutions for faster response
                break
            solutions.append(sol)
            solution_count = i + 1

        total_found = solution_count if solutions else 0
        logging.info("CSP: Budget ₱%.2f, Pre-selected cost ₱%.2f, Returning %d solutions", budget, pre_selected_cost, len(solutions))

        if not solutions:
            return jsonify({
                "error": f"No compatible solutions found within budget of ₱{budget:,.2f}. Try adjusting your budget or removing some pre-selected components.",
                "solutions": [],
                "total_found": 0
            }), 200  # Return 200 but with error message in response

        return jsonify({
            "solutions": solutions,
            "total_found": total_found
        })

    except Exception as e:
        logging.error("Error in CSP endpoint: %s", e, exc_info=True)
        return jsonify({"error": str(e)}), 500


@app.route('/api/graph', methods=['POST'])
def run_graph():
    try:
        data = request.json
        current_build = data.get("current_build", [])

        # Fetch all components from Supabase
        all_components = graph_db.fetch_all_components()
        recommendations = generate_upgrade_recommendations(current_build, all_components)
        return jsonify({"recommendations": recommendations})
    except Exception as e:
        logging.error("Error running graph algorithm: %s", e, exc_info=True)
        return jsonify({"error": str(e)}), 500

@app.route('/api/components', methods=['GET'])
def get_components():
    """Return all components with category names for frontend."""
    try:
        raw_components = csp_db.fetch_all_components()
        components = []
        for c in raw_components:
            components.append({
                "id": c.get("component_id"),
                "name": c.get("component_name"),
                "price": float(c.get("component_price", 0) or 0),
                "category_id": c.get("category_id"),
                "category_name": CATEGORY_MAP_FRONTEND.get(c.get("category_id"), "Unknown"),
                "compatibility": c.get("compatibility_information"),
                "retailer_id": c.get("retailer_id"),
            })
        return jsonify({"components": components}), 200
    except Exception as e:
        logging.error("Error fetching components: %s", e, exc_info=True)
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host="0.0.0.0", port=port)
