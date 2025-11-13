import { NextRequest, NextResponse } from 'next/server'

const PYTHON_API_URL = process.env.PYTHON_API_URL || 'http://localhost:5000'

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const { current_build, budget, compatibility_info } = body

    // Create AbortController for timeout
    const controller = new AbortController()
    const timeoutId = setTimeout(() => controller.abort(), 30000) // 30 second timeout

    try {
      // Call Python backend
      const response = await fetch(`${PYTHON_API_URL}/api/graph`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          current_build,
          budget: budget || null,
          compatibility_info: compatibility_info || null,
        }),
        signal: controller.signal,
      })

      clearTimeout(timeoutId)

      if (!response.ok) {
        let errorMessage = 'Failed to get upgrade recommendations from algorithm'
        try {
          const errorText = await response.text()
          console.error('Python API error:', errorText)
          // Try to parse as JSON
          try {
            const errorData = JSON.parse(errorText)
            errorMessage = errorData.error || errorMessage
          } catch {
            errorMessage = errorText || errorMessage
          }
        } catch (e) {
          errorMessage = `Python backend returned status ${response.status}`
        }
        
        return NextResponse.json(
          { error: errorMessage },
          { status: response.status }
        )
      }

      const data = await response.json()
      return NextResponse.json(data, { status: 200 })
    } catch (fetchError: any) {
      clearTimeout(timeoutId)
      
      if (fetchError.name === 'AbortError') {
        return NextResponse.json(
          { error: 'Request timeout. The Python backend may be slow or not responding.' },
          { status: 504 }
        )
      }
      
      if (fetchError.code === 'ECONNREFUSED' || fetchError.message?.includes('fetch failed')) {
        return NextResponse.json(
          { error: 'Cannot connect to Python backend. Please make sure it is running on port 5000.' },
          { status: 503 }
        )
      }
      
      throw fetchError
    }
  } catch (error: any) {
    console.error('Upgrade API error:', error)
    return NextResponse.json(
      { error: error.message || 'Internal server error' },
      { status: 500 }
    )
  }
}

