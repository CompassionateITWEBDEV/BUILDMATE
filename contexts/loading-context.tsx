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
  const [loadingStartTime, setLoadingStartTime] = useState<number | null>(null)
  const pathname = usePathname()
  const MIN_LOADING_TIME = 60000 // 1 minute in milliseconds

  // Auto-loading on route changes
  useEffect(() => {
    // When pathname changes, start loading and track start time
    const startTime = Date.now()
    setLoadingStartTime(startTime)
    setIsLoading(true)
    
    // Ensure minimum loading time of 1 minute
    const timer = setTimeout(() => {
      setIsLoading(false)
      setLoadingStartTime(null)
    }, MIN_LOADING_TIME)

    return () => clearTimeout(timer)
  }, [pathname])

  const setLoading = (loading: boolean, message?: string) => {
    setIsLoading(loading)
    if (message !== undefined) {
      setLoadingMessage(message)
    }
  }

  const startLoading = (message?: string) => {
    const startTime = Date.now()
    setLoadingStartTime(startTime)
    setIsLoading(true)
    if (message) {
      setLoadingMessage(message)
    }
  }

  const stopLoading = () => {
    // Ensure minimum loading time of 1 minute
    if (loadingStartTime) {
      const elapsed = Date.now() - loadingStartTime
      const remainingTime = MIN_LOADING_TIME - elapsed
      
      if (remainingTime > 0) {
        // Wait for remaining time to meet minimum
        setTimeout(() => {
          setIsLoading(false)
          setLoadingStartTime(null)
        }, remainingTime)
      } else {
        // Already past minimum time, stop immediately
        setIsLoading(false)
        setLoadingStartTime(null)
      }
    } else {
      setIsLoading(false)
    }
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

