"use client"

import { usePathname } from "next/navigation"
import { ReactNode, useEffect, useState } from "react"
import { useLoading } from "@/contexts/loading-context"

interface PageWrapperProps {
  children: ReactNode
}

/**
 * Wrapper component that forces remounting of pages when route changes
 * This ensures UI state is reset between page navigations
 * Includes smooth fade transitions between pages
 */
export function PageWrapper({ children }: PageWrapperProps) {
  const pathname = usePathname()
  const { stopLoading } = useLoading()
  const [isMounted, setIsMounted] = useState(false)
  
  // Handle fade transitions when route changes
  useEffect(() => {
    // Reset mounted state when pathname changes
    setIsMounted(false)
    window.scrollTo(0, 0)
    
    // Trigger fade-in animation after DOM update
    const timer = requestAnimationFrame(() => {
      setTimeout(() => {
        setIsMounted(true)
      }, 10)
    })
    
    // Stop loading after page has fully faded in
    const stopLoadingTimer = setTimeout(() => {
      stopLoading()
    }, 350)
    
    return () => {
      cancelAnimationFrame(timer)
      clearTimeout(stopLoadingTimer)
    }
  }, [pathname, stopLoading])
  
  // Use pathname as key to force remount when route changes
  return (
    <div
      key={pathname}
      className={isMounted ? "page-transition-enter" : "opacity-0"}
    >
      {children}
    </div>
  )
}

