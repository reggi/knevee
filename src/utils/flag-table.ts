export function flagTable(flags: Record<string, {type: string; description: string}>) {
  return Object.entries(flags).map(([flag, deets]) => {
    const type = deets.type === 'boolean' ? '' : ` <${deets.type}>`
    return [`--${flag} ${type}`.trim(), deets.description || '']
  })
}
