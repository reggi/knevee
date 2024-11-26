import {splitArgv} from './split-argv.ts'
import {stdStrings} from '../utils/std-strings.ts'
import {parseRule} from './parse-rule.ts'
import {type ValidatedArgv, validatePositionals} from './validate.ts'
import {asObject} from './object.ts'
import {asNamedObject} from './name-object.ts'

export type PositionalType = 'positionalAsNamedObject' | 'positionalAsObject'

function validateType(type?: string) {
  const validType = ['positionalAsNamedObject', 'positionalAsObject', undefined].includes(type)
  if (type && !validType) {
    throw new Error(`Invalid positional type: ${type}`)
  }
}

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
  validateType(type)
  const validate = (argv: string[]): [ValidatedArgv, Record<string, any>] => {
    const argvDdCount = argv.filter(v => v === '--').length
    if (argvDdCount > ddCount) {
      throw new Error('Invalid number of double dashes')
    }
    const argvInstances = splitArgv(argv, ddCount)
    const results = argvInstances.map((argv, i) => validatePositionals(parsedRules[i], argv))
    if (type === 'positionalAsNamedObject') {
      const object = Object.assign({}, ...parsedRules.map((v, i) => asNamedObject(v, results[i])))
      return [[], object]
    }
    if (type === 'positionalAsObject') {
      const object = asObject(results)
      return [[], object]
    }
    const object = asObject(results)
    const primary = object['_']
    delete object['_']
    return [primary, object]
  }
  const hasRules = Boolean(names.length)
  return {validate, hasRules, rules: rule}
}

// const rule = positionals('<name> <age> [city] [--] <xxx...>', 'positionalAsNamedObject')
// const value = rule(['John', '25', 'New York', '--', 'extra', 'extra2'])
// console.log(value)
