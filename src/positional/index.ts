import {splitArgv} from '../utils/split-argv.ts'
import {stdStrings} from '../utils/std-strings.ts'

import {parseRule} from './parse-rule.ts'
import {validatePositionals} from './validate.ts'
import {asObject} from './object.ts'
import {asNamedObject} from './name-object.ts'

export type PositionalType = 'positionalAsNamedObject' | 'positionalAsObject'

export function parsePositionals(ambigousRule: undefined | string | string[], type?: PositionalType) {
  const rule = stdStrings(ambigousRule).map(v => v.replaceAll('[--]', '--'))
  const ddCount = rule.filter(v => v === '--').length
  const rules = splitArgv(rule, ddCount)
  const parsedRules = rules.map(v => parseRule(v))
  const names = parsedRules.flatMap(v => v.items).map(v => v.name)
  const uniqueNames = new Set()
  const duplicates = new Set()
  names.forEach(name => (uniqueNames.has(name) ? duplicates.add(name) : uniqueNames.add(name)))
  if (duplicates.size > 0) {
    throw new Error(`Duplicate positional argument names: ${Array.from(duplicates).join(', ')}`)
  }
  const validType = ['positionalAsNamedObject', 'positionalAsObject', undefined].includes(type)
  if (!validType) {
    throw new Error(`Invalid positional type: ${type}`)
  }
  const validate = (argv: string[]) => {
    const argvDdCount = argv.filter(v => v === '--').length
    if (argvDdCount > ddCount) {
      throw new Error('Invalid number of double dashes')
    }
    const argvInstances = splitArgv(argv, ddCount)
    const results = argvInstances.map((argv, i) => validatePositionals(parsedRules[i], argv))
    if (type === 'positionalAsNamedObject') {
      return Object.assign({}, ...parsedRules.map((v, i) => asNamedObject(v, results[i])))
    }
    if (type === 'positionalAsObject') return asObject(results)
    return results
  }
  const hasRules = Boolean(names.length)
  return {validate, hasRules, rules: rule}
}

// const rule = positionals('<name> <age> [city] [--] <xxx...>', 'positionalAsNamedObject')
// const value = rule(['John', '25', 'New York', '--', 'extra', 'extra2'])
// console.log(value)
