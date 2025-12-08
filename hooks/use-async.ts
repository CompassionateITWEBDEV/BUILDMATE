import { useState, useCallback, useRef, useEffect } from 'react'
import { useLoading } from '@/contexts/loading-context'
import { toast } from '@/lib/toast'

interface UseAsyncOptions {
  loadingMessage?: string
  successMessage?: string
  errorMessage?: string
  showSuccessToast?: boolean
  showErrorToast?: boolean
  timeout?: number // Auto-timeout in ms
}

export function useAsync<T = any>(
  asyncFunction: (...args: any[]) => Promise<T>,
  options: UseAsyncOptions = {}
) {
  const {
    loadingMessage = 'Loading...',
    successMessage,
    errorMessage,
    showSuccessToast = false,
    showErrorToast = true,
    timeout = 30000, // 30 seconds default
  } = options

  const [data, setData] = useState<T | null>(null)
  const [error, setError] = useState<Error | null>(null)
  const [isLoading, setIsLoading] = useState(false)
  const { startLoading, stopLoading } = useLoading()
  const timeoutRef = useRef<NodeJS.Timeout>()

  const execute = useCallback(
    async (...args: any[]) => {
      setIsLoading(true)
      setError(null)
      startLoading(loadingMessage)

      // Set timeout
      timeoutRef.current = setTimeout(() => {
        stopLoading()
        setIsLoading(false)
        const timeoutError = new Error('Request timed out')
        setError(timeoutError)
        if (showErrorToast) {
          toast.error('Request Timeout', 'The operation took too long. Please try again.')
        }
      }, timeout)

      try {
        const result = await asyncFunction(...args)
        setData(result)
        
        if (showSuccessToast && successMessage) {
          toast.success(successMessage)
        }
        
        return result
      } catch (err) {
        const error = err as Error
        setError(error)
        
        if (showErrorToast) {
          toast.error(
            errorMessage || 'Operation Failed',
            error.message || 'Something went wrong. Please try again.'
          )
        }
        
        throw error
      } finally {
        clearTimeout(timeoutRef.current)
        stopLoading()
        setIsLoading(false)
      }
    },
    [asyncFunction, loadingMessage, successMessage, errorMessage, showSuccessToast, showErrorToast, timeout, startLoading, stopLoading]
  )

  const reset = useCallback(() => {
    setData(null)
    setError(null)
    setIsLoading(false)
    if (timeoutRef.current) {
      clearTimeout(timeoutRef.current)
    }
  }, [])

  // Cleanup on unmount
  useEffect(() => {
    return () => {
      if (timeoutRef.current) {
        clearTimeout(timeoutRef.current)
      }
    }
  }, [])

  return {
    data,
    error,
    isLoading,
    execute,
    reset,
  }
}

// Hook for optimistic UI updates
export function useOptimistic<T>(initialData: T) {
  const [optimisticData, setOptimisticData] = useState<T>(initialData)
  const [actualData, setActualData] = useState<T>(initialData)
  const [isOptimistic, setIsOptimistic] = useState(false)

  const updateOptimistically = useCallback((newData: T) => {
    setOptimisticData(newData)
    setIsOptimistic(true)
  }, [])

  const confirmUpdate = useCallback((confirmedData: T) => {
    setActualData(confirmedData)
    setOptimisticData(confirmedData)
    setIsOptimistic(false)
  }, [])

  const revertUpdate = useCallback(() => {
    setOptimisticData(actualData)
    setIsOptimistic(false)
  }, [actualData])

  return {
    data: optimisticData,
    isOptimistic,
    updateOptimistically,
    confirmUpdate,
    revertUpdate,
  }
}

// Hook for debounced loading states
export function useDebouncedLoading(delay: number = 300) {
  const [isLoading, setIsLoading] = useState(false)
  const [showLoading, setShowLoading] = useState(false)
  const timeoutRef = useRef<NodeJS.Timeout>()

  useEffect(() => {
    if (isLoading) {
      // Show loading after delay (prevents flash for quick operations)
      timeoutRef.current = setTimeout(() => {
        setShowLoading(true)
      }, delay)
    } else {
      // Clear timeout and hide loading immediately
      if (timeoutRef.current) {
        clearTimeout(timeoutRef.current)
      }
      setShowLoading(false)
    }

    return () => {
      if (timeoutRef.current) {
        clearTimeout(timeoutRef.current)
      }
    }
  }, [isLoading, delay])

  return {
    isLoading,
    showLoading,
    setIsLoading,
  }
}


