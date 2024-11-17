export function help(cmd: {
  name: string[]
  positionalRules: string[]
  description?: string
  dependencies?: string[]
  table: string
}) {
  return [
    `Usage: ${cmd.name.join(' ')} ${cmd.positionalRules.join(' ')}`,
    cmd.description,
    cmd.dependencies?.length ? `Requires \`${cmd.dependencies.join(', ')}\` to be installed` : '',
    ...cmd.table
      .split('\n')
      .filter(Boolean)
      .map(line => line.trim())
      .map(v => `    ${v}`),
  ]
    .map(line => line)
    .filter(Boolean)
    .join('\n')
}
