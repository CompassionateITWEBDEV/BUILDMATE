"use client"

import { useEffect } from "react"
import { useRouter } from "next/navigation"

export default function GuidesPage() {
  // Redirect directly to the generalized PC building guide
  const router = useRouter()
  
  useEffect(() => {
    router.push('/guides/pc-assembly-guide')
  }, [router])

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-slate-100 dark:from-slate-900 dark:to-slate-800">
      <div className="container mx-auto px-4 py-8 flex items-center justify-center">
        <div className="text-center">
          <h2 className="text-2xl font-bold text-slate-900 dark:text-white mb-4">Loading Build Guide...</h2>
          <p className="text-slate-600 dark:text-slate-400">Redirecting to PC Building Guide</p>
        </div>
      </div>
    </div>
  )
}
