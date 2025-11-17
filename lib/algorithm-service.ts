/**
 * Service to interact with the Python algorithm backend
 */

const API_BASE = '/api/algorithms'

export interface CSPRecommendation {
  budget: number
  user_inputs: Record<string, number>
}

export interface CSPSolution {
  [category: string]: {
    id: number
    name: string
    price: number
    category: string
  }
}

export interface UpgradeRecommendation {
  current_component: string
  recommended_upgrade: string | null
  new_price: number | null
  upgrade_cost?: number | null
}

/**
 * Get component recommendations using CSP algorithm
 */
export async function getCSPRecommendations(
  budget: number,
  userInputs: Record<string, number>
): Promise<CSPSolution[]> {
  try {
    // Create AbortController for client-side timeout (longer than server timeout)
    const controller = new AbortController()
    const timeoutId = setTimeout(() => controller.abort(), 310000) // 310 seconds (slightly longer than server timeout of 5 minutes)
    
    const response = await fetch(`${API_BASE}/csp`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        budget,
        user_inputs: userInputs,
      }),
      signal: controller.signal,
    })
    
    clearTimeout(timeoutId)

    const data = await response.json()
    
    // Check for errors in response (both error status and error field in 200 response)
    if (!response.ok || data.error) {
      let errorMessage = 'Failed to get CSP recommendations'
      
      // Try to get error message from response
      if (data.error) {
        errorMessage = data.error
      } else if (response.statusText) {
        errorMessage = response.statusText
      }
      
      // Provide more specific error messages
      if (response.status === 400) {
        // Budget validation error - use the detailed message from backend
        // errorMessage already set from data.error above
      } else if (response.status === 500) {
        errorMessage = 'Python backend error. Make sure the Python backend is running on port 5000.'
      } else if (response.status === 503 || response.status === 0) {
        errorMessage = 'Cannot connect to Python backend. Please start the backend server: cd Algorithm/python-backend && python api.py'
      } else if (response.status === 504) {
        errorMessage = 'Request timeout. The CSP algorithm is taking too long. Try reducing the budget or selecting fewer pre-selected components.'
      }
      
      throw new Error(errorMessage)
    }
    
    return data.solutions || []
  } catch (error: any) {
    console.error('Error getting CSP recommendations:', error)
    
    // Handle timeout errors
    if (error.name === 'AbortError' || error.message?.includes('timeout') || error.message?.includes('aborted')) {
      throw new Error('Request timeout. The CSP algorithm is taking too long. Try reducing the budget or selecting fewer pre-selected components.')
    }
    
    // Handle network errors specifically
    if (error.name === 'TypeError' || error.name === 'NetworkError' || error.message?.includes('fetch') || error.message?.includes('network')) {
      throw new Error('Network error: Cannot connect to server. Make sure the Python backend is running on port 5000. Start it with: cd Algorithm/python-backend && python api.py')
    }
    
    // Provide user-friendly error messages
    if (error.message) {
      throw error
    } else {
      throw new Error('Failed to get CSP recommendations. Please check if the Python backend is running.')
    }
  }
}

/**
 * Get upgrade recommendations using graph algorithm
 */
export async function getUpgradeRecommendations(
  currentBuild: Array<{
    component_id: number
    component_name: string
    component_price: number
    category_name: string
  }>,
  budget?: number,
  compatibilityInfo?: {
    socket?: string
    memoryType?: string
  }
): Promise<UpgradeRecommendation[]> {
  try {
    const response = await fetch(`${API_BASE}/upgrade`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        current_build: currentBuild,
        budget: budget || null,
        compatibility_info: compatibilityInfo || null,
      }),
    })

    if (!response.ok) {
      // Try to get error message from response
      let errorMessage = 'Failed to get upgrade recommendations'
      try {
        const errorData = await response.json()
        errorMessage = errorData.error || errorMessage
      } catch (e) {
        // If response is not JSON, use status text
        errorMessage = response.statusText || errorMessage
      }
      
      // Provide more specific error messages
      if (response.status === 500) {
        errorMessage = 'Python backend error. Make sure the Python backend is running on port 5000.'
      } else if (response.status === 503 || response.status === 0) {
        errorMessage = 'Cannot connect to Python backend. Please start the backend server: cd Algorithm/python-backend && python api.py'
      }
      
      throw new Error(errorMessage)
    }

    const data = await response.json()
    
    // Check if there's an error in the response
    if (data.error) {
      throw new Error(data.error)
    }
    
    return data.recommendations || []
  } catch (error: any) {
    console.error('Error getting upgrade recommendations:', error)
    
    // Handle network errors specifically
    if (error.name === 'TypeError' || error.name === 'NetworkError' || error.message?.includes('fetch') || error.message?.includes('network')) {
      throw new Error('Network error: Cannot connect to server. Make sure the Python backend is running on port 5000. Start it with: cd Algorithm/python-backend && python api.py')
    }
    
    // Provide user-friendly error messages
    if (error.message) {
      throw error
    } else {
      throw new Error('Failed to get upgrade recommendations. Please check if the Python backend is running.')
    }
  }
}

