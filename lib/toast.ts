import { toast as sonnerToast } from 'sonner'
import { CheckCircle2, XCircle, AlertCircle, Info, Loader2 } from 'lucide-react'

export const toast = {
  success: (message: string, description?: string) => {
    return sonnerToast.success(message, {
      description,
      icon: <CheckCircle2 className="h-5 w-5" />,
    })
  },

  error: (message: string, description?: string) => {
    return sonnerToast.error(message, {
      description,
      icon: <XCircle className="h-5 w-5" />,
    })
  },

  warning: (message: string, description?: string) => {
    return sonnerToast.warning(message, {
      description,
      icon: <AlertCircle className="h-5 w-5" />,
    })
  },

  info: (message: string, description?: string) => {
    return sonnerToast.info(message, {
      description,
      icon: <Info className="h-5 w-5" />,
    })
  },

  loading: (message: string, description?: string) => {
    return sonnerToast.loading(message, {
      description,
      icon: <Loader2 className="h-5 w-5 animate-spin" />,
    })
  },

  promise: <T,>(
    promise: Promise<T>,
    {
      loading,
      success,
      error,
    }: {
      loading: string
      success: string | ((data: T) => string)
      error: string | ((error: any) => string)
    }
  ) => {
    return sonnerToast.promise(promise, {
      loading,
      success,
      error,
    })
  },

  // Custom toast for build actions
  buildSaved: (buildName: string) => {
    return sonnerToast.success('Build Saved!', {
      description: `"${buildName}" has been saved to your builds`,
      icon: <CheckCircle2 className="h-5 w-5" />,
      action: {
        label: 'View',
        onClick: () => {
          if (typeof window !== 'undefined') {
            window.location.href = '/mybuilds'
          }
        }
      }
    })
  },

  buildDeleted: (buildName: string) => {
    return sonnerToast.success('Build Deleted', {
      description: `"${buildName}" has been removed`,
      icon: <XCircle className="h-5 w-5" />,
    })
  },

  componentAdded: (componentName: string) => {
    return sonnerToast.success('Component Added', {
      description: `${componentName} added to your build`,
      icon: <CheckCircle2 className="h-5 w-5" />,
      duration: 2000,
    })
  },

  componentRemoved: (componentName: string) => {
    return sonnerToast.info('Component Removed', {
      description: `${componentName} removed from your build`,
      icon: <Info className="h-5 w-5" />,
      duration: 2000,
    })
  },

  compatibilityIssue: (message: string) => {
    return sonnerToast.warning('Compatibility Issue', {
      description: message,
      icon: <AlertCircle className="h-5 w-5" />,
      duration: 6000,
    })
  },

  buildLiked: () => {
    return sonnerToast.success('Build Liked!', {
      description: 'Added to your liked builds',
      icon: <CheckCircle2 className="h-5 w-5" />,
      duration: 2000,
    })
  },

  buildUnliked: () => {
    return sonnerToast.info('Build Unliked', {
      description: 'Removed from your liked builds',
      icon: <Info className="h-5 w-5" />,
      duration: 2000,
    })
  },

  copyToClipboard: (text: string = 'Text copied to clipboard') => {
    return sonnerToast.success(text, {
      icon: <CheckCircle2 className="h-5 w-5" />,
      duration: 2000,
    })
  },

  dismiss: (toastId?: string | number) => {
    sonnerToast.dismiss(toastId)
  },
}

