import {stdin} from 'node:process'

export async function getStdin(): Promise<string | null> {
  return new Promise((resolve, reject) => {
    if (stdin.isTTY) {
      resolve(null)
      return
    }

    let dataReceived = false
    let input = ''
    stdin.setEncoding('utf8')

    stdin.on('data', chunk => {
      dataReceived = true
      input += chunk
    })

    stdin.on('end', () => {
      resolve(dataReceived ? input.trim() : null)
    })

    stdin.on('error', err => {
      reject(err)
    })

    // Immediate check to resolve if not readable or no data received within timeout
    setTimeout(() => {
      if (!dataReceived) {
        console.log('No input received within timeout, resolving to null.')
        return resolve(null)
      }
    }, 1000) // Adjust timeout as needed
  })
}

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
  const stdin = await getStdin()
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
