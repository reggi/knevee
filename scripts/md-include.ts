import {executablePassthrough} from '../src/index.ts'
import {exec} from 'node:child_process'
import fs from 'node:fs'
import path from 'node:path'
import {promisify} from 'node:util'

const execAsync = promisify(exec)

export const markdown2json = async (filePath: string): Promise<void> => {
  let content = await fs.promises.readFile(path.join(process.cwd(), filePath), 'utf8')
  // Regular expression to find custom command tags and run-blocks with optional language specifier
  const commandRegex = /<!--\s*start\s*run(-block)?(?:-(\w+))?\s*(.*?)\s*-->([\s\S]*?)<!--\s*end\s*run(-block)?\s*-->/g

  const matches = [...content.matchAll(commandRegex)]
  for (const match of matches) {
    const language = match[2] || '' // Capture the optional language specifier
    const command = match[3].trim()
    try {
      const {stdout} = await execAsync(command)
      const codeBlock = language ? `\`\`\`${language}\n${stdout.trim()}\n\`\`\`` : `${stdout.trim()}`
      const replacement = `<!-- start run${language ? '-block-' + language : ''} ${command} -->\n${codeBlock}\n<!-- end run -->`
      content = content.replace(match[0], replacement)
    } catch (err) {
      console.error(`Error executing command '${command}': ${err}`)
      const errorReplacement = `<!-- start run ${command} -->\nError: Could not execute command '${command}'\n<!-- end run -->`
      content = content.replace(match[0], errorReplacement)
    }
  }

  await fs.promises.writeFile(filePath, content)
  console.log(`Processed commands for '${filePath}'`)
}

export const command = executablePassthrough({
  filename: import.meta.filename,
  name: 'markdown2json',
  description: 'Converts Markdown table to json',
  dependencies: ['echo'],
  stdin: false,
  output: false,
  positionals: '<file>',
  default: markdown2json,
})
