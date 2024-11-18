#!/usr/bin/env -S npx tsx ./src/bin.ts
import type {KneveeOptions} from '../index.ts'
import fs from 'node:fs/promises'
import path from 'node:path'

export const md2json = async filePath => {
  let content = await fs.readFile(path.isAbsolute(filePath) ? filePath : path.join(process.cwd(), filePath), 'utf8')
  content = content.trim()
  const lines = content
    .split('\n')
    .map(line => line.trim())
    .filter(line => line)
  const headers = lines[0]
    .split('|')
    .map(header => header.trim())
    .filter(header => header)
  return lines.slice(2).map(line => {
    const values = line.split(/(?<!\\)\|/).map(value => value.trim().replace(/\\\|/g, '|'))
    values.shift()
    let obj = {}
    headers.forEach((header, index) => {
      obj[header] = values[index]
    })
    return obj
  })
}

export const command: KneveeOptions = {
  name: 'md2json',
  description: 'Converts Markdown table to json',
  output: 'json',
  positionals: '<file.md>',
  default: md2json,
}
