"use client"

import { Cpu } from "lucide-react"
import { useLoading } from "@/contexts/loading-context"

export function GlobalLoading() {
  const { isLoading, loadingMessage } = useLoading()

  if (!isLoading) return null

  return (
    <div className="fixed inset-0 z-[9999] bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800 flex items-center justify-center">
      <div className="text-center">
        <Cpu className="h-16 w-16 text-blue-600 dark:text-blue-400 mx-auto mb-6 animate-pulse" />
        <p className="text-lg font-medium text-slate-700 dark:text-slate-300">
          {loadingMessage || "Loading..."}
        </p>
      </div>
    </div>
  )
}

