import assert from 'node:assert'
import {isAbsolute} from 'node:path'
import {ParseArgsConfig} from 'node:util'

export const helpFlags: FlagsOption = {
  help: {
    type: 'boolean',
    description: 'Prints command help message',
    short: 'h',
  },
}

export const boolFlags: FlagsOption = {
  emoji: {
    type: 'boolean',
    description: 'Returns boolean value as emoji ✅ or ❌',
    short: 'e',
    default: false,
  },
  int: {
    type: 'boolean',
    description: 'Returns boolean value as 1 or 0',
    short: 'i',
    default: false,
  },
}

export const bashFlags: FlagsOption = {
  print: {
    type: 'boolean',
    description: 'Prints the bash command instead of running it',
    short: 'p',
    default: false,
  },
}

type FlagOption = NonNullable<ParseArgsConfig['options']>[number] & {description: string}
type FlagsOption = {[longOption: string]: FlagOption}

type Mod = {
  name?: string
  description?: string
  dependencies?: string[]
  positionals?: string[] | string
  flags?: FlagsOption
  default?: (...args: any) => any
  strictFlags?: boolean
  stdin?: string | boolean
  output?: string | boolean
  unshiftStdin?: boolean
  defaultCwdArgIfNone?: boolean
}

export class Cmdobj {
  keys: string[]
  path: string
  dependencies: string[]
  default: (...args: any) => any
  flags: FlagsOption
  positionals: string[]
  description: string
  strictFlags: boolean
  requiredPositionals: number
  hasRestPositional: boolean
  stdin: string | boolean = 'loop'
  output: string | boolean = 'stdout'
  unshiftStdin: boolean = true
  defaultCwdArgIfNone: boolean = false
  hasAuthoredFlags: boolean

  constructor(opt: {keys: string[]; path: string}, mod: Mod) {
    assert.strictEqual(typeof opt.path, 'string', 'Path must be a string')
    assert.strictEqual(isAbsolute(opt.path), true, 'Path must be absolute')
    this.keys = opt.keys
    this.path = opt.path
    const p = mod.positionals
    this.description = mod.description ?? ''
    this.positionals = (Array.isArray(p) ? p : (p?.split(' ') ?? [])).map(v => v.trim())
    this.dependencies = mod.dependencies ?? []
    this.strictFlags = mod.strictFlags ?? true

    let foundOptional = false
    this.requiredPositionals = 0
    this.hasRestPositional = false
    for (let i = 0; i < this.positionals.length; i++) {
      const positional = this.positionals[i]
      const optional = positional.startsWith('[') && positional.endsWith(']')
      const required = positional.startsWith('<') && positional.endsWith('>')
      const rest = positional.endsWith('...]') || positional.endsWith('...>')
      if (!optional && !required) {
        throw new Error(`Invalid positional: ${positional}`)
      }

      if (rest) this.hasRestPositional = true

      if (required) this.requiredPositionals++

      if (optional) {
        foundOptional = true
      }

      if (required && foundOptional) {
        throw new Error(`Required positional cannot come after an optional one: ${positional}`)
      }

      if (rest && i !== this.positionals.length - 1) {
        throw new Error(`Rest positional must be the last one: ${positional}`)
      }
    }

    if (!mod.default) {
      throw new Error(`No default function provided in ${this.path}`)
    }

    this.default = mod.default

    this.hasAuthoredFlags = typeof mod.flags !== 'undefined'

    this.flags = {
      ...(mod.flags ?? {}),
      ...(mod.output === 'bash' ? bashFlags : {}),
      ...(mod.output === 'bool' ? boolFlags : {}),
      ...helpFlags,
    }

    if (typeof mod.stdin !== 'undefined') {
      const validOptions = ['loop', 'loopJson', 'loopLines', true, false]
      const valid = validOptions.includes(mod.stdin)
      if (!valid) {
        throw new Error(`Invalid stdin: ${mod.stdin}`)
      }
      this.stdin = mod.stdin
    }

    if (typeof mod.output !== 'undefined') {
      const output = ['bool', 'json', 'lines', 'stdout', 'bash', false]
      const valid = output.includes(mod.output)
      if (!valid) {
        throw new Error(`Invalid stdin: ${mod.output}`)
      }
      this.output = mod.output
    }

    if (mod.unshiftStdin) {
      this.unshiftStdin = mod.unshiftStdin
    }

    if (mod.defaultCwdArgIfNone) {
      this.defaultCwdArgIfNone = mod.defaultCwdArgIfNone
    }
  }

  static async init(opt: {keys: string[]; path: string}) {
    const mod = await import(opt.path)
    return new Cmdobj(opt, mod)
  }
}
