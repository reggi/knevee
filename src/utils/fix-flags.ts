export function fixFlags(flags: any) {
  return Object.fromEntries(
    Object.entries(flags).map(([k, v]) => {
      if (typeof v === 'string' && v.startsWith('"') && v.endsWith('"')) return [k, v.slice(1, -1)]
      if (typeof v === 'string' && v.startsWith("'") && v.endsWith("'")) return [k, v.slice(1, -1)]
      return [k, v]
    }),
  )
}
