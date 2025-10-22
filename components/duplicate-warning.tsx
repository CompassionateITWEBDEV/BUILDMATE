"use client"

import React from "react"
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert"
import { Button } from "@/components/ui/button"
import { Badge } from "@/components/ui/badge"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogTrigger } from "@/components/ui/dialog"
import { 
  AlertTriangle, 
  CheckCircle, 
  Info, 
  X, 
  Eye, 
  Edit, 
  Copy,
  Lightbulb,
  AlertCircle
} from "lucide-react"
import { BuildComparison } from "@/lib/duplicate-detector"

interface DuplicateWarningProps {
  comparisons: BuildComparison[]
  onDismiss: () => void
  onViewSimilar: (buildId: string) => void
  onEditSimilar: (buildId: string) => void
  onProceedAnyway: () => void
  onModifyBuild: () => void
}

export function DuplicateWarning({
  comparisons,
  onDismiss,
  onViewSimilar,
  onEditSimilar,
  onProceedAnyway,
  onModifyBuild
}: DuplicateWarningProps) {
  const exactDuplicates = comparisons.filter(c => c.similarityScore >= 0.95)
  const similarBuilds = comparisons.filter(c => c.similarityScore >= 0.6 && c.similarityScore < 0.95)

  if (comparisons.length === 0) return null

  return (
    <div className="space-y-4">
      {/* Exact Duplicates Alert */}
      {exactDuplicates.length > 0 && (
        <Alert className="border-red-200 bg-red-50 dark:border-red-800 dark:bg-red-950">
          <AlertTriangle className="h-4 w-4 text-red-600" />
          <AlertTitle className="text-red-800 dark:text-red-200">
            Exact Duplicates Detected
          </AlertTitle>
          <AlertDescription className="text-red-700 dark:text-red-300">
            We found {exactDuplicates.length} build(s) that are nearly identical to yours. 
            Consider updating the existing build instead of creating a new one.
          </AlertDescription>
        </Alert>
      )}

      {/* Similar Builds Alert */}
      {similarBuilds.length > 0 && (
        <Alert className="border-yellow-200 bg-yellow-50 dark:border-yellow-800 dark:bg-yellow-950">
          <AlertCircle className="h-4 w-4 text-yellow-600" />
          <AlertTitle className="text-yellow-800 dark:text-yellow-200">
            Similar Builds Found
          </AlertTitle>
          <AlertDescription className="text-yellow-700 dark:text-yellow-300">
            We found {similarBuilds.length} build(s) that are very similar to yours. 
            Review them to ensure your build is unique.
          </AlertDescription>
        </Alert>
      )}

      {/* Detailed Comparison Cards */}
      <div className="space-y-3">
        {comparisons.slice(0, 3).map((comparison, index) => (
          <Card key={index} className={`border-l-4 ${
            comparison.similarityScore >= 0.95 
              ? 'border-l-red-500 bg-red-50 dark:bg-red-950' 
              : 'border-l-yellow-500 bg-yellow-50 dark:bg-yellow-950'
          }`}>
            <CardHeader className="pb-3">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-2">
                  <CardTitle className="text-sm font-medium">
                    {comparison.existingBuildName}
                  </CardTitle>
                  <Badge variant={comparison.similarityScore >= 0.95 ? "destructive" : "secondary"}>
                    {Math.round(comparison.similarityScore * 100)}% match
                  </Badge>
                </div>
                <Button
                  variant="ghost"
                  size="sm"
                  onClick={onDismiss}
                  className="h-6 w-6 p-0"
                >
                  <X className="h-3 w-3" />
                </Button>
              </div>
            </CardHeader>
            <CardContent className="space-y-3">
              {/* Duplicate Reasons */}
              {comparison.duplicateReasons.length > 0 && (
                <div>
                  <h4 className="text-xs font-medium text-slate-700 dark:text-slate-300 mb-2">
                    Why it's similar:
                  </h4>
                  <ul className="space-y-1">
                    {comparison.duplicateReasons.map((reason, reasonIndex) => (
                      <li key={reasonIndex} className="text-xs text-slate-600 dark:text-slate-400 flex items-center gap-1">
                        <div className="w-1 h-1 bg-slate-400 rounded-full" />
                        {reason}
                      </li>
                    ))}
                  </ul>
                </div>
              )}

              {/* Suggested Actions */}
              {comparison.suggestedActions.length > 0 && (
                <div>
                  <h4 className="text-xs font-medium text-slate-700 dark:text-slate-300 mb-2 flex items-center gap-1">
                    <Lightbulb className="h-3 w-3" />
                    Suggestions:
                  </h4>
                  <ul className="space-y-1">
                    {comparison.suggestedActions.map((action, actionIndex) => (
                      <li key={actionIndex} className="text-xs text-slate-600 dark:text-slate-400 flex items-center gap-1">
                        <div className="w-1 h-1 bg-blue-400 rounded-full" />
                        {action}
                      </li>
                    ))}
                  </ul>
                </div>
              )}

              {/* Action Buttons */}
              <div className="flex gap-2 pt-2">
                <Button
                  size="sm"
                  variant="outline"
                  onClick={() => onViewSimilar(comparison.existingBuildId || '')}
                  className="text-xs h-7"
                >
                  <Eye className="h-3 w-3 mr-1" />
                  View
                </Button>
                <Button
                  size="sm"
                  variant="outline"
                  onClick={() => onEditSimilar(comparison.existingBuildId || '')}
                  className="text-xs h-7"
                >
                  <Edit className="h-3 w-3 mr-1" />
                  Edit
                </Button>
                <Button
                  size="sm"
                  variant="outline"
                  onClick={onModifyBuild}
                  className="text-xs h-7"
                >
                  <Copy className="h-3 w-3 mr-1" />
                  Modify Mine
                </Button>
              </div>
            </CardContent>
          </Card>
        ))}
      </div>

      {/* Action Buttons */}
      <div className="flex gap-3 pt-2">
        <Button
          onClick={onProceedAnyway}
          variant="outline"
          className="flex-1"
        >
          Proceed Anyway
        </Button>
        <Button
          onClick={onModifyBuild}
          className="flex-1"
        >
          Modify Build
        </Button>
      </div>

      {/* Additional Info */}
      <div className="text-xs text-slate-500 dark:text-slate-400 bg-slate-50 dark:bg-slate-800 p-3 rounded-lg">
        <div className="flex items-start gap-2">
          <Info className="h-3 w-3 mt-0.5 flex-shrink-0" />
          <div>
            <p className="font-medium mb-1">Why we check for duplicates:</p>
            <ul className="space-y-1">
              <li>• Prevents cluttering your build library with similar builds</li>
              <li>• Helps you organize and manage your builds better</li>
              <li>• Suggests improvements to make your builds more unique</li>
              <li>• Maintains a clean, organized build collection</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  )
}

