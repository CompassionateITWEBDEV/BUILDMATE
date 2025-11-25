"use client"

import { useState } from "react"
import { useAuth } from "@/contexts/supabase-auth-context"
import { useRouter } from "next/navigation"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Input } from "@/components/ui/input"
import { Label } from "@/components/ui/label"
import { Textarea } from "@/components/ui/textarea"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { ArrowLeft, Upload, Save } from "lucide-react"
import Link from "next/link"
import { buildGuideService } from "@/lib/database"
import { buildService } from "@/lib/database"

export default function SubmitGuidePage() {
  const { user } = useAuth()
  const router = useRouter()
  const [loading, setLoading] = useState(false)
  const [formData, setFormData] = useState({
    guideName: "",
    description: "",
    buildId: "",
    difficulty: "Beginner",
    steps: "",
    tools: ""
  })

  if (!user) {
    router.push("/login")
    return null
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!user) return

    setLoading(true)
    try {
      // First, get or create a build for this guide
      let buildId = parseInt(formData.buildId)
      
      if (!buildId || isNaN(buildId)) {
        // Create a placeholder build if no build ID provided
        const { data: newBuild, error: buildError } = await buildService.create({
          build_name: formData.guideName,
          user_id: user.user_id,
          build_type_id: 1, // Default build type
          total_price: 0
        })
        
        if (buildError || !newBuild) {
          throw new Error("Failed to create build for guide")
        }
        buildId = newBuild.build_id
      }

      // Create the build guide
      await buildGuideService.create({
        build_id: buildId,
        build_guide_name: formData.guideName,
        description: formData.description,
        guide_steps: JSON.stringify({
          difficulty: formData.difficulty,
          steps: formData.steps.split('\n').filter(s => s.trim()),
          tools: formData.tools.split(',').map(t => t.trim()).filter(t => t)
        })
      })

      router.push("/guides")
    } catch (error: any) {
      console.error("Error submitting guide:", error)
      alert(error.message || "Failed to submit guide")
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      <div className="container mx-auto px-4 py-8">
        <div className="mb-6">
          <Link href="/guides">
            <Button variant="ghost" size="sm" className="mb-4">
              <ArrowLeft className="h-4 w-4 mr-2" />
              Back to Guides
            </Button>
          </Link>
          <h1 className="text-3xl font-bold text-slate-900 dark:text-white mb-2">
            Submit Your Build Guide
          </h1>
          <p className="text-slate-600 dark:text-slate-400">
            Share your PC building knowledge with the community
          </p>
        </div>

        <Card className="max-w-3xl mx-auto">
          <CardHeader>
            <CardTitle>Guide Information</CardTitle>
            <CardDescription>Fill in the details for your build guide</CardDescription>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleSubmit} className="space-y-6">
              <div className="space-y-2">
                <Label htmlFor="guideName">Guide Name *</Label>
                <Input
                  id="guideName"
                  value={formData.guideName}
                  onChange={(e) => setFormData({ ...formData, guideName: e.target.value })}
                  placeholder="e.g., Complete PC Assembly Guide"
                  required
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="description">Description *</Label>
                <Textarea
                  id="description"
                  value={formData.description}
                  onChange={(e) => setFormData({ ...formData, description: e.target.value })}
                  placeholder="Describe your build guide..."
                  rows={4}
                  required
                />
              </div>

              <div className="space-y-2">
                <Label htmlFor="buildId">Build ID (Optional)</Label>
                <Input
                  id="buildId"
                  type="number"
                  value={formData.buildId}
                  onChange={(e) => setFormData({ ...formData, buildId: e.target.value })}
                  placeholder="Link to an existing build (optional)"
                />
                <p className="text-xs text-slate-500">
                  If you have a saved build, enter its ID to link this guide to it
                </p>
              </div>

              <div className="space-y-2">
                <Label htmlFor="difficulty">Difficulty Level *</Label>
                <Select
                  value={formData.difficulty}
                  onValueChange={(value) => setFormData({ ...formData, difficulty: value })}
                >
                  <SelectTrigger>
                    <SelectValue />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="Beginner">Beginner</SelectItem>
                    <SelectItem value="Intermediate">Intermediate</SelectItem>
                    <SelectItem value="Advanced">Advanced</SelectItem>
                  </SelectContent>
                </Select>
              </div>

              <div className="space-y-2">
                <Label htmlFor="steps">Steps *</Label>
                <Textarea
                  id="steps"
                  value={formData.steps}
                  onChange={(e) => setFormData({ ...formData, steps: e.target.value })}
                  placeholder="Enter each step on a new line:&#10;Step 1: Prepare workspace&#10;Step 2: Install CPU&#10;..."
                  rows={8}
                  required
                />
                <p className="text-xs text-slate-500">
                  Enter each step on a new line
                </p>
              </div>

              <div className="space-y-2">
                <Label htmlFor="tools">Required Tools</Label>
                <Input
                  id="tools"
                  value={formData.tools}
                  onChange={(e) => setFormData({ ...formData, tools: e.target.value })}
                  placeholder="e.g., Screwdriver, Thermal paste, Anti-static wrist strap"
                />
                <p className="text-xs text-slate-500">
                  Separate tools with commas
                </p>
              </div>

              <div className="flex gap-4">
                <Button type="submit" disabled={loading}>
                  <Save className="h-4 w-4 mr-2" />
                  {loading ? "Submitting..." : "Submit Guide"}
                </Button>
                <Button type="button" variant="outline" onClick={() => router.push("/guides")}>
                  Cancel
                </Button>
              </div>
            </form>
          </CardContent>
        </Card>
      </div>
    </div>
  )
}

