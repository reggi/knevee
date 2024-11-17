#!/usr/bin/env -S npx tsx ./src/bin.ts
import type {KneveeOptions} from '../index.ts'
import {promisify} from 'node:util'
import {exec} from 'node:child_process'
import fs from 'node:fs/promises'
import path from 'node:path'

const execAsync = promisify(exec)

/**
 * point to a markdown file and looks for comments with commands, evals, then puts the stdout in between comment block
 * @example <!-- start run npm -s run doc-options-md -->
 */
export const mdInclude = async (filePath: string) => {
  let content = await fs.readFile(path.isAbsolute(filePath) ? filePath : path.join(process.cwd(), filePath), 'utf8')
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
  return content
}

export const command: KneveeOptions = {
  name: 'mdInclude',
  description: 'Runs comment scripts within md file and replaces the comment block with output.',
  positionals: '<file.md>',
  default: mdInclude,
}
