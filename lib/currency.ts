/**
 * Currency formatting utilities for Philippine Peso (PHP)
 */

export const CURRENCY_SYMBOL = "₱"
export const CURRENCY_CODE = "PHP"

/**
 * Format a number as Philippine Peso
 * @param amount - The amount to format
 * @param options - Formatting options
 * @returns Formatted currency string
 */
export function formatCurrency(
  amount: number,
  options: {
    showSymbol?: boolean
    showDecimals?: boolean
    compact?: boolean
  } = {}
): string {
  const {
    showSymbol = true,
    showDecimals = false,
    compact = false
  } = options

  let formattedAmount: string

  if (compact && amount >= 1000) {
    // Format as compact notation (e.g., ₱1.2K, ₱1.5M)
    if (amount >= 1000000) {
      formattedAmount = `${(amount / 1000000).toFixed(1)}M`
    } else if (amount >= 1000) {
      formattedAmount = `${(amount / 1000).toFixed(1)}K`
    } else {
      formattedAmount = amount.toLocaleString('en-PH', {
        minimumFractionDigits: showDecimals ? 2 : 0,
        maximumFractionDigits: showDecimals ? 2 : 0
      })
    }
  } else {
    formattedAmount = amount.toLocaleString('en-PH', {
      minimumFractionDigits: showDecimals ? 2 : 0,
      maximumFractionDigits: showDecimals ? 2 : 0
    })
  }

  return showSymbol ? `${CURRENCY_SYMBOL}${formattedAmount}` : formattedAmount
}

/**
 * Parse a currency string back to a number
 * @param currencyString - The currency string to parse
 * @returns The parsed number
 */
export function parseCurrency(currencyString: string): number {
  // Remove currency symbol and commas, then parse
  const cleaned = currencyString.replace(/[₱,]/g, '')
  return parseFloat(cleaned) || 0
}

/**
 * Get price range labels for filtering
 */
export const PRICE_RANGES = {
  budget: { min: 0, max: 50000, label: "Under ₱50,000" },
  mid: { min: 50000, max: 100000, label: "₱50,000 - ₱100,000" },
  high: { min: 100000, max: Infinity, label: "Over ₱100,000" }
} as const

/**
 * Get price range from amount
 */
export function getPriceRange(amount: number): keyof typeof PRICE_RANGES {
  if (amount < PRICE_RANGES.budget.max) return 'budget'
  if (amount < PRICE_RANGES.mid.max) return 'mid'
  return 'high'
}






















