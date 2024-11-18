/** general helper function to normalize user input for breaking strings into arrays */
export function stdStrings(value: string | string[] = []): string[] {
  if (Array.isArray(value)) {
    value = value.map(v => {
      if (typeof v !== 'string') {
        throw new Error('All items in the array must be strings')
      }
      return v.trim()
    })
  } else if (typeof value === 'string') {
    value = value
      .split(' ')
      .map(v => v.trim())
      .filter(Boolean)
  } else {
    throw new Error('Unable to normalize array')
  }
  return value
}
