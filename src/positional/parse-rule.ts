export type PositionalItem = {value: string; name: string; required: boolean; rest?: boolean}

export type PositionalsParsed = {
  items: PositionalItem[]
  hasRest: boolean
  hasRequired: boolean
  hasOptional: boolean
}

export function parseRule(rules: string[]): PositionalsParsed {
  let hasRest = false
  let hasOptional = false
  let hasRequired = false
  let items: PositionalItem[] = []
  for (let i = 0; i < rules.length; i++) {
    const value = rules[i]
    const optional = value.startsWith('[') && value.endsWith(']')
    const required = value.startsWith('<') && value.endsWith('>')
    const rest = value.endsWith('...]') || value.endsWith('...>')
    if (!optional && !required) {
      throw new Error(`Invalid positional: ${value}`)
    }
    if (rest) hasRest = true
    if (required) hasRequired = true
    if (optional) hasOptional = true
    if (required && hasOptional) {
      throw new Error(`Required positional cannot come after an optional one: ${value}`)
    }
    if (rest && i !== rules.length - 1) {
      throw new Error(`Rest positional must be the last one: ${value}`)
    }
    if (rest) {
      items.push({value, required, name: value.slice(1, -4), rest: true})
    } else {
      items.push({value, required, name: value.slice(1, -1)})
    }
  }
  return {items, hasRest, hasRequired, hasOptional}
}
