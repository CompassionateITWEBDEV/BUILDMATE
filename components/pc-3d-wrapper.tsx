"use client"

import { useEffect, useState } from "react"

interface PC3DWrapperProps {
  currentStep: number
  className?: string
}

export function PC3DWrapper({ currentStep, className = "" }: PC3DWrapperProps) {
  const [Component, setComponent] = useState<React.ComponentType<{ currentStep: number; className?: string }> | null>(null)
  const [error, setError] = useState<string | null>(null)
  const [mounted, setMounted] = useState(false)

  useEffect(() => {
    setMounted(true)
  }, [])

  useEffect(() => {
    // Only load on client side after mount with a delay to ensure React is ready
    if (mounted && typeof window !== 'undefined') {
      // Wait for next tick to ensure React is fully initialized
      const timer = setTimeout(() => {
        // Use dynamic import with explicit chunk name to isolate
        import(/* webpackChunkName: "pc-3d-animation" */ "@/components/pc-3d-animation")
          .then((mod) => {
            setComponent(() => mod.PC3DAnimation)
          })
          .catch((err) => {
            console.error("Failed to load 3D animation:", err)
            setError("Failed to load 3D animation. Please refresh the page.")
          })
      }, 200)
      
      return () => clearTimeout(timer)
    }
  }, [mounted])

  if (!mounted) {
    return (
      <div className={`w-full aspect-video rounded-lg border border-slate-200 dark:border-slate-700 bg-gradient-to-br from-slate-900 to-slate-800 flex items-center justify-center ${className}`}>
        <p className="text-slate-400">Initializing...</p>
      </div>
    )
  }

  if (error) {
    return (
      <div className={`w-full aspect-video rounded-lg border border-slate-200 dark:border-slate-700 bg-gradient-to-br from-slate-900 to-slate-800 flex items-center justify-center ${className}`}>
        <div className="text-center">
          <p className="text-slate-400 mb-2">3D animation unavailable</p>
          <p className="text-xs text-slate-500">{error}</p>
        </div>
      </div>
    )
  }

  if (!Component) {
    return (
      <div className={`w-full aspect-video rounded-lg border border-slate-200 dark:border-slate-700 bg-gradient-to-br from-slate-900 to-slate-800 flex items-center justify-center ${className}`}>
        <p className="text-slate-400">Loading 3D animation...</p>
      </div>
    )
  }

  return <Component currentStep={currentStep} className={className} />
}

