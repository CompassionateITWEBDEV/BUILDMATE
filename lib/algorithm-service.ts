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
}

/**
 * Get component recommendations using CSP algorithm
 */
export async function getCSPRecommendations(
  budget: number,
  userInputs: Record<string, number>
): Promise<CSPSolution[]> {
  try {
    const response = await fetch(`${API_BASE}/csp`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        budget,
        user_inputs: userInputs,
      }),
    })

    if (!response.ok) {
      // Try to get error message from response
      let errorMessage = 'Failed to get CSP recommendations'
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
    
    return data.solutions || []
  } catch (error: any) {
    console.error('Error getting CSP recommendations:', error)
    
    // Provide user-friendly error messages
    if (error.message) {
      throw error
    } else if (error.name === 'TypeError' || error.message?.includes('fetch')) {
      throw new Error('Cannot connect to server. Make sure the Python backend is running on port 5000.')
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
  }>
): Promise<UpgradeRecommendation[]> {
  try {
    const response = await fetch(`${API_BASE}/upgrade`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        current_build: currentBuild,
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
    
    // Provide user-friendly error messages
    if (error.message) {
      throw error
    } else if (error.name === 'TypeError' || error.message?.includes('fetch')) {
      throw new Error('Cannot connect to server. Make sure the Python backend is running on port 5000.')
    } else {
      throw new Error('Failed to get upgrade recommendations. Please check if the Python backend is running.')
    }
  }
}

