interface HasKeys {
  keys: string[]
}

export function filterItems<T extends HasKeys>(items: T[], argv: string[]) {
  // Filter out argv elements that do not exist in any item's keys
  const relevantArgv = argv.filter(arg => items.some(item => item.keys.includes(arg)))

  // Finding exact matches first
  const match = items.find(
    item => item.keys.length === relevantArgv.length && relevantArgv.every(arg => item.keys.includes(arg)),
  )

  // Return exact match if found
  if (match) {
    return {match, results: []}
  }

  // Filter items that contain all relevant argv elements and have equal or more keys than argv
  const results = items.filter(
    item => relevantArgv.every(arg => item.keys.includes(arg)) && item.keys.length >= argv.length,
  )
  return {results, match: undefined}
}
