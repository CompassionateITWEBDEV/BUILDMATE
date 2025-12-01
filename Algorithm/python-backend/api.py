"""
BuildMate Python Backend API
Provides endpoints for CSP recommendations and graph-based upgrade suggestions.
"""

import logging
from flask import Flask, request, jsonify
from flask_cors import CORS
import sys
import os
import json
import importlib.util
import re

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s"
)

# Add algorithm directories to Python path
csp_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'csp'))
graph_path = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', 'graph'))
sys.path.insert(0, csp_path)
sys.path.insert(0, graph_path)

# Import algorithm modules
from csp_recommender import CSPBacktracking
from graph_upgrade import generate_upgrade_recommendations

# Load database utility modules dynamically
csp_db_spec = importlib.util.spec_from_file_location(
    "csp_db_utils",
    os.path.join(csp_path, "db_utils.py")
)
csp_db = importlib.util.module_from_spec(csp_db_spec)
csp_db_spec.loader.exec_module(csp_db)

graph_db_spec = importlib.util.spec_from_file_location(
    "graph_db_utils",
    os.path.join(graph_path, "db_utils.py")
)
graph_db = importlib.util.module_from_spec(graph_db_spec)
graph_db_spec.loader.exec_module(graph_db)

# Initialize Flask app
app = Flask(__name__)
CORS(app)

# Constants
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

CATEGORY_MAP_CSP = {
    1: "CPU",
    2: "Motherboard",
    3: "Memory",
    4: "Storage",
    5: "Video Card",
    6: "Power Supply",
    7: "Case",
    8: "CPU Cooler"
}

# Configuration
DEFAULT_PAGE_SIZE = 10
MAX_COLLECT_MULTIPLIER = 20
MIN_COLLECT_SOLUTIONS = 1500  # Increased from 500 to 1500 since we limited components


# Utility Functions
def parse_power(value):
    """Convert string like '35W' or numeric to float."""
    if value is None:
        return 0.0
    if isinstance(value, (int, float)):
        return float(value)
    match = re.search(r'[\d.]+', str(value))
    if match:
        return float(match.group())
    return 0.0


def transform_component_for_csp(comp):
    """
    Transform raw component data from DB into CSP format.
    Handles socket compatibility, TDP, wattage, and case/GPU/cooler attributes.
    """
    csp_category = CATEGORY_MAP_CSP.get(comp.get("category_id"), "Unknown")
    
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
        
        # CPU Cooler supported sockets
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


def get_min_budget_utilization(budget):
    """Get minimum budget utilization threshold based on budget size."""
    # Very lenient thresholds - almost no filtering to ensure solutions are shown
    if budget < 30000:
        return 0.15  # 15% for budgets < 30k (very lenient)
    elif budget <= 100000:
        return 0.2  # 20% for budgets 30k-100k (e.g., 50k budget = 10k minimum)
    else:
        return 0.15  # 15% for budgets > 100k


def validate_csp_request(data):
    """Validate CSP request data."""
    if not data:
        return False, "Request body is required"
    
    budget = data.get("budget", 0)
    if budget <= 0:
        return False, "Budget must be greater than 0"
    
    # Minimum budget requirement of 15,000 pesos
    if budget < 15000:
        return False, f"Budget must be at least ₱15,000.00 (current: ₱{budget:,.2f})"
    
    return True, None


# API Endpoints

