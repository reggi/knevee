export type StdinLoopType = 'loop' | 'loopJson' | 'loopLines' | boolean | undefined

export function validateStdinType(type: any): type is StdinLoopType {
  const validOptions: StdinLoopType[] = ['loop', 'loopJson', 'loopLines', true, false, undefined]
  return validOptions.includes(type)
}

export const stdinLoop = async (
  type: StdinLoopType,
  stdinAsync: () => Promise<string | null>,
): Promise<(null | string)[]> => {
  if (!validateStdinType(type)) {
    throw new Error(`Invalid stdin: ${type}`)
  }
  if (!type) return [null]
  const stdin = await stdinAsync()
  if (!stdin) return [null]
  if (type == 'loop' || type == 'loopJson') {
    try {
      const parsedJson = JSON.parse(stdin)
      if (parsedJson && Array.isArray(parsedJson)) {
        return parsedJson
      }
      throw new Error('Invalid JSON input not an array')
    } catch (e) {
      if (type === 'loopJson') {
        throw e
      }
    }
  }
  if (type == 'loop' || type == 'loopLines') {
    return stdin.split('\n')
  }
  return [stdin]
}
