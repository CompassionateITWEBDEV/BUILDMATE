"use client"

import { useState } from "react"
import { useParams, useRouter } from "next/navigation"
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card"
import { Badge } from "@/components/ui/badge"
import { Progress } from "@/components/ui/progress"
import { Checkbox } from "@/components/ui/checkbox"
import {
  ArrowLeft,
  Clock,
  Users,
  Star,
  CheckCircle,
  AlertTriangle,
  Info,
  RotateCcw,
  BookOpen,
  Wrench,
  Lightbulb,
  Share,
  Download,
} from "lucide-react"

// Mock guide data with detailed steps
const guideSteps = [
  {
    id: 1,
    title: "Prepare Your Workspace",
    description: "Set up a clean, well-lit workspace and gather all necessary tools",
    duration: "5 minutes",
    difficulty: "Easy",
    tools: ["Phillips screwdriver", "Anti-static wrist strap", "Good lighting"],
    tips: [
      "Work on a hard, flat surface away from carpets",
      "Ensure good lighting to see small components clearly",
      "Keep component boxes nearby for easy access",
    ],
    warnings: ["Avoid working on carpeted surfaces to prevent static buildup"],
    completed: false,
  },
  {
    id: 2,
    title: "Install Power Supply",
    description: "Mount the power supply unit in the case with proper orientation",
    duration: "10 minutes",
    difficulty: "Easy",
    tools: ["Phillips screwdriver", "PSU mounting screws"],
    tips: [
      "Install PSU with fan facing down if case has bottom ventilation",
      "Ensure the power switch is accessible",
      "Don't fully tighten screws until PSU is properly aligned",
    ],
    warnings: [
      "Make sure PSU is switched OFF before installation",
      "Check PSU orientation - fan should face ventilation",
    ],
    completed: false,
  },
  {
    id: 3,
    title: "Install Motherboard Standoffs",
    description: "Install brass standoffs in the case to mount the motherboard",
    duration: "8 minutes",
    difficulty: "Easy",
    tools: ["Motherboard standoffs", "Phillips screwdriver"],
    tips: [
      "Only install standoffs where motherboard mounting holes are located",
      "Hand-tighten standoffs - don't over-tighten",
      "Test fit motherboard before final installation",
    ],
    warnings: [
      "Extra standoffs can cause short circuits - only use what's needed",
      "Ensure standoffs are properly threaded into case",
    ],
    completed: false,
  },
  {
    id: 4,
    title: "Install CPU",
    description: "Carefully install the processor into the motherboard socket",
    duration: "15 minutes",
    difficulty: "Medium",
    tools: ["Anti-static protection"],
    tips: [
      "Handle CPU by edges only - never touch pins or contacts",
      "CPU will only fit one way - don't force it",
      "Remove plastic socket cover after CPU installation",
    ],
    warnings: [
      "NEVER force the CPU - it should drop in easily",
      "Static electricity can damage the CPU - stay grounded",
      "Keep CPU in anti-static packaging until ready to install",
    ],
    completed: false,
  },
  {
    id: 5,
    title: "Install RAM",
    description: "Insert memory modules into the correct DIMM slots",
    duration: "5 minutes",
    difficulty: "Easy",
    tools: [],
    tips: [
      "Check motherboard manual for correct slot configuration",
      "Press down firmly until clips snap into place",
      "For dual-channel, use slots 2 and 4 first (usually color-coded)",
    ],
    warnings: [
      "Ensure RAM is fully seated - you should hear a click",
      "Match RAM speed with motherboard specifications",
    ],
    completed: false,
  },
]

