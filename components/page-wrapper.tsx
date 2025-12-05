"use client"

import { usePathname } from "next/navigation"
import { ReactNode, useEffect } from "react"
import { useLoading } from "@/contexts/loading-context"

interface PageWrapperProps {
  children: ReactNode
}

/**
 * Wrapper component that forces remounting of pages when route changes
 * This ensures UI state is reset between page navigations
 * Uses a minimal wrapper that doesn't affect layout
 */
export function PageWrapper({ children }: PageWrapperProps) {
  const pathname = usePathname()
  const { stopLoading } = useLoading()
  
  // Reset scroll position AND stop loading when route changes
  useEffect(() => {
    window.scrollTo(0, 0)
    
    // Stop loading after a small delay to ensure page has rendered
    const timer = setTimeout(() => {
      stopLoading()
    }, 100)
    
    return () => clearTimeout(timer)
  }, [pathname, stopLoading])
  
  // Use pathname as key to force remount when route changes
  // Add top padding to account for fixed header
  return <div key={pathname} className="pt-20">{children}</div>
}

