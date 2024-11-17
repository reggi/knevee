#!/usr/bin/env node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin.ts
import type {KneveeOptions} from '../index.ts'
import fs from 'node:fs/promises'
import path from 'node:path'

export const json2md = data => {
  if (!Array.isArray(data)) {
    throw new Error('Input JSON must be an array')
  }
  const headers = Object.keys(data[0])
  const table = [
    `| ${headers.join(' | ')} |`,
    `| ${headers.map(() => '---').join(' | ')} |`,
    ...data.flatMap(row => {
      const rowLines = headers.map(header => (row[header] || '').replaceAll('|', '\\|').split('\n'))
      const maxLines = Math.max(...rowLines.map(lines => lines.length))
      return Array.from(
        {length: maxLines},
        (_, i) => `| ${headers.map((header, j) => rowLines[j][i] || '').join(' | ')} |`,
      )
    }),
  ].join('\n')
  return table
}

export const command: KneveeOptions = {
  name: 'json2markdown',
  description: 'Converts json array to markdown table',
  output: 'log',
  positionals: '<file.json>',
  default: async filePath => {
    if (!filePath) throw new Error('No file path provided')
    return json2md(
      JSON.parse(await fs.readFile(path.isAbsolute(filePath) ? filePath : path.join(process.cwd(), filePath), 'utf8')),
    )
  },
}
