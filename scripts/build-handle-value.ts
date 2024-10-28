#!/usr/bin/env tsx ./src/bin/knevee.ts
import {executablePassthrough} from '../src/index.ts'
import fs from 'node:fs/promises'

const buildHandleValue = async () => {
  const file = await fs.readFile('./src/utils/value.ts', 'utf8')
  const escapedFile = file.replace(/\\/g, '\\\\')
  const fileLines = escapedFile.trim().split('\n')
  fileLines[0] = `async function handleValue(output, value, flags) {`
  const main = [`export default \``, ...fileLines, `\``].join('\n')
  await fs.writeFile('./src/utils/value-string.ts', main, 'utf8')
}

export const command = executablePassthrough({
  filename: import.meta.filename,
  name: 'build-handle-value',
  description: 'Converts utils/value.ts to a string for subprocess.',
  output: false,
  default: buildHandleValue,
})
