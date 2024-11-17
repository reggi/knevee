import {spawn} from 'node:child_process'

export async function spawnJsRuntime(runtime: string[], jsCode: string) {
  const clonedRuntime = [...runtime]
  const main = clonedRuntime.shift()
  if (!main) throw new Error('No runtime provided')

  return new Promise<void>((resolve, reject) => {
    const child = spawn(main, [...clonedRuntime, jsCode], {
      stdio: 'inherit',
    })

    child.on('error', reject)

    child.on('exit', code => {
      if (code === 0) {
        resolve()
      } else {
        process.exit(code ?? 1)
      }
    })
  })
}
