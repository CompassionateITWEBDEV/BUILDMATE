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

    // Check content-type to ensure we're getting JSON
    const contentType = response.headers.get('content-type') || ''
    const isJSON = contentType.includes('application/json')

    if (!response.ok) {
      let errorMessage = 'Failed to get CSP recommendations'
      try {
        const errorText = await response.text()
        
        // If response is HTML (error page), provide helpful message
        if (!isJSON || errorText.trim().startsWith('<!')) {
          if (response.status === 404) {
            errorMessage = 'Python backend endpoint not found. Please check if the backend service is deployed correctly.'
          } else if (response.status === 502 || response.status === 503) {
            errorMessage = 'Python backend service is unavailable. The service may be starting up. Please try again in a few moments.'
          } else {
            errorMessage = `Python backend returned an error page (status ${response.status}). Please verify the backend is running.`
          }
        } else {
          // Try to parse as JSON
          try {
            const errorData = JSON.parse(errorText)
            errorMessage = errorData.error || errorMessage
          } catch {
            errorMessage = errorText || errorMessage
          }
        }
      } catch (e) {
        errorMessage = `Python backend returned status ${response.status}`
      }
      
      throw new Error(errorMessage)
    }

    // Validate response is JSON before parsing
    if (!isJSON) {
      const text = await response.text()
      console.error('API returned non-JSON response:', text.substring(0, 200))
      throw new Error('Backend returned invalid response. Please check if the Python backend service is running correctly.')
    }

    const data = await response.json()
    
    // Check for errors in response (both error status and error field in 200 response)
    if (data.error) {
      throw new Error(data.error)
    }
    
    return data.solutions || []
  } catch (error: any) {
    console.error('Error getting CSP recommendations:', error)
    
    // Handle JSON parsing errors
    if (error.message?.includes('JSON') || error.message?.includes('Unexpected token') || error.message?.includes('<!doctype')) {
      throw new Error('Backend returned invalid response. Please verify the Python backend service is deployed and running correctly.')
    }
    
    // Handle timeout errors
    if (error.name === 'AbortError' || error.message?.includes('timeout') || error.message?.includes('aborted')) {
      throw new Error('Request timeout. The CSP algorithm is taking too long. Try reducing the budget or selecting fewer pre-selected components.')
    }
    
    // Handle network errors specifically
    if (error.name === 'TypeError' || error.name === 'NetworkError' || error.message?.includes('fetch') || error.message?.includes('network') || error.message?.includes('Failed to fetch')) {
      throw new Error('Network error: Cannot connect to server. Please make sure the Python backend service is deployed and running.')
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

    // Check content-type to ensure we're getting JSON
    const contentType = response.headers.get('content-type') || ''
    const isJSON = contentType.includes('application/json')

    if (!response.ok) {
      // Try to get error message from response
      let errorMessage = 'Failed to get upgrade recommendations'
      try {
        const errorText = await response.text()
        
        // If response is HTML (error page), provide helpful message
        if (!isJSON || errorText.trim().startsWith('<!')) {
          if (response.status === 404) {
            errorMessage = 'Python backend endpoint not found. Please check if the backend service is deployed correctly.'
          } else if (response.status === 502 || response.status === 503) {
            errorMessage = 'Python backend service is unavailable. The service may be starting up. Please try again in a few moments.'
          } else {
            errorMessage = `Python backend returned an error page (status ${response.status}). Please verify the backend is running.`
          }
        } else {
          // Try to parse as JSON
          try {
            const errorData = JSON.parse(errorText)
            errorMessage = errorData.error || errorMessage
          } catch {
            errorMessage = errorText || errorMessage
          }
        }
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

    // Validate response is JSON before parsing
    if (!isJSON) {
      const text = await response.text()
      console.error('API returned non-JSON response:', text.substring(0, 200))
      throw new Error('Backend returned invalid response. Please check if the Python backend service is running correctly.')
    }

    const data = await response.json()
    
    // Check if there's an error in the response
    if (data.error) {
      throw new Error(data.error)
    }
    
    return data.recommendations || []
  } catch (error: any) {
    console.error('Error getting upgrade recommendations:', error)
    
    // Handle JSON parsing errors
    if (error.message?.includes('JSON') || error.message?.includes('Unexpected token') || error.message?.includes('<!doctype')) {
      throw new Error('Backend returned invalid response. Please verify the Python backend service is deployed and running correctly.')
    }
    
    // Handle network errors specifically
    if (error.name === 'TypeError' || error.name === 'NetworkError' || error.message?.includes('fetch') || error.message?.includes('network') || error.message?.includes('Failed to fetch')) {
      throw new Error('Network error: Cannot connect to server. Please make sure the Python backend service is deployed and running.')
    }
    
    // Provide user-friendly error messages
    if (error.message) {
      throw error
    } else {
      throw new Error('Failed to get upgrade recommendations. Please check if the Python backend is running.')
    }
  }
}

