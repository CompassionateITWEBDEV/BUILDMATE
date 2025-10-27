from flask import Flask, request, jsonify
from flask_cors import CORS
import sys, os

# Add both 'csp' and 'graph' directories to Python path
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'csp')))
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'graph')))

from csp_recommender import CSPBacktracking
from db_utils import fetch_all_components
from graph_upgrade import generate_upgrade_recommendations  # ✅ Import from your graph file

app = Flask(__name__)
CORS(app)

@app.route('/api/csp', methods=['POST'])
def run_csp():
    data = request.json
    budget = data.get("budget", 0)
    user_inputs = data.get("user_inputs", {})

    components = fetch_all_components()
    solver = CSPBacktracking(components)
    solutions = solver.solve(budget, user_inputs)

    return jsonify({"solutions": solutions})

@app.route('/api/graph', methods=['POST'])
def run_graph():
    data = request.json
    current_build = data.get("current_build", [])
    
    try:
        all_components = fetch_all_components()
        recommendations = generate_upgrade_recommendations(current_build, all_components)
        return jsonify({"recommendations": recommendations})
    except Exception as e:
        print("Error running graph algorithm:", e)
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
