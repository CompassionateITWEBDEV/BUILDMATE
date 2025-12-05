"use client"

import { useState, useEffect } from "react"
import dynamic from "next/dynamic"
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
  CheckCircle,
  AlertTriangle,
  Info,
  BookOpen,
  Wrench,
  Lightbulb,
} from "lucide-react"

// Use CSS-based 3D animation (more reliable than React Three Fiber)
import { PC3DCSSAnimation } from "@/components/pc-3d-css-animation"

// Complete guide steps with user-provided content and images
const guideSteps = [
  {
    id: 1,
    title: "Prepare Your Workspace and Check All Parts",
    description: "Before starting, lay everything on a clean, static-free table. Make sure you have all components ready.",
    duration: "5 minutes",
    difficulty: "Easy",
    tools: ["Screwdriver (magnetic tip recommended)", "Clean workspace", "Anti-static mat (optional)"],
    content: `Before starting, lay everything on a clean, static-free table. Make sure you have:

- Motherboard
- Processor (CPU)
- CPU Cooler / Fan
- Thermal Paste
- RAM (Memory)
- SSD or HDD (Storage)
- Graphics Card (GPU)
- Power Supply (PSU)
- PC Case
- Case Fans
- Screws and cables
- Screwdriver (magnetic tip recommended)

Double-check that nothing is missing. It's way easier to spot problems early.`,
    tips: [
      "Work on a hard, flat surface away from carpets",
      "Ensure good lighting to see small components clearly",
      "Keep component boxes nearby for easy access",
    ],
    warnings: ["Avoid working on carpeted surfaces to prevent static buildup"],
    image: "/1st.png",
    completed: false,
  },
  {
    id: 2,
    title: "Install the CPU on the Motherboard",
    description: "Carefully install the processor into the motherboard socket with proper alignment",
    duration: "10 minutes",
    difficulty: "Medium",
    tools: ["Anti-static protection"],
    content: `Place the motherboard on its box or an anti-static mat.

1. Open the CPU socket lever.
2. Align the golden triangle on the CPU with the matching triangle on the socket.
3. Gently lower the CPU into place—no force needed.
4. Lock the CPU using the lever.

If it doesn't fit easily, stop and realign. Never press down on a CPU.`,
    tips: [
      "Handle CPU by edges only - never touch pins or contacts",
      "CPU will only fit one way - don't force it",
      "The golden triangle is your alignment guide",
    ],
    warnings: [
      "NEVER force the CPU - it should drop in easily",
      "Static electricity can damage the CPU - stay grounded",
      "Keep CPU in anti-static packaging until ready to install",
    ],
    image: "/2nd.png",
    completed: false,
  },
  {
    id: 3,
    title: "Apply Thermal Paste and Install the CPU Cooler",
    description: "Apply thermal paste and mount the CPU cooler properly",
    duration: "15 minutes",
    difficulty: "Medium",
    tools: ["Thermal paste", "CPU cooler", "Screwdriver"],
    content: `1. Apply a pea-sized dot of thermal paste on top of the CPU.
2. Place the CPU cooler/fan directly on top.
3. Tighten the screws evenly in a cross pattern.
4. Connect the fan cable to the motherboard port labeled CPU_FAN.

The thermal paste helps transfer heat. Too much or too little can cause overheating.`,
    tips: [
      "A pea-sized amount is usually enough",
      "Tighten screws in a cross pattern for even pressure",
      "Make sure the cooler is making full contact with the CPU",
    ],
    warnings: [
      "Too much thermal paste can cause overheating",
      "Too little thermal paste can also cause overheating",
      "Don't forget to connect the CPU_FAN header",
    ],
    image: "/3rd.png",
    completed: false,
  },
  {
    id: 4,
    title: "Install RAM and SSD",
    description: "Install memory modules and storage drives",
    duration: "10 minutes",
    difficulty: "Easy",
    tools: ["Screwdriver (for M.2 SSD)"],
    content: `RAM Installation:
- Find the RAM slots on the motherboard.
- Open the locking clips.
- Align the notch, then press down firmly until it clicks.

M.2 SSD Installation:
- Locate the M.2 slot.
- Insert the SSD at a slight angle.
- Push it down and secure it with a screw.

SSDs installed in M.2 slots boot faster and look cleaner.`,
    tips: [
      "Check motherboard manual for correct slot configuration",
      "Press down firmly until clips snap into place",
      "For dual-channel, use slots 2 and 4 first (usually color-coded)",
    ],
    warnings: [
      "Ensure RAM is fully seated - you should hear a click",
      "Match RAM speed with motherboard specifications",
      "Don't forget the M.2 SSD screw",
    ],
    image: "/4th.png",
    completed: false,
  },
  {
    id: 5,
    title: "Mount the Motherboard in the Case",
    description: "Install the motherboard into the PC case with proper alignment",
    duration: "15 minutes",
    difficulty: "Medium",
    tools: ["Screwdriver", "Motherboard standoffs"],
    content: `1. Open the case and lay it on its side.
2. Install motherboard standoffs (small metal spacers) if they aren't preinstalled.
3. Carefully align the motherboard with the I/O shield and standoffs.
4. Secure it using the screws provided.

Do not overtighten screws—just snug and secure.`,
    tips: [
      "Only install standoffs where motherboard mounting holes are located",
      "Hand-tighten standoffs - don't over-tighten",
      "Test fit motherboard before final installation",
    ],
    warnings: [
      "Extra standoffs can cause short circuits - only use what's needed",
      "Ensure standoffs are properly threaded into case",
      "Don't overtighten - just snug",
    ],
    image: "/5th.png",
    completed: false,
  },
  {
    id: 6,
    title: "Install Case Fans",
    description: "Mount case fans with proper airflow direction",
    duration: "10 minutes",
    difficulty: "Easy",
    tools: ["Screwdriver", "Case fan screws"],
    content: `1. Decide airflow direction: front fans pull air in, rear/top fans push air out.
2. Mount the fans using screws.
3. Connect them to FAN headers on the motherboard or to a fan hub.

Good airflow = Cooler PC, longer lifespan.`,
    tips: [
      "Front and bottom fans should pull air IN",
      "Rear and top fans should push air OUT",
      "Check fan direction arrows before mounting",
    ],
    warnings: [
      "Wrong airflow direction reduces cooling efficiency",
      "Make sure fans are properly secured",
      "Don't forget to connect fan cables",
    ],
    image: "/6th.png",
    completed: false,
  },
  {
    id: 7,
    title: "Install the Power Supply",
    description: "Mount the PSU in the case with proper cable routing",
    duration: "10 minutes",
    difficulty: "Easy",
    tools: ["Screwdriver", "PSU mounting screws"],
    content: `1. Slide the PSU into the bottom/back of the case.
2. Ensure the fan faces outward or downward (depending on case design).
3. Secure with screws.
4. Route the cables through the back side of the case.

Keep your cable management clean, future you will thank you.`,
    tips: [
      "Install PSU with fan facing down if case has bottom ventilation",
      "Ensure the power switch is accessible",
      "Route cables behind the motherboard tray",
    ],
    warnings: [
      "Make sure PSU is switched OFF before installation",
      "Check PSU orientation - fan should face ventilation",
      "Don't block PSU fan with cables",
    ],
    image: "/7th.png",
    completed: false,
  },
  {
    id: 8,
    title: "Install the Graphics Card (GPU)",
    description: "Install the graphics card into the PCIe slot",
    duration: "10 minutes",
    difficulty: "Easy",
    tools: ["Screwdriver"],
    content: `1. Remove the metal PCIe slot covers on the back of the case.
2. Insert the GPU into the PCIe x16 slot on the motherboard.
3. Push until it clicks, then screw it in securely.
4. Connect PCIe power cables from the PSU, if required.

GPUs are hungry, make sure you plug in all power connectors.`,
    tips: [
      "GPU should click into place - don't force it",
      "Make sure all PCIe power connectors are plugged in",
      "Remove slot covers before installing GPU",
    ],
    warnings: [
      "GPUs need additional power - don't forget PCIe cables",
      "Ensure GPU is fully seated in the slot",
      "Some GPUs are heavy - support them if needed",
    ],
    image: "/8th.png",
    completed: false,
  },
  {
    id: 9,
    title: "Connect All Cables to the Motherboard",
    description: "Connect all power and data cables properly",
    duration: "15 minutes",
    difficulty: "Medium",
    tools: ["Motherboard manual"],
    content: `Essential connections include:

✔️ 24-Pin ATX Power (Motherboard main power)
✔️ 8-Pin or 4-Pin CPU Power (Near CPU socket)
✔️ PCIe Power for GPU
✔️ SATA Power/Data for SSD/HDD (if not M.2)
✔️ Front Panel Connectors: Power button, reset button, USB ports, audio
✔️ Case Fans

Refer to the motherboard manual for front panel pin layout. It's small but important.`,
    tips: [
      "Keep motherboard manual nearby for pin layouts",
      "Front panel connectors are small - be patient",
      "Route cables neatly behind the motherboard tray",
    ],
    warnings: [
      "Wrong front panel connections = PC won't turn on",
      "Make sure all power connectors are fully seated",
      "Check that no cables are pinched or damaged",
    ],
    image: "/9th.png",
    completed: false,
  },
  {
    id: 10,
    title: "Close the Case and Secure It",
    description: "Final step - close up the case and prepare for first boot",
    duration: "5 minutes",
    difficulty: "Easy",
    tools: ["Screwdriver or thumbscrews"],
    content: `1. Tuck excess cables behind the motherboard tray.
2. Reinstall the side panels.
3. Secure them using screws or thumbscrews.

Boom. You now have a clean, assembled PC.

First Power-On Checklist:
Before pressing that power button, do a quick check:

✔️ All power cables connected?
✔️ Fans spinning freely?
✔️ GPU and RAM fully seated?
✔️ No loose screws or cables?

Turn it on. If it boots to BIOS, you're golden.

Final Tips for Beginners:
- Never force parts — everything should click naturally.
- Keep your motherboard manual nearby.
- If it doesn't turn on, check power cables first (80% of the time, that's the issue).
- Patience beats panic.`,
    tips: [
      "Cable management makes future upgrades easier",
      "Leave some slack in cables for future changes",
      "Test boot before closing the case completely",
    ],
    warnings: [
      "Don't force side panels - they should slide easily",
      "Make sure no cables are pinched when closing",
      "Test the build before fully securing panels",
    ],
    image: "/10th.png",
    completed: false,
  },
]

