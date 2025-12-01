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

  // Auto-loading on route changes - removed to prevent unnecessary waiting
  useEffect(() => {
    // Loading is now controlled manually, not on route changes
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
