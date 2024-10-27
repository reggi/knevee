import {knevee} from '../src/index.ts'

export const json2markdown = json => {
  const data = JSON.parse(json)
  if (!Array.isArray(data)) {
    throw new Error('Input JSON must be an array')
  }

  const headers = Object.keys(data[0])
  const table = [
    `| ${headers.join(' | ')} |`,
    `| ${headers.map(() => '---').join(' | ')} |`,
    ...data.flatMap(row => {
      const rowLines = headers.map(header => row[header].replace('|', '\\|').split('\n'))
      const maxLines = Math.max(...rowLines.map(lines => lines.length))
      return Array.from(
        {length: maxLines},
        (_, i) => `| ${headers.map((header, j) => rowLines[j][i] || '').join(' | ')} |`,
      )
    }),
  ].join('\n')
  return table
}

knevee({
  filename: import.meta.filename,
  name: 'json2markdown',
  description: 'Converts json array to markdown table',
  dependencies: ['echo'],
  stdin: true,
  output: 'log',
  positionals: '<json>',
  default: json2markdown,
})
