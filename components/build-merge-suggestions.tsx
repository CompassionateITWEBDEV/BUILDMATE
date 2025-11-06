"use client"

import React, { useState } from "react"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Button } from "@/components/ui/button"
import { Badge } from "@/components/ui/badge"
import { Checkbox } from "@/components/ui/checkbox"
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle } from "@/components/ui/dialog"
import { 
  Merge, 
  ArrowRight, 
  CheckCircle, 
  AlertTriangle,
  Lightbulb,
  Cpu,
  Monitor,
  MemoryStick,
  HardDrive,
  Zap,
  Fan,
  Clapperboard as Motherboard
} from "lucide-react"
import { Component, ComponentCategory, mockComponents } from "@/lib/mock-data"
import { BuildComparison } from "@/lib/duplicate-detector"
import { formatCurrency } from "@/lib/currency"

interface BuildMergeSuggestionsProps {
  comparisons: BuildComparison[]
  currentComponents: Record<ComponentCategory, Component | null>
  onMerge: (mergedComponents: Record<ComponentCategory, Component | null>) => void
  onDismiss: () => void
}

const categoryIcons = {
  cpu: Cpu,
  motherboard: Motherboard,
  memory: MemoryStick,
  storage: HardDrive,
  gpu: Monitor,
  psu: Zap,
  case: HardDrive,
  cooling: Fan,
}

