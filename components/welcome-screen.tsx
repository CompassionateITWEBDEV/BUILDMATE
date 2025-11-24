"use client"

import { useState, useEffect } from "react"
import { Cpu, Sparkles } from "lucide-react"
import { Button } from "@/components/ui/button"
import Link from "next/link"

interface WelcomeScreenProps {
  onComplete: () => void
}

export function WelcomeScreen({ onComplete }: WelcomeScreenProps) {
  const [currentStep, setCurrentStep] = useState(0)
  const [isVisible, setIsVisible] = useState(true)

  const steps = [
    {
      title: "Welcome to BuildMate",
      description: "Your ultimate PC building companion",
      icon: Cpu,
      delay: 0,
    },
    {
      title: "Smart Compatibility Checking",
      description: "Advanced algorithms ensure your components work perfectly together",
      icon: Sparkles,
      delay: 2000,
    },
    {
      title: "Expert Recommendations",
      description: "Get personalized suggestions based on your needs and budget",
      icon: Sparkles,
      delay: 4000,
    },
  ]

  useEffect(() => {
    if (currentStep >= steps.length - 1) {
      // On last step, wait 2 seconds then fade out
      const fadeTimer = setTimeout(() => {
        setIsVisible(false)
        setTimeout(() => {
          onComplete()
        }, 500)
      }, 2000)
      return () => clearTimeout(fadeTimer)
    } else {
      // Auto-advance to next step after 2 seconds
      const timer = setTimeout(() => {
        setCurrentStep(currentStep + 1)
      }, 2000)
      return () => clearTimeout(timer)
    }
  }, [currentStep, onComplete, steps.length])

  if (!isVisible) return null

  const currentStepData = steps[currentStep]
  const Icon = currentStepData?.icon || Cpu

  return (
    <div className="fixed inset-0 z-[10000] bg-gradient-to-br from-slate-900 via-blue-900 to-slate-800 flex items-center justify-center animate-fade-in">
      <div className="text-center px-4">
        <div className="mb-8 animate-fade-in-up">
          <div className="inline-flex items-center justify-center gap-4 mb-6">
            <Icon className="h-16 w-16 text-blue-400 animate-pulse" />
            <Cpu className="h-20 w-20 text-blue-500" />
          </div>
        </div>
        
        <div className="space-y-4 animate-fade-in-up animation-delay-200">
          <h1 className="text-5xl md:text-6xl font-bold text-white mb-4">
            {currentStepData?.title || "Welcome to BuildMate"}
          </h1>
          <p className="text-xl md:text-2xl text-blue-200 max-w-2xl mx-auto">
            {currentStepData?.description || "Your ultimate PC building companion"}
          </p>
        </div>

        <div className="mt-12 flex justify-center gap-2 animate-fade-in-up animation-delay-400">
          {steps.map((_, index) => (
            <div
              key={index}
              className={`h-2 w-2 rounded-full transition-all duration-500 ${
                index === currentStep
                  ? "bg-blue-400 w-8"
                  : "bg-blue-600/50"
              }`}
            />
          ))}
        </div>

        <div className="mt-8 animate-fade-in-up animation-delay-600">
          <Button
            onClick={() => {
              setIsVisible(false)
              setTimeout(() => onComplete(), 500)
            }}
            size="lg"
            className="bg-blue-600 hover:bg-blue-700 text-white"
          >
            Get Started
          </Button>
        </div>
      </div>
    </div>
  )
}

