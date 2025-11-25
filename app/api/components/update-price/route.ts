import { NextRequest, NextResponse } from "next/server"
import { supabase } from "@/lib/supabase"

export const dynamic = 'force-dynamic'

export async function POST(request: NextRequest) {
  try {
    const body = await request.json()
    const { componentId, newPrice, availabilityStatus } = body

    if (!componentId || newPrice === undefined) {
      return NextResponse.json(
        { error: "componentId and newPrice are required" },
        { status: 400 }
      )
    }

    // Get current price before updating
    const { data: currentComponent, error: fetchError } = await supabase
      .from('components')
      .select('component_price')
      .eq('component_id', componentId)
      .single()

    if (fetchError) {
      return NextResponse.json(
        { error: "Failed to fetch current component" },
        { status: 500 }
      )
    }

    // Update component price and availability
    const updateData: any = {
      component_price: newPrice
    }

    if (availabilityStatus) {
      updateData.availability_status = availabilityStatus
    }

    const { data: updatedComponent, error: updateError } = await supabase
      .from('components')
      .update(updateData)
      .eq('component_id', componentId)
      .select()
      .single()

    if (updateError) {
      return NextResponse.json(
        { error: "Failed to update component" },
        { status: 500 }
      )
    }

    // Price history is automatically logged by the database trigger
    // But we can also manually insert if needed
    if (currentComponent.component_price !== newPrice) {
      await supabase
        .from('price_history')
        .insert({
          component_id: componentId,
          old_price: currentComponent.component_price,
          new_price: newPrice,
          changed_by: 'system'
        })
    }

    return NextResponse.json({
      success: true,
      component: updatedComponent,
      message: "Price and availability updated successfully"
    })
  } catch (error: any) {
    console.error("Error updating component price:", error)
    return NextResponse.json(
      { error: error.message || "Internal server error" },
      { status: 500 }
    )
  }
}

