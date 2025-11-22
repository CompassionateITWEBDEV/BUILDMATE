import { useAuth } from "@/contexts/supabase-auth-context" // adjust path
import { buildService, buildComponentService, type Component } from "@/lib/database"

interface SaveBuildParams {
  buildName: string
  selectedComponents: Record<string, Component | null>
  totalPrice?: number
  buildTypeId?: number // optional, default to 1 if not provided
}

export const useBuilds = () => {
  const { user } = useAuth()

  const saveBuild = async ({
    buildName,
    selectedComponents,
    totalPrice,
    buildTypeId = 1
  }: SaveBuildParams) => {
    if (!user) {
      throw new Error("You must be logged in to save a build")
    }

    try {
      // 1️⃣ Create the build
      const newBuild = await buildService.create({
        build_name: buildName,
        user_id: user.user_id,
        total_price: totalPrice || 0,
        build_type_id: buildTypeId
      })

      const buildId = newBuild.build_id

      // 2️⃣ Prepare build_components rows
      const componentsToInsert = Object.values(selectedComponents)
        .filter((comp): comp is Component => comp !== null)
        .map((comp) => comp.component_id) // use component_id as per your database.ts

      // 3️⃣ Insert components if any
      let insertedComponents = []
      if (componentsToInsert.length > 0) {
        insertedComponents = await buildComponentService.updateBuildComponents(buildId, componentsToInsert)
      }

      console.log("Build saved successfully:", { buildId, components: insertedComponents })
      return { buildId, components: insertedComponents }
    } catch (error) {
      console.error("saveBuild error:", error)
      throw error
    }
  }

  return { saveBuild }
}
