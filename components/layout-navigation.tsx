"use client"

import { usePathname } from "next/navigation"
import { Navigation } from "@/components/navigation"

/**
 * Conditional Navigation wrapper for layout
 * Hides navigation on authentication pages
 */
export function LayoutNavigation() {
  const pathname = usePathname()
  
  // Pages where navigation should be hidden
  const hideNavigationPaths = [
    '/login',
    '/register',
    '/forgot-password',
    '/reset-password',
  ]
  
  // Check if current path should hide navigation
  const shouldHideNavigation = hideNavigationPaths.some(path => pathname?.startsWith(path))
  
  // Don't render navigation on auth pages
  if (shouldHideNavigation) {
    return null
  }
  
  return <Navigation />
}

