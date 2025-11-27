import { NextRequest, NextResponse } from 'next/server'

const PYTHON_API_URL = process.env.PYTHON_API_URL || 'http://localhost:5000'

// API route configuration - dynamic for POST requests
export const dynamic = 'force-dynamic'
export const runtime = 'nodejs'

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const { budget, user_inputs, page, limit } = body

    // Create AbortController for timeout
    const controller = new AbortController()
    const timeoutId = setTimeout(() => controller.abort(), 300000) // 300 second (5 minute) timeout for CSP algorithm with larger budgets

    try {
      // Prepare request body for Python backend
      const pythonRequestBody = {
        budget,
        user_inputs,
        page: page !== undefined ? page : 0,
        limit: limit !== undefined ? limit : 10,
      }

      // Call Python backend
      const response = await fetch(`${PYTHON_API_URL}/api/csp`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(pythonRequestBody),
        signal: controller.signal,
      })

      clearTimeout(timeoutId)

      // Check content-type to ensure we're getting JSON, not HTML
      const contentType = response.headers.get('content-type') || ''
      const isJSON = contentType.includes('application/json')

      if (!response.ok) {
        let errorMessage = 'Failed to get recommendations from algorithm'
        try {
          const errorText = await response.text()
          console.error('Python API error:', errorText)
          
          // If response is HTML (error page), provide helpful message
          if (!isJSON || errorText.trim().startsWith('<!')) {
            if (response.status === 404) {
              errorMessage = `Python backend endpoint not found. Please check PYTHON_API_URL. Current: ${PYTHON_API_URL}`
            } else if (response.status === 503 || response.status === 502) {
              errorMessage = 'Python backend service is unavailable. The service may be starting up or down. Please try again in a few moments.'
            } else {
              errorMessage = `Python backend returned HTML error page (status ${response.status}). Please verify the backend URL is correct.`
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
        
        return NextResponse.json(
          { error: errorMessage },
          { status: response.status }
        )
      }

      // Validate response is JSON before parsing
      if (!isJSON) {
        const text = await response.text()
        console.error('Python API returned non-JSON response:', text.substring(0, 200))
        return NextResponse.json(
          { 
            error: `Python backend returned non-JSON response. Please check if the backend URL (${PYTHON_API_URL}) is correct and the service is running.` 
          },
          { status: 502 }
        )
      }

      const data = await response.json()
      return NextResponse.json(data, { 
        status: 200,
        headers: {
          'Cache-Control': 'no-store, no-cache, must-revalidate, proxy-revalidate',
          'Pragma': 'no-cache',
          'Expires': '0'
        }
      })
    } catch (fetchError: any) {
      clearTimeout(timeoutId)
      
      if (fetchError.name === 'AbortError') {
        return NextResponse.json(
          { error: 'Request timeout. The Python backend may be slow or not responding.' },
          { status: 504 }
        )
      }
      
      // Handle JSON parsing errors (when backend returns HTML)
      if (fetchError.message?.includes('JSON') || fetchError.message?.includes('Unexpected token')) {
        return NextResponse.json(
          { 
            error: `Python backend returned invalid response. Please verify PYTHON_API_URL is correct (current: ${PYTHON_API_URL}) and the backend service is running.` 
          },
          { status: 502 }
        )
      }
      
      if (fetchError.code === 'ECONNREFUSED' || fetchError.message?.includes('fetch failed') || fetchError.message?.includes('Failed to fetch')) {
        return NextResponse.json(
          { 
            error: `Cannot connect to Python backend at ${PYTHON_API_URL}. Please make sure the backend service is deployed and running.` 
          },
          { status: 503 }
        )
      }
      
      throw fetchError
    }
  } catch (error: any) {
    console.error('CSP API error:', error)
    return NextResponse.json(
      { error: error.message || 'Internal server error' },
      { status: 500 }
    )
  }
}

