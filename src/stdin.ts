import {stdin} from 'node:process'

export async function getStdin(): Promise<string | null> {
  return new Promise((resolve, reject) => {
    if (stdin.isTTY) {
      resolve(null)
      return
    }
    let input = ''
    stdin.setEncoding('utf8')
    stdin.on('data', chunk => (input += chunk))
    stdin.on('end', () => {
      input = input.trim()
      resolve(input)
    })
    stdin.on('error', err => reject(err))
  })
}
