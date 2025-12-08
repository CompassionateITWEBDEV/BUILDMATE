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
    image: "/1. Prepare the Case.gif",
    completed: false,
  },
  {
    id: 2,
    title: "Prepare the PC Case",
    description: "Open the case and install necessary standoffs",
    duration: "10 minutes",
    difficulty: "Easy",
    tools: ["Screwdriver", "Motherboard standoffs"],
    content: `1. Remove both side panels from the case
2. Lay the case on its side for easy access
3. Locate the motherboard mounting area
4. Install motherboard standoffs in the correct positions
   - Match the standoff positions with your motherboard size (ATX, Micro-ATX, etc.)
   - Hand-tighten the standoffs - don't use excessive force
5. Remove any unnecessary drive cages to improve airflow
6. Check that the I/O shield is ready (comes with motherboard)`,
    tips: [
      "Only install standoffs where your motherboard has mounting holes",
      "Extra standoffs can cause electrical shorts",
      "Keep all screws organized in a small container",
    ],
    warnings: [
      "Never skip standoffs - they prevent motherboard shorts",
      "Don't force standoffs - they should screw in smoothly",
      "Remove protective film from case windows if present",
    ],
    image: "/1. Prepare the Case.gif",
    completed: false,
  },
  {
    id: 3,
    title: "Install I/O Shield and Prepare Motherboard",
    description: "Install the I/O shield and prepare motherboard for installation",
    duration: "5 minutes",
    difficulty: "Easy",
    tools: ["None (hands only)"],
    content: `1. Take the I/O shield from your motherboard box
2. From inside the case, push the I/O shield into the rectangular opening at the back
3. Make sure it snaps firmly into place on all four sides
4. Press all edges until you hear clicks
5. Check that no metal tabs are bent inward (they can block ports)
6. Place the motherboard nearby for the next step`,
    tips: [
      "The I/O shield only fits one way - don't force it",
      "Some I/O shields have foam padding - keep it in place",
      "Ensure all port cutouts align properly",
    ],
    warnings: [
      "Sharp edges on I/O shield - handle carefully",
      "Make sure it's fully seated before proceeding",
      "Metal tabs should point away from where ports will be",
    ],
    image: "/2. Install the Motherboard.gif",
    completed: false,
  },
  {
    id: 4,
    title: "Install CPU on Motherboard",
    description: "Install the CPU onto the motherboard socket",
    duration: "10 minutes",
    difficulty: "Medium",
    tools: ["None (very gentle hands)"],
    content: `1. Place motherboard on its box (anti-static surface)
2. Locate the CPU socket (large square with lots of pins/contacts)
3. Lift the retention arm/lever
4. For Intel: Lift the metal bracket
   For AMD: Just lift the lever
5. Align the CPU with the socket:
   - Look for the golden triangle on CPU corner
   - Match it with the triangle on the socket
6. Gently place the CPU - it should drop in with NO FORCE
7. Lower the retention arm back down`,
    tips: [
      "Never touch the bottom of the CPU (the pins/contacts)",
      "The CPU should sit perfectly flat",
      "If it doesn't drop in easily, you have the wrong orientation",
    ],
    warnings: [
      "DO NOT FORCE THE CPU - it should seat naturally",
      "Never touch the socket pins",
      "Static electricity can damage the CPU - ground yourself first",
    ],
    image: "/3. Install the CPU.gif",
    completed: false,
  },
  {
    id: 5,
    title: "Apply Thermal Paste and Install CPU Cooler",
    description: "Apply thermal paste and mount the CPU cooler",
    duration: "15 minutes",
    difficulty: "Medium",
    tools: ["Thermal paste (if not pre-applied)", "Screwdriver"],
    content: `1. Check if your cooler has pre-applied thermal paste
   - If YES: Skip to step 3
   - If NO: Continue to step 2
2. Apply thermal paste to CPU:
   - Put a small pea-sized dot in the center of the CPU
   - Don't spread it - the cooler will do that
3. Remove any protective stickers from cooler base
4. Align the cooler with the mounting brackets
5. For Intel: Push down plastic push-pins in X pattern
   For AMD: Screw down in X pattern
6. Connect the CPU fan cable to CPU_FAN header on motherboard
   - Look for "CPU_FAN" label near the CPU socket`,
    tips: [
      "Less is more with thermal paste - pea-sized is enough",
      "Tighten screws in X pattern (diagonal) for even pressure",
      "The cooler should be firm but you shouldn't need excessive force",
    ],
    warnings: [
      "Too much thermal paste can cause overheating",
      "Make sure the cooler is firmly attached",
      "Don't forget to plug in the CPU fan cable!",
    ],
    image: "/4. Apply Thermal Paste.gif",
    completed: false,
  },
  {
    id: 6,
    title: "Install RAM Memory",
    description: "Install RAM sticks into motherboard slots",
    duration: "5 minutes",
    difficulty: "Easy",
    tools: ["None"],
    content: `1. Locate the RAM slots (usually 2 or 4 slots near the CPU)
2. Open the locking clips on both ends of the slot
3. Check your motherboard manual for correct slot configuration
   - For 2 sticks: Usually use slots 2 and 4 (skip slot 1 and 3)
   - This enables dual-channel mode for better performance
4. Align the notch on the RAM stick with the notch in the slot
5. Press down firmly on both ends until the clips snap back up
6. You should hear a distinct "click" when properly seated`,
    tips: [
      "Match the notch - RAM only goes in one way",
      "Press straight down with even pressure on both ends",
      "The clips should automatically lock when fully seated",
    ],
    warnings: [
      "Don't force at an angle - press straight down",
      "Ensure RAM is fully seated - check both ends",
      "Verify RAM speed matches your motherboard's capability",
    ],
    image: "/5. Install the RAM.gif",
    completed: false,
  },
  {
    id: 7,
    title: "Install M.2 SSD Storage",
    description: "Install M.2 NVMe SSD for fast storage",
    duration: "5 minutes",
    difficulty: "Easy",
    tools: ["Small screwdriver"],
    content: `1. Locate the M.2 slot on your motherboard
   - Usually below the CPU or between CPU and GPU area
   - Check motherboard manual if unsure
2. Remove the M.2 screw and standoff if present
3. Carefully insert the M.2 SSD at a 30-degree angle
4. The gold contacts should fully insert into the slot
5. Press down gently on the other end
6. Secure with the M.2 screw
7. Don't overtighten - just snug`,
    tips: [
      "Some motherboards have heatsinks for M.2 - use them if available",
      "The SSD should sit flat when screwed down",
      "Check which M.2 slot supports NVMe (faster than SATA)",
    ],
    warnings: [
      "Don't force the SSD - it should slide in smoothly",
      "The screw is tiny - don't lose it!",
      "Ensure the SSD is NVMe for best performance",
    ],
    image: "/6. Install the SSD.gif",
    completed: false,
  },
  {
    id: 8,
    title: "Mount Motherboard into Case",
    description: "Install the prepared motherboard into the PC case",
    duration: "15 minutes",
    difficulty: "Medium",
    tools: ["Screwdriver", "Motherboard screws"],
    content: `1. Verify all standoffs are in correct positions
2. Carefully lower the motherboard into the case
3. Align the back ports with the I/O shield cutouts
4. Push gently to ensure I/O shield is properly seated
5. Align motherboard holes with standoffs
6. Insert screws and hand-tighten first (don't fully tighten yet)
7. Once all screws are in, tighten in a star/diagonal pattern
8. Don't overtighten - just snug and secure`,
    tips: [
      "It may take a few attempts to align everything",
      "The motherboard should sit flat against standoffs",
      "All mounting holes should have screws",
    ],
    warnings: [
      "Don't force the motherboard - adjust I/O shield if needed",
      "Missing standoffs can cause motherboard to flex",
      "Overtightening can crack the motherboard",
    ],
    image: "/7. Install the GPU.gif",
    completed: false,
  },
  {
    id: 9,
    title: "Install Power Supply (PSU)",
    description: "Mount the PSU and route main cables",
    duration: "15 minutes",
    difficulty: "Medium",
    tools: ["Screwdriver", "PSU screws"],
    content: `1. Identify PSU mounting location (usually bottom or top rear)
2. Determine fan orientation:
   - If PSU at bottom with vent: Fan facing DOWN (intake from outside)
   - If PSU at top: Fan facing UP (intake from inside case)
3. Slide PSU into position
4. Align screw holes
5. Secure with 4 screws from outside the case
6. Route the main cables through cable management holes:
   - 24-pin ATX power (largest cable)
   - 8-pin CPU power (4+4 cable)
7. Leave cables loose for now - we'll connect them later`,
    tips: [
      "Fan should intake cool air from outside case when possible",
      "Route cables behind motherboard tray for clean look",
      "Don't plug in PSU yet - wait until everything is installed",
    ],
    warnings: [
      "Make sure PSU switch is set to OFF",
      "Don't plug into wall outlet yet",
      "Check that voltage switch matches your country (110V or 220V)",
    ],
    image: "/9. Install the PSU.gif",
    completed: false,
  },
  {
    id: 10,
    title: "Install Graphics Card (GPU)",
    description: "Install the GPU into PCIe slot",
    duration: "10 minutes",
    difficulty: "Medium",
    tools: ["Screwdriver"],
    content: `1. Locate the PCIe x16 slot (top/long slot, usually closest to CPU)
2. Remove the corresponding slot covers from the back of the case
   - Usually 2 or 3 slots depending on GPU size
3. Press down the PCIe slot locking clip
4. Align the GPU with the slot
5. Press down firmly until you hear a click
   - The locking clip should snap back up
6. Secure the GPU bracket to the case with screws
7. Don't connect power cables yet - next step`,
    tips: [
      "Remove GPU from anti-static bag just before installation",
      "The GPU should be level and fully seated",
      "Large GPUs may sag - consider a support bracket",
    ],
    warnings: [
      "Don't force the GPU - it should slide in smoothly",
      "Ensure the locking clip fully engages",
      "Check GPU power requirements (6-pin, 8-pin, or both)",
    ],
    image: "/10. Connect All Cables.gif",
    completed: false,
  },
  {
    id: 11,
    title: "Connect All Power Cables and Front Panel Connectors",
    description: "Connect power cables and front panel connectors",
    duration: "20 minutes",
    difficulty: "Medium",
    tools: ["Motherboard manual", "Patience!"],
    content: `POWER CABLES:
1. Connect 24-pin ATX power to motherboard (largest connector)
2. Connect 8-pin CPU power (near top of motherboard, labeled "CPU_PWR")
3. Connect GPU power cables (6-pin and/or 8-pin as required)
4. Connect SATA power to any SATA drives if you have them

CASE CABLES (Front Panel Connectors):
Check motherboard manual for exact location (usually bottom-right)

5. Connect USB 3.0 header (blue connector from case to "USB 3.0" on motherboard)
6. Connect USB 2.0 header (from case to "USB" on motherboard)
7. Connect HD Audio header (from case to "AUDIO" on motherboard)
8. Connect front panel connectors (small cables):
   - PWR_SW (Power Switch) - most important!
   - RESET_SW (Reset Switch)
   - PWR_LED+ and PWR_LED- (Power LED)
   - HDD_LED+ and HDD_LED- (Activity LED)

FANS:
9. Connect case fans to CHA_FAN or SYS_FAN headers

FINAL CHECK:
✔️ All power cables connected
✔️ All fans connected
✔️ RAM fully seated
✔️ GPU fully seated and secured
✔️ No loose screws inside case

Close the case panels, connect monitor to GPU (NOT motherboard!), plug in PSU, turn on PSU switch, and press power button!

If it boots to BIOS: SUCCESS! 🎉
If not: Check power cables first (most common issue)`,
    tips: [
      "Take a photo of motherboard manual's connector diagram",
      "Power cables only fit one way - don't force",
      "Front panel connectors are tiny - use tweezers if needed",
      "+/- polarity matters for LEDs (but won't damage if wrong)",
    ],
    warnings: [
      "Double-check CPU power cable (8-pin) is NOT a PCIe cable",
      "Make sure all power connectors click into place",
      "Don't bend pins on front panel connectors",
      "PWR_SW must be connected or PC won't turn on",
    ],
    image: "/11. Reattach All Panels.gif",
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

  // Load saved progress from localStorage
  useEffect(() => {
    if (typeof window !== 'undefined' && params.id) {
      const savedProgress = localStorage.getItem(`guide-progress-${params.id}`)
      if (savedProgress) {
        try {
          const parsed = JSON.parse(savedProgress)
          setCompletedSteps(parsed)
        } catch (error) {
          console.error('Error loading saved progress:', error)
        }
      }
    }
  }, [params.id])

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
    setCompletedSteps((prev) => {
      const newCompleted = prev.includes(stepId) 
        ? prev.filter((id) => id !== stepId) 
        : [...prev, stepId]
      
      // Save to localStorage
      if (typeof window !== 'undefined' && params.id) {
        localStorage.setItem(`guide-progress-${params.id}`, JSON.stringify(newCompleted))
      }
      
      return newCompleted
    })
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
    if (confirm('Are you sure you want to reset your progress? This cannot be undone.')) {
      setCompletedSteps([])
      setCurrentStep(1)
      if (typeof window !== 'undefined' && params.id) {
        localStorage.removeItem(`guide-progress-${params.id}`)
      }
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
                        <div className="flex items-center gap-2">
                          <span className="font-medium">
                            {completedSteps.length}/{guide.totalSteps} steps completed
                          </span>
                          {completedSteps.length > 0 && (
                            <Button
                              variant="ghost"
                              size="sm"
                              onClick={resetProgress}
                              className="h-6 px-2 text-xs text-slate-500 hover:text-red-600"
                            >
                              Reset
                            </Button>
                          )}
                        </div>
                      </div>
                      <Progress value={progress} className="h-2" />
                    </div>
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

                  {/* Step Images - GIF Animation + Static Diagram */}
                  {currentStepData.image && (
                    <div className="space-y-4">
                      {/* Animated GIF */}
                      <div className="w-full rounded-lg overflow-hidden border border-slate-200 dark:border-slate-700 bg-slate-50 dark:bg-slate-800 p-4">
                        <img
                          src={currentStepData.image}
                          alt={`Step ${currentStep} animation`}
                          className="w-full h-auto object-contain max-w-full"
                          loading={currentStep <= 2 ? "eager" : "lazy"}
                        />
                        <p className="text-xs text-center text-slate-500 dark:text-slate-400 mt-2">
                          Animated guide - {currentStepData.title}
                        </p>
                      </div>
                      
                      {/* Static Patent-Style Diagram */}
                      {currentStep === 1 && (
                        <div className="w-full rounded-lg overflow-hidden border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 p-4">
                          <img
                            src="/1st.png"
                            alt="Step 1 diagram"
                            className="w-full h-auto object-contain max-w-full"
                            loading="eager"
                          />
                          <p className="text-xs text-center text-slate-500 dark:text-slate-400 mt-2">
                            Technical diagram
                          </p>
                        </div>
                      )}
                      {currentStep === 2 && (
                        <div className="w-full rounded-lg overflow-hidden border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 p-4">
                          <img
                            src="/2nd.png"
                            alt="Step 2 diagram"
                            className="w-full h-auto object-contain max-w-full"
                          />
                          <p className="text-xs text-center text-slate-500 dark:text-slate-400 mt-2">
                            Technical diagram
                          </p>
                        </div>
                      )}
                      {currentStep === 3 && (
                        <div className="w-full rounded-lg overflow-hidden border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 p-4">
                          <img
                            src="/3rd.png"
                            alt="Step 3 diagram"
                            className="w-full h-auto object-contain max-w-full"
                          />
                          <p className="text-xs text-center text-slate-500 dark:text-slate-400 mt-2">
                            Technical diagram
                          </p>
                        </div>
                      )}
                      {currentStep === 4 && (
                        <div className="w-full rounded-lg overflow-hidden border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 p-4">
                          <img
                            src="/4th.png"
                            alt="Step 4 diagram"
                            className="w-full h-auto object-contain max-w-full"
                          />
                          <p className="text-xs text-center text-slate-500 dark:text-slate-400 mt-2">
                            Technical diagram
                          </p>
                        </div>
                      )}
                      {currentStep === 5 && (
                        <div className="w-full rounded-lg overflow-hidden border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 p-4">
                          <img
                            src="/5th.png"
                            alt="Step 5 diagram"
                            className="w-full h-auto object-contain max-w-full"
                          />
                          <p className="text-xs text-center text-slate-500 dark:text-slate-400 mt-2">
                            Technical diagram
                          </p>
                        </div>
                      )}
                      {currentStep === 6 && (
                        <div className="w-full rounded-lg overflow-hidden border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 p-4">
                          <img
                            src="/6th.png"
                            alt="Step 6 diagram"
                            className="w-full h-auto object-contain max-w-full"
                          />
                          <p className="text-xs text-center text-slate-500 dark:text-slate-400 mt-2">
                            Technical diagram
                          </p>
                        </div>
                      )}
                      {currentStep === 7 && (
                        <div className="w-full rounded-lg overflow-hidden border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 p-4">
                          <img
                            src="/7th.png"
                            alt="Step 7 diagram"
                            className="w-full h-auto object-contain max-w-full"
                          />
                          <p className="text-xs text-center text-slate-500 dark:text-slate-400 mt-2">
                            Technical diagram
                          </p>
                        </div>
                      )}
                      {currentStep === 8 && (
                        <div className="w-full rounded-lg overflow-hidden border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 p-4">
                          <img
                            src="/8th.png"
                            alt="Step 8 diagram"
                            className="w-full h-auto object-contain max-w-full"
                          />
                          <p className="text-xs text-center text-slate-500 dark:text-slate-400 mt-2">
                            Technical diagram
                          </p>
                        </div>
                      )}
                      {currentStep === 9 && (
                        <div className="w-full rounded-lg overflow-hidden border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 p-4">
                          <img
                            src="/9th.png"
                            alt="Step 9 diagram"
                            className="w-full h-auto object-contain max-w-full"
                          />
                          <p className="text-xs text-center text-slate-500 dark:text-slate-400 mt-2">
                            Technical diagram
                          </p>
                        </div>
                      )}
                      {currentStep === 10 && (
                        <div className="w-full rounded-lg overflow-hidden border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 p-4">
                          <img
                            src="/10th.png"
                            alt="Step 10 diagram"
                            className="w-full h-auto object-contain max-w-full"
                          />
                          <p className="text-xs text-center text-slate-500 dark:text-slate-400 mt-2">
                            Technical diagram
                          </p>
                        </div>
                      )}
                      {currentStep === 11 && (
                        <div className="w-full rounded-lg overflow-hidden border border-slate-200 dark:border-slate-700 bg-white dark:bg-slate-800 p-4">
                          <img
                            src="/1st.png"
                            alt="Step 11 diagram"
                            className="w-full h-auto object-contain max-w-full"
                          />
                          <p className="text-xs text-center text-slate-500 dark:text-slate-400 mt-2">
                            Technical diagram (placeholder)
                          </p>
                        </div>
                      )}
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