@app.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint."""
    return jsonify({
        "status": "ok",
        "message": "Python backend is running",
        "service": "BuildMate Algorithm API"
    }), 200


@app.route('/api/debug/components', methods=['GET'])
def debug_components():
    """Debug endpoint to check component availability."""
    try:
        raw_components = csp_db.fetch_all_components()
        components = [transform_component_for_csp(comp) for comp in raw_components]
        
        # Filter valid components
        valid_components = [c for c in components if c.get("price", 0) > 0]
        
        # Group by category
        by_category = {}
        for comp in valid_components:
            cat = comp.get("category", "Unknown")
            if cat not in by_category:
                by_category[cat] = []
            by_category[cat].append({
                "id": comp.get("id"),
                "name": comp.get("name"),
                "price": comp.get("price", 0)
            })
        
        # Calculate stats
        stats = {}
        for cat, comps in by_category.items():
            prices = [c["price"] for c in comps]
            stats[cat] = {
                "count": len(comps),
                "min_price": min(prices) if prices else 0,
                "max_price": max(prices) if prices else 0,
                "avg_price": sum(prices) / len(prices) if prices else 0
            }
        
        return jsonify({
            "total_components": len(valid_components),
            "total_raw": len(raw_components),
            "categories": stats,
            "required_categories": REQUIRED_CATEGORIES,
            "missing_categories": [cat for cat in REQUIRED_CATEGORIES if cat not in by_category]
        }), 200
        
    except Exception as e:
        logging.error("Error in debug endpoint: %s", e, exc_info=True)
        return jsonify({
            "error": "Internal server error",
            "message": str(e)
        }), 500


@app.route('/', methods=['GET'])
def root():
    """Root endpoint with API information."""
    return jsonify({
        "message": "BuildMate Python Algorithm Backend",
        "version": "1.0.0",
        "endpoints": {
            "health": {
                "path": "/health",
                "method": "GET",
                "description": "Health check endpoint"
            },
            "csp": {
                "path": "/api/csp",
                "method": "POST",
                "description": "Get CSP-based PC build recommendations"
            },
            "graph": {
                "path": "/api/graph",
                "method": "POST",
                "description": "Get graph-based upgrade recommendations"
            },
            "components": {
                "path": "/api/components",
                "method": "GET",
                "description": "Get all components"
            }
        }
    }), 200


@app.route('/api/csp', methods=['POST'])
def run_csp():
    """
    CSP Recommendation Endpoint
    
    Request Body:
    {
        "budget": number (required),
        "user_inputs": object (optional),
        "page": number (optional, default: 0),
        "limit": number (optional, default: 10)
    }
    
    Response:
    {
        "solutions": array,
        "total_found": number,
        "has_more": boolean,
        "page": number
    }
    """
    try:
        data = request.json
        
        # Validate request
        is_valid, error_msg = validate_csp_request(data)
        if not is_valid:
            return jsonify({"error": error_msg}), 400
        
        budget = data.get("budget", 0)
        user_inputs = data.get("user_inputs", {})
        page = data.get("page", 0)
        limit = data.get("limit", DEFAULT_PAGE_SIZE)
        performance_category = data.get("performance_category")  # Get performance category from request
        
        # Fetch and transform components, filtered by performance category if specified
        raw_components = csp_db.fetch_all_components(performance_category=performance_category)
        components = [transform_component_for_csp(comp) for comp in raw_components]
        
        # Filter out components with invalid prices (0, null, or negative)
        valid_components = []
        invalid_count = 0
        for comp in components:
            price = comp.get("price", 0)
            if price and price > 0:
                valid_components.append(comp)
            else:
                invalid_count += 1
        
        components = valid_components
        
        # Log component distribution by category
        category_counts = {}
        price_ranges = {}
        for comp in components:
            cat = comp.get("category", "Unknown")
            category_counts[cat] = category_counts.get(cat, 0) + 1
            
            # Track price ranges per category
            if cat not in price_ranges:
                price_ranges[cat] = {"min": float('inf'), "max": 0, "prices": []}
            price = comp.get("price", 0)
            price_ranges[cat]["prices"].append(price)
            if price < price_ranges[cat]["min"]:
                price_ranges[cat]["min"] = price
            if price > price_ranges[cat]["max"]:
                price_ranges[cat]["max"] = price
        
        logging.info(
            "CSP: Loaded %d valid components (filtered out %d with invalid prices). Distribution: %s",
            len(components), invalid_count, category_counts
        )
        
        # Log price ranges for debugging
        for cat, ranges in price_ranges.items():
            if ranges["prices"]:
                avg_price = sum(ranges["prices"]) / len(ranges["prices"])
                logging.info(
                    "CSP: Category '%s' - Min: ₱%.2f, Max: ₱%.2f, Avg: ₱%.2f, Count: %d",
                    cat, ranges["min"], ranges["max"], avg_price, len(ranges["prices"])
                )
        
        if performance_category and performance_category != 'all':
            logging.info(
                "CSP: Filtering by performance category '%s', found %d components",
                performance_category, len(components)
            )
        
        # Validate pre-selected components
        id_map = {c.get("component_id"): c for c in raw_components}
        pre_selected_cost = 0
        pre_selected_names = []
        
        for cat, comp_id in user_inputs.items():
            if comp_id in id_map:
                comp = id_map[comp_id]
                price = float(comp.get("component_price", 0) or 0)
                pre_selected_cost += price
                pre_selected_names.append(
                    f"{cat}: {comp.get('component_name', 'Unknown')} (₱{price:,.2f})"
                )
        
        if pre_selected_cost > budget:
            logging.warning(
                "CSP: Pre-selected components (₱%.2f) exceed budget (₱%.2f)",
                pre_selected_cost, budget
            )
            return jsonify({
                "error": (
                    f"Pre-selected components cost ₱{pre_selected_cost:,.2f}, "
                    f"which exceeds your budget of ₱{budget:,.2f}. "
                    "Please remove some components or increase your budget."
                ),
                "pre_selected_cost": pre_selected_cost,
                "budget": budget,
                "over_budget_by": pre_selected_cost - budget
            }), 400
        
        # Initialize solver and generate solutions
        solver = CSPBacktracking(components)
        solution_generator = solver.solve(budget, user_inputs)
        
        # Collect solutions
        skip = page * limit
        all_solutions = []
        max_collect = max(limit * MAX_COLLECT_MULTIPLIER, MIN_COLLECT_SOLUTIONS)
        
        logging.info("CSP: Starting to collect solutions (max: %d)", max_collect)
        
        solution_count = 0
        for i, sol in enumerate(solution_generator):
            if i >= max_collect:
                try:
                    next(solution_generator)
                    has_more = True
                except StopIteration:
                    has_more = False
                break
            
            total_price = sum(c["price"] for c in sol.values() if c)
            all_solutions.append((total_price, sol))
            solution_count = i + 1
            
            if (i + 1) % 50 == 0:
                logging.info(
                    "CSP: Collected %d solutions (highest: ₱%.2f, lowest: ₱%.2f)",
                    i + 1,
                    max([p for p, _ in all_solutions]) if all_solutions else 0,
                    min([p for p, _ in all_solutions]) if all_solutions else 0
                )
        else:
            has_more = False
        
        logging.info("CSP: Finished collecting %d solutions", len(all_solutions))
        
        # Sort by price (descending) to prioritize solutions close to budget
        all_solutions.sort(key=lambda x: x[0], reverse=True)
        
        # Filter solutions to show a reasonable price range (65-100% of budget)
        # This prevents showing extremely cheap builds when user has a higher budget
        min_budget = budget * 0.65  # Show builds from 65% to 100% of budget
        filtered_solutions = [(price, sol) for price, sol in all_solutions if price >= min_budget]
        
        # If no solutions in the 65-100% range, fallback to all solutions
        if not filtered_solutions:
            filtered_solutions = all_solutions
            logging.info("CSP: No solutions in 65-100%% range, showing all %d solutions", len(all_solutions))
        else:
            logging.info("CSP: Filtered to %d solutions in range ₱%.2f - ₱%.2f (65-100%% of budget)", 
                        len(filtered_solutions), min_budget, budget)
        
        all_solutions = filtered_solutions
        
        if all_solutions:
            logging.info(
                "CSP: Price range - Highest: ₱%.2f, Lowest: ₱%.2f, Budget: ₱%.2f "
                "(Showing %d/%d after filtering)",
                all_solutions[0][0], all_solutions[-1][0], budget,
                len(all_solutions), solution_count
            )
        
        # Paginate
        start_idx = skip
        end_idx = skip + limit
        solutions = [sol for _, sol in all_solutions[start_idx:end_idx]]
        
        # Determine if there are more solutions
        if end_idx < len(all_solutions):
            has_more = True
        elif solution_count >= max_collect:
            has_more = True
        else:
            has_more = False
        
        total_found = len(all_solutions) if all_solutions else 0
        
        logging.info(
            "CSP: Budget ₱%.2f, Page %d, Pre-selected cost ₱%.2f, "
            "Returning %d solutions, Has more: %s",
            budget, page, pre_selected_cost, len(solutions), has_more
        )
        
        if not solutions:
            # Provide more helpful error message
            if solution_count == 0:
                error_msg = (
                    f"No compatible PC builds found within your budget of ₱{budget:,.2f}.\n\n"
                    "This might be due to:\n"
                    "- Compatibility constraints between components (CPU socket, RAM type, power requirements)\n"
                    "- Pre-selected components limiting available options\n"
                    "- Insufficient budget for a complete 8-component PC build\n\n"
                    "Suggestions:\n"
                    "- Try increasing your budget to at least ₱20,000 - ₱25,000 for entry-level builds\n"
                    "- Remove any pre-selected components to see more options\n"
                    "- Select a different performance category\n\n"
                    f"Minimum budget required: ₱15,000.00"
                )
            else:
                error_msg = (
                    f"Found {solution_count} potential solutions but they don't meet all requirements. "
                    f"Try adjusting your budget or removing pre-selected components."
                )
            
            logging.warning(
                "CSP: No solutions to return. Collected: %d, Filtered: %d, Budget: ₱%.2f",
                solution_count, len(all_solutions), budget
            )
            
            return jsonify({
                "error": error_msg,
                "solutions": [],
                "total_found": 0,
                "has_more": False,
                "page": page,
                "debug_info": {
                    "solutions_collected": solution_count,
                    "solutions_after_filter": len(all_solutions),
                    "budget": budget
                }
            }), 200
        
        return jsonify({
            "solutions": solutions,
            "total_found": total_found,
            "has_more": has_more,
            "page": page
        }), 200
        
    except Exception as e:
        logging.error("Error in CSP endpoint: %s", e, exc_info=True)
        return jsonify({
            "error": "Internal server error",
            "message": str(e)
        }), 500


@app.route('/api/graph', methods=['POST'])
def run_graph():
    """
    Graph Upgrade Recommendation Endpoint
    
    Request Body:
    {
        "current_build": array (required)
    }
    
    Response:
    {
        "recommendations": array
    }
    """
    try:
        data = request.json
        
        if not data:
            return jsonify({"error": "Request body is required"}), 400
        
        current_build = data.get("current_build", [])
        
        if not current_build:
            return jsonify({
                "error": "current_build is required",
                "recommendations": []
            }), 400
        
        # Fetch components and generate recommendations
        all_components = graph_db.fetch_all_components()
        recommendations = generate_upgrade_recommendations(current_build, all_components)
        
        return jsonify({
            "recommendations": recommendations,
            "count": len(recommendations)
        }), 200
        
    except Exception as e:
        logging.error("Error running graph algorithm: %s", e, exc_info=True)
        return jsonify({
            "error": "Internal server error",
            "message": str(e)
        }), 500


@app.route('/api/components', methods=['GET'])
def get_components():
    """
    Get All Components Endpoint
    
    Response:
    {
        "components": array,
        "count": number
    }
    """
    try:
        raw_components = csp_db.fetch_all_components()
        components = []
        
        for c in raw_components:
            components.append({
                "id": c.get("component_id"),
                "name": c.get("component_name"),
                "price": float(c.get("component_price", 0) or 0),
                "category_id": c.get("category_id"),
                "category_name": CATEGORY_MAP_FRONTEND.get(
                    c.get("category_id"), "Unknown"
                ),
                "compatibility": c.get("compatibility_information"),
                "retailer_id": c.get("retailer_id"),
            })
        
        return jsonify({
            "components": components,
            "count": len(components)
        }), 200
        
    except Exception as e:
        logging.error("Error fetching components: %s", e, exc_info=True)
        return jsonify({
            "error": "Internal server error",
            "message": str(e)
        }), 500


# Error Handlers

@app.errorhandler(404)
def not_found(error):
    """Handle 404 errors."""
    return jsonify({
        "error": "Endpoint not found",
        "message": "The requested endpoint does not exist"
    }), 404


@app.errorhandler(405)
def method_not_allowed(error):
    """Handle 405 errors."""
    return jsonify({
        "error": "Method not allowed",
        "message": "The HTTP method is not allowed for this endpoint"
    }), 405


@app.errorhandler(500)
def internal_error(error):
    """Handle 500 errors."""
    return jsonify({
        "error": "Internal server error",
        "message": "An unexpected error occurred"
    }), 500


# Main Entry Point
if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    app.run(host="0.0.0.0", port=port, debug=False)
