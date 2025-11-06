# Algorithm Integration Guide

This guide explains how to set up and use the Python algorithms with the BuildMate system.

## Prerequisites

1. Python 3.8 or higher
2. pip package manager

## Setup

### 1. Install Python Dependencies

Navigate to the `Algorithm/python-backend` directory and install dependencies:

```bash
cd Algorithm/python-backend
pip install -r requirements.txt
```

### 2. Set Environment Variables

Create a `.env` file in the `Algorithm/python-backend` directory (or set environment variables):

```env
SUPABASE_URL=your_supabase_url
SUPABASE_KEY=your_supabase_anon_key
```

Alternatively, the algorithms will use default values if not set.

### 3. Start the Python Backend

```bash
cd Algorithm/python-backend
python api.py
```

The API will run on `http://localhost:5000` by default.

### 4. Configure Next.js

Add the Python API URL to your Next.js environment variables (`.env.local`):

```env
PYTHON_API_URL=http://localhost:5000
```

## Algorithms

### 1. CSP (Constraint Satisfaction Problem) Recommender

**Purpose**: Recommends compatible components based on budget and user selections.

**Endpoint**: `POST /api/algorithms/csp`

**Request Body**:
```json
{
  "budget": 100000,
  "user_inputs": {
    "CPU": 1,
    "Video Card": 5
  }
}
```

**Response**:
```json
{
  "solutions": [
    {
      "CPU": { "id": 1, "name": "...", "price": 15000, ... },
      "Motherboard": { ... },
      ...
    }
  ]
}
```

### 2. Graph Upgrade Algorithm

**Purpose**: Suggests component upgrades based on current build.

**Endpoint**: `POST /api/algorithms/upgrade`

**Request Body**:
```json
{
  "current_build": [
    {
      "component_id": 1,
      "component_name": "Intel Core i5",
      "component_price": 15000,
      "category_name": "CPU"
    }
  ]
}
```

**Response**:
```json
{
  "recommendations": [
    {
      "current_component": "Intel Core i5",
      "recommended_upgrade": "Intel Core i7",
      "new_price": 25000
    }
  ]
}
```

## Integration in Frontend

### Using the Algorithm Service

```typescript
import { getCSPRecommendations, getUpgradeRecommendations } from '@/lib/algorithm-service'

// Get CSP recommendations
const solutions = await getCSPRecommendations(100000, {
  "CPU": 1,
  "Video Card": 5
})

// Get upgrade recommendations
const upgrades = await getUpgradeRecommendations(currentBuild)
```

## Troubleshooting

### Python Backend Not Starting

1. Check if port 5000 is already in use
2. Verify all dependencies are installed: `pip install -r requirements.txt`
3. Check Python version: `python --version` (should be 3.8+)

### Connection Errors

1. Verify `PYTHON_API_URL` is set correctly in `.env.local`
2. Ensure Python backend is running: `python api.py`
3. Check CORS settings if accessing from different origin

### Algorithm Errors

1. Check Supabase connection in `db_utils.py`
2. Verify component data structure matches expected format
3. Check console logs for detailed error messages

## Development

To modify the algorithms:

1. Edit files in `Algorithm/csp/` or `Algorithm/graph/`
2. Restart the Python backend: `python api.py`
3. Test using the API endpoints or frontend integration

## Production Deployment

For production:

1. Deploy Python backend (e.g., using Gunicorn, Docker, or cloud services)
2. Update `PYTHON_API_URL` to production URL
3. Ensure environment variables are set securely
4. Configure CORS for production domain