export default function GuideDetailPage() {
  const params = useParams()
  const router = useRouter()
  const [currentStep, setCurrentStep] = useState(1)
  const [completedSteps, setCompletedSteps] = useState<number[]>([])
  const [isPlaying, setIsPlaying] = useState(false)

  // Mock guide data
  const guide = {
    id: params.id,
    title: "Your First Gaming PC Build",
    description: "Complete step-by-step guide for building your first gaming PC from scratch",
    difficulty: "Beginner",
    duration: "2-3 hours",
    rating: 4.8,
    reviews: 1247,
    views: "45.2k",
    category: "Gaming",
    estimatedCost: "$800-1200",
    totalSteps: guideSteps.length,
    tools: ["Phillips screwdriver", "Anti-static wrist strap", "Zip ties", "Thermal paste"],
    lastUpdated: "2 weeks ago",
  }

  const progress = (completedSteps.length / guide.totalSteps) * 100
  const currentStepData = guideSteps.find((step) => step.id === currentStep)

  const handleStepComplete = (stepId: number) => {
    setCompletedSteps((prev) => (prev.includes(stepId) ? prev.filter((id) => id !== stepId) : [...prev, stepId]))
  }

  const nextStep = () => {
    if (currentStep < guide.totalSteps) {
      setCurrentStep(currentStep + 1)
    }
  }

  const prevStep = () => {
    if (currentStep > 1) {
      setCurrentStep(currentStep - 1)
    }
  }

  const resetProgress = () => {
    setCompletedSteps([])
    setCurrentStep(1)
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      {/* Header */}
      <header className="border-b bg-white/80 backdrop-blur-sm dark:bg-slate-900/80">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center gap-4">
            <Button variant="ghost" size="sm" onClick={() => router.back()}>
              <ArrowLeft className="h-4 w-4 mr-2" />
              Back to Guides
            </Button>
            <div className="flex items-center gap-2">
              <BookOpen className="h-6 w-6 text-blue-600" />
              <h1 className="text-xl font-bold text-slate-900 dark:text-white">Build Guide</h1>
            </div>
          </div>
        </div>
      </header>

      <div className="container mx-auto px-4 py-8">
        <div className="grid lg:grid-cols-4 gap-8">
          {/* Main Content */}
          <div className="lg:col-span-3 space-y-6">
            {/* Guide Header */}
            <Card>
              <CardHeader>
                <div className="flex items-start justify-between">
                  <div>
                    <CardTitle className="text-2xl mb-2">{guide.title}</CardTitle>
                    <CardDescription className="text-base mb-4">{guide.description}</CardDescription>

                    <div className="flex items-center gap-4 mb-4">
                      <Badge variant={guide.difficulty === "Beginner" ? "secondary" : "default"}>
                        {guide.difficulty}
                      </Badge>
                      <div className="flex items-center gap-1 text-sm text-slate-600 dark:text-slate-400">
                        <Clock className="h-4 w-4" />
                        {guide.duration}
                      </div>
                      <div className="flex items-center gap-1 text-sm text-slate-600 dark:text-slate-400">
                        <Users className="h-4 w-4" />
                        {guide.views} views
                      </div>
                      <div className="flex items-center gap-1 text-sm text-slate-600 dark:text-slate-400">
                        <Star className="h-4 w-4 text-yellow-400 fill-current" />
                        {guide.rating} ({guide.reviews} reviews)
                      </div>
                    </div>

                    {/* Progress */}
                    <div className="space-y-2">
                      <div className="flex items-center justify-between text-sm">
                        <span className="text-slate-600 dark:text-slate-400">Progress</span>
                        <span className="font-medium">
                          {completedSteps.length}/{guide.totalSteps} steps completed
                        </span>
                      </div>
                      <Progress value={progress} className="h-2" />
                    </div>
                  </div>

                  <div className="flex gap-2">
                    <Button variant="outline" size="sm">
                      <Share className="h-4 w-4 mr-2" />
                      Share
                    </Button>
                    <Button variant="outline" size="sm">
                      <Download className="h-4 w-4 mr-2" />
                      Download
                    </Button>
                    <Button variant="outline" size="sm" onClick={resetProgress}>
                      <RotateCcw className="h-4 w-4 mr-2" />
                      Reset
                    </Button>
                  </div>
                </div>
              </CardHeader>
            </Card>

            {/* Current Step */}
            {currentStepData && (
              <Card>
                <CardHeader>
                  <div className="flex items-center justify-between">
                    <div>
                      <CardTitle className="text-xl">
                        Step {currentStep}: {currentStepData.title}
                      </CardTitle>
                      <CardDescription className="mt-2">{currentStepData.description}</CardDescription>
                    </div>
                    <div className="flex items-center gap-2">
                      <Badge variant={currentStepData.difficulty === "Easy" ? "secondary" : "default"}>
                        {currentStepData.difficulty}
                      </Badge>
                      <div className="flex items-center gap-1 text-sm text-slate-600 dark:text-slate-400">
                        <Clock className="h-4 w-4" />
                        {currentStepData.duration}
                      </div>
                    </div>
                  </div>
                </CardHeader>

                <CardContent className="space-y-6">
                  {/* Tools Required */}
                  {currentStepData.tools.length > 0 && (
                    <div>
                      <h4 className="font-medium mb-2 flex items-center gap-2">
                        <Wrench className="h-4 w-4" />
                        Tools Required
                      </h4>
                      <div className="flex flex-wrap gap-2">
                        {currentStepData.tools.map((tool, index) => (
                          <Badge key={index} variant="outline">
                            {tool}
                          </Badge>
                        ))}
                      </div>
                    </div>
                  )}

                  {/* Tips */}
                  {currentStepData.tips.length > 0 && (
                    <div>
                      <h4 className="font-medium mb-2 flex items-center gap-2">
                        <Lightbulb className="h-4 w-4 text-yellow-500" />
                        Pro Tips
                      </h4>
                      <div className="space-y-2">
                        {currentStepData.tips.map((tip, index) => (
                          <div key={index} className="flex items-start gap-2">
                            <Info className="h-4 w-4 text-blue-500 mt-0.5 flex-shrink-0" />
                            <p className="text-sm text-slate-600 dark:text-slate-400">{tip}</p>
                          </div>
                        ))}
                      </div>
                    </div>
                  )}

                  {/* Warnings */}
                  {currentStepData.warnings.length > 0 && (
                    <div>
                      <h4 className="font-medium mb-2 flex items-center gap-2">
                        <AlertTriangle className="h-4 w-4 text-red-500" />
                        Important Warnings
                      </h4>
                      <div className="space-y-2">
                        {currentStepData.warnings.map((warning, index) => (
                          <div
                            key={index}
                            className="flex items-start gap-2 p-3 bg-red-50 dark:bg-red-900/20 rounded-lg"
                          >
                            <AlertTriangle className="h-4 w-4 text-red-500 mt-0.5 flex-shrink-0" />
                            <p className="text-sm text-red-700 dark:text-red-300">{warning}</p>
                          </div>
                        ))}
                      </div>
                    </div>
                  )}

                  {/* Step Completion */}
                  <div className="flex items-center justify-between pt-4 border-t border-slate-200 dark:border-slate-700">
                    <div className="flex items-center space-x-2">
                      <Checkbox
                        id={`step-${currentStep}`}
                        checked={completedSteps.includes(currentStep)}
                        onCheckedChange={() => handleStepComplete(currentStep)}
                      />
                      <label
                        htmlFor={`step-${currentStep}`}
                        className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
                      >
                        Mark this step as completed
                      </label>
                    </div>

                    <div className="flex gap-2">
                      <Button variant="outline" onClick={prevStep} disabled={currentStep === 1}>
                        Previous
                      </Button>
                      <Button onClick={nextStep} disabled={currentStep === guide.totalSteps}>
                        {currentStep === guide.totalSteps ? "Finish" : "Next Step"}
                      </Button>
                    </div>
                  </div>
                </CardContent>
              </Card>
            )}
          </div>

          {/* Sidebar */}
          <div className="space-y-6">
            {/* Guide Overview */}
            <Card>
              <CardHeader>
                <CardTitle>Guide Overview</CardTitle>
              </CardHeader>
              <CardContent className="space-y-3">
                <div className="flex justify-between text-sm">
                  <span className="text-slate-600 dark:text-slate-400">Difficulty</span>
                  <span className="font-medium">{guide.difficulty}</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-slate-600 dark:text-slate-400">Duration</span>
                  <span className="font-medium">{guide.duration}</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-slate-600 dark:text-slate-400">Total Steps</span>
                  <span className="font-medium">{guide.totalSteps}</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-slate-600 dark:text-slate-400">Estimated Cost</span>
                  <span className="font-medium">{guide.estimatedCost}</span>
                </div>
                <div className="flex justify-between text-sm">
                  <span className="text-slate-600 dark:text-slate-400">Last Updated</span>
                  <span className="font-medium">{guide.lastUpdated}</span>
                </div>
              </CardContent>
            </Card>

            {/* Tools Needed */}
            <Card>
              <CardHeader>
                <CardTitle>Tools Needed</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-2">
                  {guide.tools.map((tool, index) => (
                    <div key={index} className="flex items-center gap-2">
                      <CheckCircle className="h-4 w-4 text-green-500" />
                      <span className="text-sm">{tool}</span>
                    </div>
                  ))}
                </div>
              </CardContent>
            </Card>

            {/* Step Navigation */}
            <Card>
              <CardHeader>
                <CardTitle>All Steps</CardTitle>
              </CardHeader>
              <CardContent>
                <div className="space-y-2">
                  {guideSteps.map((step) => (
                    <button
                      key={step.id}
                      onClick={() => setCurrentStep(step.id)}
                      className={`w-full text-left p-2 rounded-lg text-sm transition-colors ${
                        currentStep === step.id
                          ? "bg-blue-100 dark:bg-blue-900/30 text-blue-700 dark:text-blue-300"
                          : "hover:bg-slate-100 dark:hover:bg-slate-800"
                      }`}
                    >
                      <div className="flex items-center gap-2">
                        {completedSteps.includes(step.id) ? (
                          <CheckCircle className="h-4 w-4 text-green-500" />
                        ) : (
                          <div className="h-4 w-4 border border-slate-300 rounded-full" />
                        )}
                        <span className="font-medium">Step {step.id}</span>
                      </div>
                      <p className="text-xs text-slate-600 dark:text-slate-400 mt-1 ml-6">{step.title}</p>
                    </button>
                  ))}
                </div>
              </CardContent>
            </Card>
          </div>
        </div>
      </div>
    </div>
  )
}