export default function GuideDetailPage() {
  const params = useParams()
  const router = useRouter()
  const [currentStep, setCurrentStep] = useState(1)
  const [completedSteps, setCompletedSteps] = useState<number[]>([])
  const [isPlaying, setIsPlaying] = useState(false)
  const [isMounted, setIsMounted] = useState(false)

  useEffect(() => {
    setIsMounted(true)
  }, [])

  // Guide data - check if it's the PC assembly guide
  const isPcAssemblyGuide = params.id === "beginner-gaming-build" || params.id === "pc-assembly-guide"
  
  const guide = isPcAssemblyGuide ? {
    id: params.id,
    title: "Complete PC Assembly Guide",
    description: "Step-by-step guide for building your PC from scratch with detailed visuals and instructions",
    difficulty: "Beginner",
    duration: "2-3 hours",
    views: "45.2k",
    category: "Gaming",
    estimatedCost: "₱44,000-66,000",
    totalSteps: guideSteps.length,
    tools: [
      "Screwdriver (magnetic tip recommended)",
      "Anti-static wrist strap (optional)",
      "Thermal paste",
      "Clean workspace",
      "Motherboard manual"
    ],
    lastUpdated: "Just now",
  } : {
    id: params.id,
    title: "Your First Gaming PC Build",
    description: "Complete step-by-step guide for building your first gaming PC from scratch",
    difficulty: "Beginner",
    duration: "2-3 hours",
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
                </div>
              </CardHeader>
            </Card>

            {/* Build Guide Animation */}
            {isPcAssemblyGuide && (
              <Card>
                <CardHeader>
                  <CardTitle className="text-xl mb-2 font-semibold">Build Guide Animation</CardTitle>
                  <CardDescription className="text-slate-600 dark:text-slate-400">Watch the complete PC assembly process step-by-step</CardDescription>
                </CardHeader>
                <CardContent>
                  {/* Build Guide GIF */}
                  <div className="w-full aspect-video rounded-lg overflow-hidden border border-slate-200 dark:border-slate-700 bg-slate-900 flex items-center justify-center">
                    <img
                      src="/build-guide.gif"
                      alt="PC Build Guide Animation"
                      className="w-full h-full object-contain"
                      loading="eager"
                    />
                  </div>
                  <p className="text-xs text-slate-500 dark:text-slate-400 mt-2 text-center">
                    Complete step-by-step PC assembly guide
                  </p>
                </CardContent>
              </Card>
            )}

            {/* Current Step */}
            {currentStepData && (
              <Card>
                <CardHeader>
                  <div className="flex items-center justify-between">
                    <div>
                      <CardTitle className="text-2xl font-bold tracking-tight">
                        Step {currentStep}: {currentStepData.title}
                      </CardTitle>
                      <CardDescription className="mt-2 text-base font-normal">{currentStepData.description}</CardDescription>
                    </div>
                    <div className="flex items-center gap-2">
                      <Badge variant={currentStepData.difficulty === "Easy" ? "secondary" : "default"}>
                        {currentStepData.difficulty}
                      </Badge>
                    </div>
                  </div>
                </CardHeader>

                <CardContent className="space-y-6">
                  {/* Step Content */}
                  {currentStepData.content && (
                    <div className="prose prose-slate dark:prose-invert max-w-none">
                      <div className="whitespace-pre-line text-slate-700 dark:text-slate-300 leading-relaxed text-base font-normal tracking-normal">
                        <div className="space-y-3 [&>ul]:space-y-2 [&>ul]:ml-6 [&>ul]:list-disc [&>ol]:space-y-2 [&>ol]:ml-6 [&>ol]:list-decimal">
                          {currentStepData.content}
                        </div>
                      </div>
                    </div>
                  )}

                  {/* Step Image */}
                  {currentStepData.image && (
                    <div className="w-full rounded-lg overflow-hidden border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 p-4">
                      <img
                        src={currentStepData.image}
                        alt={`Step ${currentStep} illustration`}
                        className="w-full h-auto object-contain max-w-full"
                        loading={currentStep <= 2 ? "eager" : "lazy"}
                      />
                    </div>
                  )}

                  {/* Tools Required */}
                  {currentStepData.tools.length > 0 && (
                    <div>
                      <h4 className="font-semibold text-lg mb-3 flex items-center gap-2 text-slate-900 dark:text-slate-100">
                        <Wrench className="h-5 w-5" />
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
                      <h4 className="font-semibold text-lg mb-3 flex items-center gap-2 text-slate-900 dark:text-slate-100">
                        <Lightbulb className="h-5 w-5 text-yellow-500" />
                        Pro Tips
                      </h4>
                      <div className="space-y-2.5">
                        {currentStepData.tips.map((tip, index) => (
                          <div key={index} className="flex items-start gap-2.5">
                            <Info className="h-4 w-4 text-blue-500 mt-0.5 flex-shrink-0" />
                            <p className="text-base text-slate-700 dark:text-slate-300 leading-relaxed">{tip}</p>
                          </div>
                        ))}
                      </div>
                    </div>
                  )}

                  {/* Warnings */}
                  {currentStepData.warnings.length > 0 && (
                    <div>
                      <h4 className="font-semibold text-lg mb-3 flex items-center gap-2 text-slate-900 dark:text-slate-100">
                        <AlertTriangle className="h-5 w-5 text-red-500" />
                        Important Warnings
                      </h4>
                      <div className="space-y-2.5">
                        {currentStepData.warnings.map((warning, index) => (
                          <div
                            key={index}
                            className="flex items-start gap-2.5 p-3.5 bg-red-50 dark:bg-red-900/20 rounded-lg"
                          >
                            <AlertTriangle className="h-4 w-4 text-red-500 mt-0.5 flex-shrink-0" />
                            <p className="text-base text-red-700 dark:text-red-300 leading-relaxed font-medium">{warning}</p>
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
