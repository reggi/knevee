import {Readable} from 'node:stream'

export interface StdinType extends Readable {
  isTTY: boolean
}

export async function stdinAsync(customStdin: StdinType = process.stdin): Promise<string | null> {
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

    const onEndOrClose = () => {
      cleanup()
      resolve(input.trim() || null)
    }

    const onError = (err: Error) => {
      cleanup()
      reject(err)
    }

    const cleanup = () => {
      customStdin.removeListener('data', onData)
      customStdin.removeListener('end', onEndOrClose)
      customStdin.removeListener('close', onEndOrClose)
      customStdin.removeListener('error', onError)
      clearTimeout(timeout)
    }

    customStdin.on('data', onData)
    customStdin.on('end', onEndOrClose)
    customStdin.on('close', onEndOrClose)
    customStdin.on('error', onError)

    const timeout = setTimeout(() => {
      if (!dataReceived) {
        cleanup()
        resolve(null)
      }
    }, 1000)
  })
}
