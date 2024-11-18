/**
 * given array of objects with a property that is an array
 * finds the item that most closely matches argv
 * used for filtering all commands in a directory when a sub command is provided.
 */
export function search<T>(items: T[], argv: string[], keyExtractor: (item: T) => string[]): {match?: T; results: T[]} {
  // Use keyExtractor to get the string array from each item
  const relevantArgv = argv.filter(arg => items.some(item => keyExtractor(item).includes(arg)))
  // Finding exact matches first
  const match = items.find(item => {
    const keys = keyExtractor(item)
    return keys.length === relevantArgv.length && relevantArgv.every(arg => keys.includes(arg))
  })
  // Return exact match if found
  if (match) {
    // command match, run it
    return {match, results: []}
  }
  // Filter items that contain all relevant argv elements and have equal or more keys than argv
  const results = items.filter(item => {
    const keys = keyExtractor(item)
    return relevantArgv.every(arg => keys.includes(arg)) && keys.length >= argv.length
  })
  // list help even if 1 result
  return {match: undefined, results}
}
