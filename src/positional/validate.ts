import type {PositionalsParsed} from './parse-rule.ts'

export type ValidatedArgv = (undefined | string)[]

export function validatePositionals(parsed: PositionalsParsed, argv: string[]): ValidatedArgv {
  const {items, hasRest} = parsed
  const requiredPositionals = items.filter(v => v.required)
  const releventPositionals: (undefined | string)[] = hasRest
    ? argv
    : argv.slice(0, items.length).filter(v => v !== undefined)
  if (requiredPositionals.length > releventPositionals.length) {
    const missingPositionals = requiredPositionals.slice(releventPositionals.length)
    throw new Error(`Missing required positional arguments: ${missingPositionals.map(v => v.name).join(', ')}`)
  }
  if (!hasRest && items.length < argv.length) {
    const extraPositionals = argv.slice(items.length)
    throw new Error(`Extra positional arguments: ${extraPositionals.join(', ')}`)
  }
  const fillCount = hasRest ? items.length - 1 : items.length
  while (releventPositionals.length < fillCount) {
    releventPositionals.push(undefined)
  }
  return releventPositionals
}