export function BuildMergeSuggestions({
  comparisons,
  currentComponents,
  onMerge,
  onDismiss
}: BuildMergeSuggestionsProps) {
  const [selectedComponents, setSelectedComponents] = useState<Record<string, Component | null>>({})
  const [showMergeDialog, setShowMergeDialog] = useState(false)

  const handleComponentToggle = (category: ComponentCategory, component: Component | null) => {
    setSelectedComponents(prev => ({
      ...prev,
      [category]: prev[category] === component ? null : component
    }))
  }

  const handleMerge = () => {
    // Merge current components with selected components
    const mergedComponents = { ...currentComponents }
    
    Object.entries(selectedComponents).forEach(([category, component]) => {
      if (component) {
        mergedComponents[category as ComponentCategory] = component
      }
    })

    onMerge(mergedComponents)
    setShowMergeDialog(false)
  }

  const getMergeSuggestions = () => {
    const suggestions: Array<{
      buildId: string
      buildName: string
      similarityScore: number
      suggestedComponents: Array<{
        category: ComponentCategory
        component: Component
        reason: string
      }>
    }> = []

    comparisons.forEach(comparison => {
      if (comparison.similarityScore >= 0.6) {
        // Mock suggested components - in real app, this would come from the comparison
        const suggestedComponents = [
          {
            category: 'cpu' as ComponentCategory,
            component: mockComponents.find(c => c.category === 'cpu' && c.id !== currentComponents.cpu?.id) || mockComponents[0],
            reason: 'Better performance for similar price'
          },
          {
            category: 'gpu' as ComponentCategory,
            component: mockComponents.find(c => c.category === 'gpu' && c.id !== currentComponents.gpu?.id) || mockComponents[1],
            reason: 'More recent model with better features'
          }
        ].filter(s => s.component)

        suggestions.push({
          buildId: comparison.existingBuildId || '',
          buildName: comparison.existingBuildName || 'Similar Build',
          similarityScore: comparison.similarityScore,
          suggestedComponents
        })
      }
    })

    return suggestions
  }

  const suggestions = getMergeSuggestions()

  if (suggestions.length === 0) return null

  return (
    <div className="space-y-4">
      <Card className="border-blue-200 bg-blue-50 dark:border-blue-800 dark:bg-blue-950">
        <CardHeader className="pb-3">
          <CardTitle className="text-sm flex items-center gap-2">
            <Lightbulb className="h-4 w-4 text-blue-600" />
            Build Improvement Suggestions
          </CardTitle>
          <CardDescription className="text-blue-700 dark:text-blue-300">
            We found similar builds that might have better components for your build.
          </CardDescription>
        </CardHeader>
      </Card>

      {suggestions.map((suggestion, index) => (
        <Card key={index} className="border-l-4 border-l-blue-500">
          <CardHeader className="pb-3">
            <div className="flex items-center justify-between">
              <div>
                <CardTitle className="text-sm">{suggestion.buildName}</CardTitle>
                <div className="flex items-center gap-2 mt-1">
                  <Badge variant="secondary">
                    {Math.round(suggestion.similarityScore * 100)}% similar
                  </Badge>
                  <span className="text-xs text-slate-500">
                    {suggestion.suggestedComponents.length} suggestions
                  </span>
                </div>
              </div>
              <Button
                size="sm"
                variant="outline"
                onClick={() => setShowMergeDialog(true)}
                className="text-xs"
              >
                <Merge className="h-3 w-3 mr-1" />
                Merge
              </Button>
            </div>
          </CardHeader>
          <CardContent>
            <div className="space-y-2">
              {suggestion.suggestedComponents.map((suggestion, compIndex) => {
                const Icon = categoryIcons[suggestion.category]
                return (
                  <div key={compIndex} className="flex items-center gap-3 p-2 bg-slate-50 dark:bg-slate-800 rounded">
                    <Icon className="h-4 w-4 text-slate-500" />
                    <div className="flex-1">
                      <p className="text-sm font-medium">{suggestion.component.name}</p>
                      <p className="text-xs text-slate-500">{suggestion.reason}</p>
                    </div>
                    <div className="text-right">
                      <p className="text-sm font-medium">{formatCurrency(suggestion.component.price)}</p>
                      <Button
                        size="sm"
                        variant="ghost"
                        onClick={() => handleComponentToggle(suggestion.category, suggestion.component)}
                        className="text-xs h-6 px-2"
                      >
                        {selectedComponents[suggestion.category]?.id === suggestion.component.id ? 'Remove' : 'Add'}
                      </Button>
                    </div>
                  </div>
                )
              })}
            </div>
          </CardContent>
        </Card>
      ))}

      {/* Merge Dialog */}
      <Dialog open={showMergeDialog} onOpenChange={setShowMergeDialog}>
        <DialogContent className="max-w-2xl">
          <DialogHeader>
            <DialogTitle className="flex items-center gap-2">
              <Merge className="h-5 w-5 text-blue-600" />
              Merge Build Components
            </DialogTitle>
            <DialogDescription>
              Select components from similar builds to improve your current build.
            </DialogDescription>
          </DialogHeader>
          
          <div className="space-y-4">
            <div className="grid gap-3">
              {Object.entries(selectedComponents).map(([category, component]) => {
                if (!component) return null
                const Icon = categoryIcons[category as ComponentCategory]
                return (
                  <div key={category} className="flex items-center gap-3 p-3 border rounded-lg">
                    <Checkbox
                      checked={true}
                      onCheckedChange={(checked) => 
                        handleComponentToggle(category as ComponentCategory, checked ? component : null)
                      }
                    />
                    <Icon className="h-4 w-4 text-slate-500" />
                    <div className="flex-1">
                      <p className="text-sm font-medium">{component.name}</p>
                      <p className="text-xs text-slate-500">{categoryNames[category as ComponentCategory]}</p>
                    </div>
                    <div className="text-right">
                      <p className="text-sm font-medium">{formatCurrency(component.price)}</p>
                    </div>
                  </div>
                )
              })}
            </div>

            <div className="flex gap-3 pt-4">
              <Button
                variant="outline"
                onClick={() => setShowMergeDialog(false)}
                className="flex-1"
              >
                Cancel
              </Button>
              <Button
                onClick={handleMerge}
                className="flex-1"
              >
                <Merge className="h-4 w-4 mr-2" />
                Merge Components
              </Button>
            </div>
          </div>
        </DialogContent>
      </Dialog>
    </div>
  )
}

const categoryNames = {
  cpu: "Processor",
  motherboard: "Motherboard",
  memory: "Memory (RAM)",
  storage: "Storage",
  gpu: "Graphics Card",
  psu: "Power Supply",
  case: "Case",
  cooling: "Cooling",
}
