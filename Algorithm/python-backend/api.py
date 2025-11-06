from flask import Flask, request, jsonify
from flask_cors import CORS
import sys, os
import json

# Add both 'csp' and 'graph' directories to Python path
csp_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'csp'))
graph_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'graph'))
sys.path.insert(0, csp_path)
sys.path.insert(0, graph_path)

from csp_recommender import CSPBacktracking
from graph_upgrade import generate_upgrade_recommendations

# Import db_utils functions directly
import importlib.util

# Load csp db_utils
csp_db_spec = importlib.util.spec_from_file_location("csp_db_utils", os.path.join(csp_path, "db_utils.py"))
csp_db = importlib.util.module_from_spec(csp_db_spec)
csp_db_spec.loader.exec_module(csp_db)

# Load graph db_utils
graph_db_spec = importlib.util.spec_from_file_location("graph_db_utils", os.path.join(graph_path, "db_utils.py"))
graph_db = importlib.util.module_from_spec(graph_db_spec)
graph_db_spec.loader.exec_module(graph_db)

app = Flask(__name__)
CORS(app)

@app.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({"status": "ok", "message": "Python backend is running"}), 200

@app.route('/', methods=['GET'])
def root():
    """Root endpoint"""
    return jsonify({"message": "Python Algorithm Backend", "endpoints": ["/api/csp", "/api/graph", "/health"]}), 200

def transform_component_for_csp(comp):
    """Transform Supabase component to CSP format"""
    category_name = comp.get('component_categories', {}).get('category_name', '')
    
    # Map category names to CSP format
    category_map = {
        'CPU': 'CPU',
        'GPU': 'Video Card',
        'Memory': 'Memory',
        'Storage': 'Storage',
        'PSU': 'Power Supply',
        'Case': 'Case',
        'Cooling': 'CPU Cooler',
        'Motherboard': 'Motherboard'
    }
    
    csp_category = category_map.get(category_name, category_name)
    
    # Parse compatibility information if available
    attrs = {}
    if comp.get('compatibility_information'):
        try:
            compat_info = json.loads(comp['compatibility_information'])
            attrs = compat_info
        except:
            pass
    
    return {
        "id": comp.get('component_id'),
        "name": comp.get('component_name', ''),
        "price": float(comp.get('component_price', 0) or 0),
        "category": csp_category,
        "attrs": attrs
    }

@app.route('/api/csp', methods=['POST'])
def run_csp():
    try:
        data = request.json
        budget = data.get("budget", 0)
        user_inputs = data.get("user_inputs", {})

        # Fetch components from Supabase
        raw_components = csp_db.fetch_all_components()
        
        # Transform to CSP format
        components = [transform_component_for_csp(comp) for comp in raw_components]
        
        solver = CSPBacktracking(components)
        solutions = solver.solve(budget, user_inputs)

        return jsonify({"solutions": solutions})
    except Exception as e:
        print(f"Error in CSP endpoint: {e}")
        import traceback
        traceback.print_exc()
        return jsonify({"error": str(e)}), 500

@app.route('/api/graph', methods=['POST'])
def run_graph():
    try:
        data = request.json
        current_build = data.get("current_build", [])
        
        # Fetch all components from Supabase (already in correct format)
        all_components = graph_db.fetch_all_components()
        
        recommendations = generate_upgrade_recommendations(current_build, all_components)
        return jsonify({"recommendations": recommendations})
    except Exception as e:
        print("Error running graph algorithm:", e)
        import traceback
        traceback.print_exc()
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
