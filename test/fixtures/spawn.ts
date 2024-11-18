import {spawn, type SpawnOptionsWithoutStdio} from 'child_process'
import {stdStrings} from '../../src/utils/std-strings.ts'

/**
 * Extracts leading environment variables from the command parts.
 * Returns an object of env vars and the remaining command parts.
 */
function extractEnvVars(commandParts: string[]): {envVars: Record<string, string>; remainingCommand: string[]} {
  const envVars: Record<string, string> = {}
  let index = 0

  for (const part of commandParts) {
    const envVarMatch = part.match(/^([A-Za-z_][A-Za-z0-9_]*)=(.*)$/)
    if (envVarMatch) {
      const [, key, value] = envVarMatch
      envVars[key] = value
      index++
    } else {
      break
    }
  }

  return {
    envVars,
    remainingCommand: commandParts.slice(index),
  }
}

export function spawnAsync(
  command: string,
  options?: {input: string} & SpawnOptionsWithoutStdio,
): Promise<{stdout: string; stderr: string}> {
  return new Promise((resolve, reject) => {
    const input = options?.input || ''

    // Parse the command string into executable and arguments
    const splitCommand = [...stdStrings(command)]
    if (splitCommand.length === 0) {
      return reject(new Error('No command provided.'))
    }

    // Extract leading env vars from the command
    const {envVars, remainingCommand} = extractEnvVars(splitCommand)

    if (remainingCommand.length === 0) {
      return reject(new Error('No executable found after environment variables.'))
    }

    // Extract executable and arguments from the remaining command
    const executable = remainingCommand.shift()
    const args = remainingCommand

    if (!executable) {
      return reject(new Error('Invalid command after extracting environment variables.'))
    }

    // Prepare the environment for the child process
    const childEnv = {...(options?.env || process.env), ...envVars}

    // Spawn the child process with the modified environment
    const child = spawn(executable, args, {
      stdio: ['pipe', 'pipe', 'pipe'], // Set stdin to 'pipe' to allow writing
      shell: false, // Do not run in a shell
      ...options,
      env: {
        ...options?.env,
        ...childEnv,
      },
    })

    let stdout = ''
    let stderr = ''

    // Capture stdout
    if (child.stdout) {
      child.stdout.on('data', (data: Buffer) => {
        stdout += data.toString()
      })
    }

    // Capture stderr
    if (child.stderr) {
      child.stderr.on('data', (data: Buffer) => {
        stderr += data.toString()
      })
    }

    // Handle process exit
    child.on('close', (code: number) => {
      if (code === 0) {
        resolve({stdout, stderr})
      } else {
        const error = new Error(`Command failed with exit code ${code}`)
        // Attach stderr to the error for more context
        ;(error as any).stderr = stderr
        reject(error)
      }
    })

    // Handle errors during spawning
    child.on('error', (err: Error) => {
      reject(err)
    })

    // If input is provided, write it to stdin
    if (input !== undefined && child.stdin) {
      child.stdin.write(input)
      child.stdin.end() // Close the stdin stream after writing
    }
  })
}
