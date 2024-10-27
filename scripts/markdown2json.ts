import {knevee} from '../src/index.ts'

export const markdown2Json = table => {
  table = table.trim()
  const lines = table
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

knevee({
  filename: import.meta.filename,
  name: 'markdown2json',
  description: 'Converts Markdown table to json',
  dependencies: ['echo'],
  stdin: true,
  output: 'json',
  positionals: '<markdown>',
  default: markdown2Json,
})
