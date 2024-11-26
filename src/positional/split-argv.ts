export function splitArgv(values: string[], splitCount: number = 1, match = '--'): string[][] {
  const result: string[][] = []
  let remainingValues = values
  for (let i = 0; i < splitCount; i++) {
    const matchIndex = remainingValues.indexOf(match)
    if (matchIndex === -1) {
      result.push(remainingValues)
      return result
    }
    result.push(remainingValues.slice(0, matchIndex))
    remainingValues = remainingValues.slice(matchIndex + 1)
  }
  result.push(remainingValues)
  return result
}
