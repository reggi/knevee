import {Exec} from './Exec.ts'
import {ExecSub} from './ExecSub.ts'
import {type PositionalType, Positionals} from './Positionals.ts'
import {
  defaultModuleOptions,
  type RequiredModuleOptions,
  type ModuleOptions,
  type UserModuleOptions,
} from './options.ts'
import {type FlagOptions, getFlags} from './utils/flags.ts'
import {type StdinLoopType, stdinLoop, validateStdinType} from './utils/stdin.ts'
import {getTable} from './utils/table.ts'
import {config, normalizeArrayOfStrings, resolveDirectory, resolveFile, resolvePath} from './utils/utils.ts'
import fs from 'node:fs/promises'
import path from 'node:path'
import which from 'which'

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

export type ParameterOnly = {
  filename?: string
}

export type GlobalOptions = {
  path?: string
}

export type OutputType = 'bool' | 'json' | 'lines' | `log` | 'stdout' | 'bash' | false

export function validateOutputType(type: any): type is OutputType {
  const validOptions: OutputType[] = ['bool', 'json', 'lines', 'log', 'stdout', 'bash', false]
  return validOptions.includes(type)
}

export class Command implements RequiredModuleOptions {
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
  constructor(_mod: ModuleOptions & {path?: string}) {
    const mod = {...defaultModuleOptions, ..._mod}

    this.path = mod.path

    if (this.path && !path.isAbsolute(this.path)) {
      throw new Error('path must be absolute')
    }

    this.runtime = mod.runtime
    this.name = Array.isArray(mod.name) ? mod.name : [mod.name]

    if (this.path && !this.name.length) {
      this.name = [path.basename(this.path, path.extname(this.path))]
    }

    if (!this.name.length) {
      throw new Error('Command must have a name')
    }
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

  get fullname() {
    return this.name.join(' ')
  }

  help() {
    const cmd = this
    return [
      `Usage: ${cmd.name.join('')} ${cmd.positionals.rules.join(' ')}`,
      cmd.description,
      cmd.dependencies.length ? `Requires \`${cmd.dependencies.join(',')}\` to be installed` : '',
      ...[
        ...getTable(
          Object.entries(cmd.flags).map(([flag, deets]) => {
            const type = deets.type === 'boolean' ? '' : ` <${deets.type}>`
            return [`--${flag} ${type}`.trim(), deets.description || '']
          }),
        ).split('\n'),
        // cmd.hasAttribute(DEFAULT_CWD_ARG_IF_NONE) ? `${cmd.positionals[0]} defaults to cwd` : '',
      ]
        .filter(Boolean)
        .map(line => line.trim())
        .map(v => `    ${v}`),
    ]
      .map(line => line)
      .filter(Boolean)
      .join('\n')
  }

  async validateDeps() {
    const cmd = this
    for (const dep of cmd.dependencies) {
      try {
        await which(dep)
      } catch (e) {
        throw new Error(`"${dep}" is not installed. Please install it and try again.`)
      }
    }
  }

  async run(argv: string[], handler: (positionals: string[], flags: any) => any) {
    const cmd = this
    const flags = getFlags({
      args: argv,
      options: cmd.flags,
      strict: cmd.useStrictFlags,
      allowPositionals: cmd.positionals.hasRules,
    })
    if (flags.help) {
      console.log(cmd.help())
      process.exit(0)
    }
    await cmd.validateDeps()
    const stdin = await stdinLoop(cmd.stdin)

    const promises = stdin.map(async ({stdin}) => {
      var {_, ...restFlags} = flags

      if (cmd.useArgsObject === false) {
        if (stdin && cmd.useUnshiftStdin === true) {
          _.push(stdin)
        }
        var {_, ...restFlags} = cmd.positionals.positionalType(cmd.positionalType, _)
        return handler([..._, {stdin, ...restFlags}], flags)
      }
      return handler([{stdin, ...cmd.positionals.positionalType(cmd.positionalType, _)}], flags)
    })

    if (cmd.useAllSettled) {
      return Promise.allSettled(promises)
    }
    return Promise.all(promises)
  }

  async exec(argv: string[]) {
    return new Exec(this).run(argv)
  }

  async execSub(argv: string[]) {
    return new ExecSub(this).run(argv)
  }

  static async init(opt: {path: string; name?: string | string[]}) {
    const mod = await import(opt.path)
    if (mod.command) {
      return new Command({...mod.command, ...opt})
    }
    return new Command({...mod, ...opt})
  }

  static async fileSubprocess(opt: {path: string; cwd: string; argv: string[]; runtime?: string[]} = config()) {
    const resolved = resolveFile(opt)
    if (!(await fs.stat(resolved.path)).isFile()) {
      throw new Error(`File not found: ${resolved.path}`)
    }
    const cmd = await Command.init({...opt, ...resolved})
    return cmd.execSub(opt.argv)
  }

  static async dirSubprocess(opt: {path: string; cwd: string; argv: string[]; runtime?: string[]} = config()) {
    const resolved = await resolveDirectory(opt)
    if (!(await fs.stat(resolved.path)).isDirectory()) {
      throw new Error(`Directory not found: ${resolved.path}`)
    }
    const cmd = await Command.init({...opt, ...resolved})
    return cmd.execSub(resolved.argv)
  }

  static async pathSubprocess(opt: {path: string; cwd: string; argv: string[]; runtime?: string[]} = config()) {
    const resolved = await resolvePath(opt)
    const cmd = await Command.init({...opt, ...resolved})
    return cmd.execSub(opt.argv)
  }

  static command<T extends (...args: any[]) => any>(
    mod: UserModuleOptions & ParameterOnly & {default?: T},
    handler?: T,
  ): () => void {
    const sub = () => {
      const cmd = new Command({...mod, ...(handler ? {default: handler} : {})})
      cmd.exec(process.argv.slice(2))
    }
    if (typeof mod.filename !== 'undefined' && mod.filename === process.argv[1]) sub()
    return sub
  }

  static executablePassthrough<T extends (...args: any[]) => any>(
    mod: UserModuleOptions & ParameterOnly & {default?: T},
    handler?: T,
  ) {
    const input = {...mod, ...(handler ? {default: handler} : {})}
    const executable = () => {
      const cmd = new Command(input)
      cmd.exec(process.argv.slice(2))
    }
    if (typeof mod.filename !== 'undefined' && mod.filename === process.argv[1]) executable()
    return {...input, executable}
  }
}
