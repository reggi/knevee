import {normalizeArrayOfStrings, splitArgv} from './utils/utils.ts'

type NakedItem = {value: string; rest?: boolean}

class PositionalRules {
  naked: {value: string; rest?: boolean}[]
  private rules: string[]
  private hasRestPositional: boolean
  private requiredPositionals: string[]
  constructor(rules: string | string[] = []) {
    rules = normalizeArrayOfStrings(rules)
    let hasRestPositional = false
    let requiredPositionals: string[] = []
    let hasOptional = false
    let naked: NakedItem[] = []
    for (let i = 0; i < rules.length; i++) {
      const positional = rules[i]
      const optional = positional.startsWith('[') && positional.endsWith(']')
      const required = positional.startsWith('<') && positional.endsWith('>')
      const rest = positional.endsWith('...]') || positional.endsWith('...>')

      if (rest) {
        naked.push({value: positional.slice(1, -4), rest: true})
      } else {
        naked.push({value: positional.slice(1, -1)})
      }

      if (!optional && !required) {
        throw new Error(`Invalid positional: ${positional}`)
      }
      if (rest) hasRestPositional = true
      if (required) requiredPositionals.push(positional)
      if (optional) hasOptional = true
      if (required && hasOptional) {
        throw new Error(`Required positional cannot come after an optional one: ${positional}`)
      }
      if (rest && i !== rules.length - 1) {
        throw new Error(`Rest positional must be the last one: ${positional}`)
      }
    }
    this.naked = naked
    this.rules = rules
    this.hasRestPositional = hasRestPositional
    this.requiredPositionals = requiredPositionals
  }
  validate(argv: string[]) {
    const {rules, requiredPositionals, hasRestPositional} = this
    const _releventPositionals: string[] = argv.slice(0, rules.length)
    const releventPositionals: any[] = _releventPositionals.filter(v => v !== undefined)
    if (requiredPositionals.length > releventPositionals.length) {
      const missingPositionals = requiredPositionals.slice(releventPositionals.length)
      throw new Error(`Missing required positional arguments: ${missingPositionals.join(', ')}`)
    }
    if (!hasRestPositional && rules.length < argv.length) {
      const extraPositionals = argv.slice(rules.length)
      throw new Error(`Extra positional arguments: ${extraPositionals.join(', ')}`)
    }
    const fillCount = hasRestPositional ? rules.length - 1 : rules.length
    while (releventPositionals.length < fillCount) {
      releventPositionals.push(undefined)
    }
    return releventPositionals
  }
  asObjects(argv: string[]) {
    const value = this.validate(argv)
    return this.naked.reduce((acc, curr, index) => {
      if (curr.rest) {
        acc[curr.value] = value.slice(index)
      } else {
        acc[curr.value] = value[index]
      }
      return acc
    }, {})
  }
}

export type PositionalType = 'positionalAsNamedObject' | 'positionalAsObject'

export class Positionals {
  rules: string[] = []
  hasRules: boolean
  private instances: PositionalRules[]
  private numberOfDoubleDashes: number
  constructor(rules: undefined | string | string[] = []) {
    if (typeof rules === 'undefined') {
      this.rules = []
    } else {
      this.rules = normalizeArrayOfStrings(rules)
    }
    this.numberOfDoubleDashes = this.rules.filter(v => v === '--').length
    const s = splitArgv(this.rules, this.numberOfDoubleDashes)
    this.instances = s.map(v => new PositionalRules(v))
    this.hasRules = this.rules.length > 0
  }
  private processInstances(argv: string[], method: (instance: PositionalRules, args: string[]) => any) {
    const argvInstances = splitArgv(argv, this.numberOfDoubleDashes)
    const numberOfDoubleDashes = argv.filter(v => v === '--').length
    const numberOfDoubleDashesInRule = this.numberOfDoubleDashes
    if (numberOfDoubleDashes < numberOfDoubleDashesInRule) {
      throw new Error('Invalid number of double dashes')
    }
    return argvInstances.map((instanceArgs, i) => method(this.instances[i], instanceArgs))
  }
  validate(argv: string[]) {
    return this.processInstances(argv, (instance, args) => instance.validate(args))
  }
  asObjects(argv: string[]) {
    return this.processInstances(argv, (instance, args) => instance.asObjects(args))
  }
  asNamedObject(argv: string[]) {
    const naked: NakedItem[] = []
    const obj = this.processInstances(argv, (instance, args) => {
      // Check for duplicates within the current instance
      const duplicateValues = instance.naked
        .map(n => n.value)
        .filter((value, index, self) => self.indexOf(value) !== index)
      if (duplicateValues.length > 0) {
        throw new Error(
          `Duplicate positional argument names in the same instance: ${[...new Set(duplicateValues)].join(', ')}`,
        )
      }
      // Check for duplicates across all instances processed so far
      const duplicatesAcrossInstances = instance.naked.filter(n => naked.some(existing => existing.value === n.value))
      if (duplicatesAcrossInstances.length > 0) {
        throw new Error(
          `Duplicate positional argument names across instances: ${duplicatesAcrossInstances.map(d => d.value).join(', ')}`,
        )
      }
      naked.push(...instance.naked)
      return instance.asObjects(args)
    })
    return Object.assign({}, ...obj)
  }
  asObject(argv: string[]) {
    const value = this.validate(argv)
    if (value.length === 0) return []
    return Object.fromEntries(
      value.map((item, index) => {
        const key = '_'.repeat(index + 1)
        return [key, item]
      }),
    )
  }

  static validatePositionalType = (type: unknown): type is PositionalType => {
    if (typeof type !== 'string') return false
    return ['positionalAsNamedObject', 'positionalAsObject'].includes(type)
  }

  positionalType(type: PositionalType, argv: string[]) {
    switch (type) {
      case 'positionalAsNamedObject':
        return this.asNamedObject(argv)
      case 'positionalAsObject':
        return this.asObject(argv)
      default:
        throw new Error(`Unrecognized positional type: ${type}`)
    }
  }
}
