"use client"

import { useEffect, useState } from "react"
import { Cpu, Loader2 } from "lucide-react"
import { useLoading } from "@/contexts/loading-context"

export function GlobalLoading() {
  const { isLoading, loadingMessage } = useLoading()
  const [progress, setProgress] = useState(0)
  const [showFullScreen, setShowFullScreen] = useState(false)

  // Progress bar animation
  useEffect(() => {
    if (isLoading) {
      setProgress(0)
      
      // Fast progress to 60%
      const interval1 = setInterval(() => {
        setProgress(prev => {
          if (prev >= 60) {
            clearInterval(interval1)
            return prev
          }
          return prev + Math.random() * 10
        })
      }, 100)

      // Slow progress to 90%
      const interval2 = setInterval(() => {
        setProgress(prev => {
          if (prev >= 90) {
            clearInterval(interval2)
            return prev
          }
          return prev + Math.random() * 2
        })
      }, 500)

      // Show full screen loader after 800ms (if still loading)
      const timeout = setTimeout(() => {
        setShowFullScreen(true)
      }, 800)

      return () => {
        clearInterval(interval1)
        clearInterval(interval2)
        clearTimeout(timeout)
      }
    } else {
      // Complete progress on finish
      setProgress(100)
      setTimeout(() => {
        setProgress(0)
        setShowFullScreen(false)
      }, 300)
    }
  }, [isLoading])

  if (!isLoading && progress === 0) return null

  return (
    <>
      {/* Top Progress Bar (Always visible during loading) */}
      <div className="fixed top-0 left-0 right-0 z-[9999] h-1 bg-transparent">
        <div
          className="h-full bg-gradient-to-r from-blue-500 via-blue-600 to-blue-700 transition-all duration-300 ease-out shadow-lg shadow-blue-500/50"
          style={{ 
            width: `${progress}%`,
            opacity: isLoading || progress === 100 ? 1 : 0
          }}
        />
      </div>

      {/* Full Screen Overlay (Shows after 800ms) */}
      {showFullScreen && (
        <div 
          className={`fixed inset-0 z-[9998] bg-white/80 dark:bg-slate-900/80 backdrop-blur-md flex items-center justify-center transition-opacity duration-300 ${
            isLoading ? 'opacity-100' : 'opacity-0'
          }`}
        >
          <div className="text-center max-w-md mx-auto px-4">
            {/* Animated Logo */}
            <div className="relative mb-6">
              <div className="absolute inset-0 animate-ping">
                <Cpu className="h-16 w-16 text-blue-600 dark:text-blue-400 mx-auto opacity-20" />
              </div>
              <Cpu className="h-16 w-16 text-blue-600 dark:text-blue-400 mx-auto relative animate-pulse" />
            </div>

            {/* Loading Message */}
            <div className="space-y-3">
              <div className="flex items-center justify-center gap-2">
                <Loader2 className="h-5 w-5 animate-spin text-blue-600 dark:text-blue-400" />
                <p className="text-lg font-semibold text-slate-900 dark:text-slate-100">
                  {loadingMessage || "Loading..."}
                </p>
              </div>

              {/* Progress Percentage */}
              <p className="text-sm text-slate-600 dark:text-slate-400">
                {Math.round(progress)}%
              </p>

              {/* Progress Bar */}
              <div className="w-full h-2 bg-slate-200 dark:bg-slate-700 rounded-full overflow-hidden">
                <div
                  className="h-full bg-gradient-to-r from-blue-500 via-blue-600 to-blue-700 transition-all duration-300 ease-out"
                  style={{ width: `${progress}%` }}
                />
              </div>

              {/* Helpful Tip */}
              <p className="text-xs text-slate-500 dark:text-slate-500 mt-4 animate-pulse">
                Hang tight, we're getting things ready...
              </p>
            </div>
          </div>
        </div>
      )}
    </>
  )
}
