"use client"

import { Cpu } from "lucide-react"

export default function Loading() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800 flex items-center justify-center">
      <div className="text-center">
        <Cpu className="h-16 w-16 text-blue-600 dark:text-blue-400 mx-auto mb-6 animate-pulse" />
        <p className="text-lg font-medium text-slate-700 dark:text-slate-300">
          Loading liked builds...
        </p>
      </div>
    </div>
  )
}
