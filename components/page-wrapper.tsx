"use client"

import { usePathname } from "next/navigation"
import { ReactNode, useEffect } from "react"

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
  
  // Reset scroll position when route changes
  useEffect(() => {
    window.scrollTo(0, 0)
  }, [pathname])
  
  // Use pathname as key to force remount when route changes
  // The wrapper div has no styling to avoid affecting layout
  return <div key={pathname}>{children}</div>
}

