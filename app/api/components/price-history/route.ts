import { NextRequest, NextResponse } from "next/server"
import { supabase } from "@/lib/supabase"

export const dynamic = 'force-dynamic'

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url)
    const componentId = searchParams.get('componentId')

    if (!componentId) {
      return NextResponse.json(
        { error: "componentId is required" },
        { status: 400 }
      )
    }

    const { data, error } = await supabase
      .from('price_history')
      .select('*')
      .eq('component_id', componentId)
      .order('changed_at', { ascending: false })
      .limit(50)

    if (error) {
      return NextResponse.json(
        { error: "Failed to fetch price history" },
        { status: 500 }
      )
    }

    return NextResponse.json({
      success: true,
      priceHistory: data
    })
  } catch (error: any) {
    console.error("Error fetching price history:", error)
    return NextResponse.json(
      { error: error.message || "Internal server error" },
      { status: 500 }
    )
  }
}

