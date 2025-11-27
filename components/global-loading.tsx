"use client"

import { Cpu } from "lucide-react"
import { useLoading } from "@/contexts/loading-context"
import { useState, useEffect } from "react"

export function GlobalLoading() {
  const { isLoading, loadingMessage } = useLoading()
  const [elapsedTime, setElapsedTime] = useState(0)

  useEffect(() => {
    if (!isLoading) {
      setElapsedTime(0)
      return
    }

    const startTime = Date.now()
    const interval = setInterval(() => {
      const elapsed = Math.floor((Date.now() - startTime) / 1000)
      setElapsedTime(elapsed)
    }, 1000)

    return () => clearInterval(interval)
  }, [isLoading])

  if (!isLoading) return null

  return (
    <div className="fixed inset-0 z-[9999] bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800 flex items-center justify-center">
      <div className="text-center">
        <Cpu className="h-16 w-16 text-blue-600 dark:text-blue-400 mx-auto mb-6 animate-pulse" />
        <p className="text-lg font-medium text-slate-700 dark:text-slate-300 mb-2">
          {loadingMessage || "Loading..."}
        </p>
        {elapsedTime > 0 && (
          <p className="text-sm text-slate-500 dark:text-slate-400">
            Elapsed time: {Math.floor(elapsedTime / 60)}:{(elapsedTime % 60).toString().padStart(2, '0')}
          </p>
        )}
        <p className="text-xs text-slate-400 dark:text-slate-500 mt-2">
          Please wait at least 1 minute...
        </p>
      </div>
    </div>
  )
}