interface DuplicateCheckDialogProps {
  open: boolean
  onOpenChange: (open: boolean) => void
  comparisons: BuildComparison[]
  onViewSimilar: (buildId: string) => void
  onEditSimilar: (buildId: string) => void
  onProceedAnyway: () => void
  onModifyBuild: () => void
}

export function DuplicateCheckDialog({
  open,
  onOpenChange,
  comparisons,
  onViewSimilar,
  onEditSimilar,
  onProceedAnyway,
  onModifyBuild
}: DuplicateCheckDialogProps) {
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-2xl max-h-[80vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="flex items-center gap-2">
            <AlertTriangle className="h-5 w-5 text-yellow-500" />
            Duplicate Build Detection
          </DialogTitle>
          <DialogDescription>
            We found similar builds in your collection. Review them before proceeding.
          </DialogDescription>
        </DialogHeader>
        
        <DuplicateWarning
          comparisons={comparisons}
          onDismiss={() => onOpenChange(false)}
          onViewSimilar={onViewSimilar}
          onEditSimilar={onEditSimilar}
          onProceedAnyway={() => {
            onProceedAnyway()
            onOpenChange(false)
          }}
          onModifyBuild={() => {
            onModifyBuild()
            onOpenChange(false)
          }}
        />
      </DialogContent>
    </Dialog>
  )
}
