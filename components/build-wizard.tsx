"use client"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group"
import { Label } from "@/components/ui/label"
import { Input } from "@/components/ui/input"
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog"
import {
  Cpu,
  Monitor,
  Zap,
  DollarSign,
  ArrowRight,
  ArrowLeft,
  HelpCircle,
  Lightbulb,
  CheckCircle2,
} from "lucide-react"
import { type PerformanceCategory } from "@/lib/mock-data"

interface BuildWizardProps {
  isOpen: boolean
  onComplete: (data: {
    priorityComponent: "gpu" | "cpu" | "none"
    budget: number
    performanceCategory: PerformanceCategory
    experienceLevel: "beginner" | "intermediate" | "advanced"
  }) => void
  onSkip: () => void
}

export function BuildWizard({ isOpen, onComplete, onSkip }: BuildWizardProps) {
  const [step, setStep] = useState(1)
  const [priorityComponent, setPriorityComponent] = useState<"gpu" | "cpu" | "none">("none")
  const [budget, setBudget] = useState("")
  const [performanceCategory, setPerformanceCategory] = useState<PerformanceCategory>("all")
  const [experienceLevel, setExperienceLevel] = useState<"beginner" | "intermediate" | "advanced">("beginner")

  const totalSteps = 4

  const handleNext = () => {
    if (step < totalSteps) {
      setStep(step + 1)
    } else {
      handleComplete()
    }
  }

  const handleBack = () => {
    if (step > 1) {
      setStep(step - 1)
    }
  }

  const handleComplete = () => {
    onComplete({
      priorityComponent,
      budget: Number.parseInt(budget) || 0,
      performanceCategory,
      experienceLevel,
    })
  }

  const handleSkip = () => {
    onSkip()
  }

  if (!isOpen) return null

  return (
    <Dialog open={isOpen} onOpenChange={() => {}}>
      <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
        <DialogHeader>
          <DialogTitle className="text-2xl font-bold">
            {step === 1 && "Welcome to BuildMate! 🎉"}
            {step === 2 && "What's Your Priority?"}
            {step === 3 && "What's Your Budget?"}
            {step === 4 && "Tell Us About Yourself"}
          </DialogTitle>
          <DialogDescription>
            {step === 1 && "Let's guide you through building your perfect PC step by step."}
            {step === 2 && "Choose which component is most important for your build."}
            {step === 3 && "Set your budget to get personalized recommendations."}
            {step === 4 && "Help us customize your experience."}
          </DialogDescription>
        </DialogHeader>

        <div className="space-y-6 py-4">
          {/* Progress Indicator */}
          <div className="flex items-center justify-between mb-6">
            <div className="flex-1">
              <div className="flex gap-2">
                {Array.from({ length: totalSteps }).map((_, i) => (
                  <div
                    key={i}
                    className={`flex-1 h-2 rounded-full transition-all ${
                      i + 1 <= step
                        ? "bg-blue-600"
                        : "bg-slate-200 dark:bg-slate-700"
                    }`}
                  />
                ))}
              </div>
              <p className="text-xs text-slate-500 dark:text-slate-400 mt-2 text-center">
                Step {step} of {totalSteps}
              </p>
            </div>
          </div>

          {/* Step 1: Welcome */}
          {step === 1 && (
            <div className="space-y-4">
              <Card className="border-blue-200 dark:border-blue-800 bg-blue-50 dark:bg-blue-950/20">
                <CardHeader>
                  <CardTitle className="flex items-center gap-2 text-lg">
                    <Lightbulb className="h-5 w-5 text-blue-600" />
                    How This Works
                  </CardTitle>
                </CardHeader>
                <CardContent className="space-y-3 text-sm">
                  <div className="flex items-start gap-3">
                    <CheckCircle2 className="h-5 w-5 text-blue-600 flex-shrink-0 mt-0.5" />
                    <div>
                      <p className="font-medium">Step-by-Step Guidance</p>
                      <p className="text-slate-600 dark:text-slate-400">
                        We'll guide you through selecting each component with clear instructions.
                      </p>
                    </div>
                  </div>
                  <div className="flex items-start gap-3">
                    <CheckCircle2 className="h-5 w-5 text-blue-600 flex-shrink-0 mt-0.5" />
                    <div>
                      <p className="font-medium">Automatic Compatibility</p>
                      <p className="text-slate-600 dark:text-slate-400">
                        Incompatible components are automatically filtered out to prevent mistakes.
                      </p>
                    </div>
                  </div>
                  <div className="flex items-start gap-3">
                    <CheckCircle2 className="h-5 w-5 text-blue-600 flex-shrink-0 mt-0.5" />
                    <div>
                      <p className="font-medium">Smart Recommendations</p>
                      <p className="text-slate-600 dark:text-slate-400">
                        Get personalized suggestions based on your needs and budget.
                      </p>
                    </div>
                  </div>
                </CardContent>
              </Card>
            </div>
          )}

          {/* Step 2: Priority Component */}
          {step === 2 && (
            <div className="space-y-4">
              <p className="text-sm text-slate-600 dark:text-slate-400">
                Starting with a priority component helps us recommend compatible parts. You can always change this later.
              </p>
              <RadioGroup
                value={priorityComponent}
                onValueChange={(value) => setPriorityComponent(value as "gpu" | "cpu" | "none")}
                className="space-y-3"
              >
                <Label
                  htmlFor="gpu"
                  className={`flex items-start gap-3 p-4 border-2 rounded-lg cursor-pointer transition-all ${
                    priorityComponent === "gpu"
                      ? "border-blue-600 bg-blue-50 dark:bg-blue-950/20"
                      : "border-slate-200 dark:border-slate-700 hover:border-blue-300"
                  }`}
                >
                  <RadioGroupItem value="gpu" id="gpu" className="mt-1" />
                  <div className="flex-1">
                    <div className="flex items-center gap-2 mb-1">
                      <Monitor className="h-5 w-5 text-blue-600" />
                      <span className="font-semibold">Graphics Card (GPU) First</span>
                    </div>
                    <p className="text-sm text-slate-600 dark:text-slate-400">
                      Perfect for gaming, video editing, or 3D rendering. We'll find a compatible CPU and other components.
                    </p>
                  </div>
                </Label>

                <Label
                  htmlFor="cpu"
                  className={`flex items-start gap-3 p-4 border-2 rounded-lg cursor-pointer transition-all ${
                    priorityComponent === "cpu"
                      ? "border-blue-600 bg-blue-50 dark:bg-blue-950/20"
                      : "border-slate-200 dark:border-slate-700 hover:border-blue-300"
                  }`}
                >
                  <RadioGroupItem value="cpu" id="cpu" className="mt-1" />
                  <div className="flex-1">
                    <div className="flex items-center gap-2 mb-1">
                      <Cpu className="h-5 w-5 text-blue-600" />
                      <span className="font-semibold">Processor (CPU) First</span>
                    </div>
                    <p className="text-sm text-slate-600 dark:text-slate-400">
                      Great for productivity, programming, or general use. We'll match it with compatible components.
                    </p>
                  </div>
                </Label>

                <Label
                  htmlFor="none"
                  className={`flex items-start gap-3 p-4 border-2 rounded-lg cursor-pointer transition-all ${
                    priorityComponent === "none"
                      ? "border-blue-600 bg-blue-50 dark:bg-blue-950/20"
                      : "border-slate-200 dark:border-slate-700 hover:border-blue-300"
                  }`}
                >
                  <RadioGroupItem value="none" id="none" className="mt-1" />
                  <div className="flex-1">
                    <div className="flex items-center gap-2 mb-1">
                      <Zap className="h-5 w-5 text-blue-600" />
                      <span className="font-semibold">No Priority - I'll Choose</span>
                    </div>
                    <p className="text-sm text-slate-600 dark:text-slate-400">
                      I want full control and will select components myself.
                    </p>
                  </div>
                </Label>
              </RadioGroup>
            </div>
          )}

          {/* Step 3: Budget */}
          {step === 3 && (
            <div className="space-y-4">
              <p className="text-sm text-slate-600 dark:text-slate-400">
                Setting a budget helps us recommend components that fit your price range. You can skip this if you prefer.
              </p>
              <div className="space-y-2">
                <Label htmlFor="budget" className="flex items-center gap-2">
                  <DollarSign className="h-4 w-4" />
                  Budget (PHP)
                </Label>
                <Input
                  id="budget"
                  type="number"
                  placeholder="e.g., 50000"
                  value={budget}
                  onChange={(e) => setBudget(e.target.value)}
                  className="text-lg"
                  aria-label="Budget in PHP"
                />
                <p className="text-xs text-slate-500 dark:text-slate-400">
                  Leave empty if you don't have a specific budget
                </p>
              </div>

              <div className="space-y-2">
                <Label>What will you use this PC for?</Label>
                <RadioGroup
                  value={performanceCategory}
                  onValueChange={(value) => setPerformanceCategory(value as PerformanceCategory)}
                  className="space-y-2"
                >
                  <div className="flex items-center space-x-2">
                    <RadioGroupItem value="gaming" id="gaming" />
                    <Label htmlFor="gaming" className="cursor-pointer font-normal">
                      🎮 Gaming - High performance for games
                    </Label>
                  </div>
                  <div className="flex items-center space-x-2">
                    <RadioGroupItem value="office" id="office" />
                    <Label htmlFor="office" className="cursor-pointer font-normal">
                      💼 Office - Productivity and business tasks
                    </Label>
                  </div>
                  <div className="flex items-center space-x-2">
                    <RadioGroupItem value="academic" id="academic" />
                    <Label htmlFor="academic" className="cursor-pointer font-normal">
                      🎓 Academic - Research, coding, and education
                    </Label>
                  </div>
                  <div className="flex items-center space-x-2">
                    <RadioGroupItem value="all" id="all" />
                    <Label htmlFor="all" className="cursor-pointer font-normal">
                      📦 All Components - Show everything
                    </Label>
                  </div>
                </RadioGroup>
              </div>
            </div>
          )}

          {/* Step 4: Experience Level */}
          {step === 4 && (
            <div className="space-y-4">
              <p className="text-sm text-slate-600 dark:text-slate-400">
                Help us customize the guidance level for your experience.
              </p>
              <RadioGroup
                value={experienceLevel}
                onValueChange={(value) => setExperienceLevel(value as "beginner" | "intermediate" | "advanced")}
                className="space-y-3"
              >
                <Label
                  htmlFor="beginner"
                  className={`flex items-start gap-3 p-4 border-2 rounded-lg cursor-pointer transition-all ${
                    experienceLevel === "beginner"
                      ? "border-blue-600 bg-blue-50 dark:bg-blue-950/20"
                      : "border-slate-200 dark:border-slate-700 hover:border-blue-300"
                  }`}
                >
                  <RadioGroupItem value="beginner" id="beginner" className="mt-1" />
                  <div className="flex-1">
                    <span className="font-semibold block mb-1">Beginner</span>
                    <p className="text-sm text-slate-600 dark:text-slate-400">
                      First time building a PC? We'll provide detailed explanations and step-by-step guidance.
                    </p>
                  </div>
                </Label>

                <Label
                  htmlFor="intermediate"
                  className={`flex items-start gap-3 p-4 border-2 rounded-lg cursor-pointer transition-all ${
                    experienceLevel === "intermediate"
                      ? "border-blue-600 bg-blue-50 dark:bg-blue-950/20"
                      : "border-slate-200 dark:border-slate-700 hover:border-blue-300"
                  }`}
                >
                  <RadioGroupItem value="intermediate" id="intermediate" className="mt-1" />
                  <div className="flex-1">
                    <span className="font-semibold block mb-1">Intermediate</span>
                    <p className="text-sm text-slate-600 dark:text-slate-400">
                      Built a PC before? We'll provide helpful tips without overwhelming you with details.
                    </p>
                  </div>
                </Label>

                <Label
                  htmlFor="advanced"
                  className={`flex items-start gap-3 p-4 border-2 rounded-lg cursor-pointer transition-all ${
                    experienceLevel === "advanced"
                      ? "border-blue-600 bg-blue-50 dark:bg-blue-950/20"
                      : "border-slate-200 dark:border-slate-700 hover:border-blue-300"
                  }`}
                >
                  <RadioGroupItem value="advanced" id="advanced" className="mt-1" />
                  <div className="flex-1">
                    <span className="font-semibold block mb-1">Advanced</span>
                    <p className="text-sm text-slate-600 dark:text-slate-400">
                      Experienced builder? We'll keep it minimal and let you focus on component selection.
                    </p>
                  </div>
                </Label>
              </RadioGroup>
            </div>
          )}
        </div>

        {/* Navigation Buttons */}
        <div className="flex items-center justify-between pt-4 border-t">
          <div className="flex gap-2">
            {step > 1 && (
              <Button variant="outline" onClick={handleBack} aria-label="Previous step">
                <ArrowLeft className="h-4 w-4 mr-2" />
                Back
              </Button>
            )}
            <Button variant="ghost" onClick={handleSkip} className="text-slate-500">
              Skip Wizard
            </Button>
          </div>
          <Button onClick={handleNext} aria-label={step === totalSteps ? "Complete setup" : "Next step"}>
            {step === totalSteps ? "Start Building" : "Next"}
            {step < totalSteps && <ArrowRight className="h-4 w-4 ml-2" />}
          </Button>
        </div>
      </DialogContent>
    </Dialog>
  )
}

