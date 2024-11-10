import {stdinAsyc} from '../../packages/stdin-async/src/index.ts'

export type StdinLoopType = 'loop' | 'loopJson' | 'loopLines' | boolean

export function validateStdinType(type: any): type is StdinLoopType {
  const validOptions: StdinLoopType[] = ['loop', 'loopJson', 'loopLines', true, false]
  return validOptions.includes(type)
}

export const stdinLoop = async (type: StdinLoopType) => {
  const validOptions = ['loop', 'loopJson', 'loopLines', true, false]
  if (!validOptions.includes(type)) {
    throw new Error(`Invalid stdin: ${type}`)
  }
  if (!type) return [{stdin: null}]
  const stdin = await stdinAsyc()
  if (!stdin) return [{stdin: null}]
  if (type == 'loop' || type == 'loopJson') {
    try {
      const parsedJson = JSON.parse(stdin)
      if (parsedJson && Array.isArray(parsedJson)) {
        return parsedJson.map(stdin => ({stdin}))
      }
    } catch (e) {
      // swallow
    }
  }
  if (type == 'loop' || type == 'loopLines') {
    return stdin.split('\n').map(stdin => ({stdin}))
  }
  return [{stdin}]
}
