import {type Readable} from 'node:stream'

export interface StdinType extends Readable {
  isTTY: boolean
}

export async function stdinAsyc(customStdin: StdinType = process.stdin): Promise<string | null> {
  return new Promise((resolve, reject) => {
    if (customStdin.isTTY) {
      resolve(null)
      return
    }

    let dataReceived = false
    let input = ''
    customStdin.setEncoding('utf8')

    const onData = (chunk: string) => {
      dataReceived = true
      input += chunk
    }

    const onEnd = () => {
      cleanup()
      if (input.length === 0) {
        resolve(null)
      } else {
        resolve(input.trim())
      }
    }

    const onError = (err: Error) => {
      cleanup()
      reject(err)
    }

    const cleanup = () => {
      customStdin.removeListener('data', onData)
      customStdin.removeListener('end', onEnd)
      customStdin.removeListener('error', onError)
      clearTimeout(timeout)
    }

    customStdin.on('data', onData)
    customStdin.on('end', onEnd)
    customStdin.on('error', onError)

    const timeout = setTimeout(() => {
      if (!dataReceived) {
        cleanup()
        resolve(null)
      }
    }, 1000)
  })
}
