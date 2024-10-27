import { GlobalOptions, OutputType, validateOutputType } from "./Command"
import { defaultModuleOptions, ModuleOptions, RequiredModuleOptions } from "./options"
import { Positionals, PositionalType } from "./Positionals"
import { FlagOptions } from "./utils/flags"
import { StdinLoopType, validateStdinType } from "./utils/stdin"
import { normalizeArrayOfStrings } from "./utils/utils"

export const helpFlags: FlagOptions = {
  help: {
    type: 'boolean',
    description: 'Prints command help message',
    short: 'h',
  },
}

export const boolFlags: FlagOptions = {
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

export const bashFlags: FlagOptions = {
  print: {
    type: 'boolean',
    description: 'Prints the bash command instead of running it',
    short: 'p',
    default: false,
  },
}

type CommandImplements = RequiredModuleOptions
export class Command implements CommandImplements {
  name: string[]
  description: string
  dependencies: string[]
  positionals: Positionals
  flags: FlagOptions
  default: (...args: any) => any
  useStrictFlags: boolean
  useUnshiftStdin: boolean
  useAllSettled: boolean
  useArgsObject: boolean
  output: OutputType
  stdin: StdinLoopType
  positionalType: PositionalType
  runtime: string[]
  path?: string
  constructor(_mod: ModuleOptions & { path?: string }) {
    const mod = {...defaultModuleOptions, ..._mod}

    this.path = mod.path
    this.runtime = mod.runtime
    this.name = Array.isArray(mod.name) ? mod.name : [mod.name]
    this.description = mod.description
    this.dependencies = normalizeArrayOfStrings(mod.dependencies)
    this.positionals = mod.positionals instanceof Positionals ? mod.positionals : new Positionals(mod.positionals)
    this.flags = {
      ...(mod.flags ?? {}),
      ...(mod.output === 'bash' ? bashFlags : {}),
      ...(mod.output === 'bool' ? boolFlags : {}),
      ...helpFlags,
    }
    
    if (!mod.default) {
      throw new Error('Command must have a default function')
    }

    this.default = mod.default
    this.useAllSettled = mod.useAllSettled
    this.useArgsObject = mod.useArgsObject
    this.useStrictFlags = mod.useStrictFlags
    this.useUnshiftStdin = mod.useUnshiftStdin

    if (!validateStdinType(mod.stdin)) {
      throw new Error(`Invalid stdin: ${mod.stdin}`)
    } 

    this.stdin = mod.stdin

    if (!validateOutputType(mod.output)) {
      throw new Error(`Invalid output: ${mod.output}`)
    }

    this.output = mod.output
    
    if (!Positionals.validatePositionalType(mod.positionalType)) {
      throw new Error(`Invalid positionalType: ${mod.positionalType}`)
    }

    this.positionalType = mod.positionalType
  }
}