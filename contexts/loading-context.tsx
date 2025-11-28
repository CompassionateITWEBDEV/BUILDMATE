"use client"

import React, { createContext, useContext, useState, useEffect, ReactNode } from "react"
import { usePathname } from "next/navigation"

interface LoadingContextType {
  isLoading: boolean
  loadingMessage: string
  setLoading: (loading: boolean, message?: string) => void
  startLoading: (message?: string) => void
  stopLoading: () => void
}

const LoadingContext = createContext<LoadingContextType | undefined>(undefined)

export function LoadingProvider({ children }: { children: ReactNode }) {
  const [isLoading, setIsLoading] = useState(false)
  const [loadingMessage, setLoadingMessage] = useState("Loading...")
  const pathname = usePathname()

  // Auto-loading on route changes
  useEffect(() => {
    // When pathname changes, start loading
    setIsLoading(true)
    
    // Stop loading when page is ready
    const handleLoad = () => {
      setIsLoading(false)
    }

    // Check if page is already loaded
    if (document.readyState === 'complete') {
      // Page already loaded, stop loading after a brief delay
      const timer = setTimeout(() => {
        setIsLoading(false)
      }, 100)
      return () => clearTimeout(timer)
    } else {
      // Wait for page to fully load
      window.addEventListener('load', handleLoad, { once: true })
      
      // Fallback: stop loading after reasonable timeout (5 seconds max)
      const timeout = setTimeout(() => {
        setIsLoading(false)
      }, 5000)

      return () => {
        window.removeEventListener('load', handleLoad)
        clearTimeout(timeout)
      }
    }
  }, [pathname])

  const setLoading = (loading: boolean, message?: string) => {
    setIsLoading(loading)
    if (message !== undefined) {
      setLoadingMessage(message)
    }
  }

  const startLoading = (message?: string) => {
    setIsLoading(true)
    if (message) {
      setLoadingMessage(message)
    }
  }

  const stopLoading = () => {
    setIsLoading(false)
  }

  return (
    <LoadingContext.Provider
      value={{
        isLoading,
        loadingMessage,
        setLoading,
        startLoading,
        stopLoading,
      }}
    >
      {children}
    </LoadingContext.Provider>
  )
}

export function useLoading() {
  const context = useContext(LoadingContext)
  if (context === undefined) {
    throw new Error("useLoading must be used within a LoadingProvider")
  }
  return context
}

