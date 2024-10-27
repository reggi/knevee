import {Exec} from './Exec.ts'
import {ExecSub} from './ExecSub.ts'
import {type ModuleOptions} from './options.ts'
import {type PositionalType, Positionals} from './Positionals.ts'
import {type FlagOptions, getFlags} from './utils/flags.ts'
import {type StdinLoopType, stdinLoop, validateStdinType} from './utils/stdin.ts'
import {getTable} from './utils/table.ts'
import {config, resolveDirectory, resolveFile, resolvePath} from './utils/utils.ts'
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
  runtime?: string[]
}

export type OutputType = 'bool' | 'json' | 'lines' | `log` | 'stdout' | 'bash' | false

export function validateOutputType(type: any): type is OutputType {
  const validOptions: OutputType[] = ['bool', 'json', 'lines', 'log', 'stdout', 'bash', false]
  return validOptions.includes(type)
}

export class Command {
  default: (...args: any) => any
  dependencies: string[] = []
  description: string = ''
  flagsOption?: FlagOptions
  name: string[] = []
  output: OutputType = 'log'
  positionals: Positionals
  positionalType: PositionalType = 'positionalAsObject'
  stdin: StdinLoopType = false

  useStrictFlags: boolean = true
  useUnshiftStdin: boolean = true
  useAllSettled: boolean = false
  useArgsObject: boolean = false

  path?: string
  runtime: string[] = [
    'node',
    '--experimental-strip-types',
    '--experimental-detect-module',
    '--disable-warning=MODULE_TYPELESS_PACKAGE_JSON',
    '--disable-warning=ExperimentalWarning',
    '-e',
  ]

  constructor(mod: ModuleOptions & GlobalOptions) {
    if (mod.name) {
      if (Array.isArray(mod.name)) {
        this.name = mod.name
      } else if (typeof mod.name === 'string') {
        this.name = [mod.name]
      } else {
        throw new Error(`Invalid name: ${mod.name}`)
      }
    }

    if (mod.path) {
      if (!path.isAbsolute(mod.path)) {
        throw new Error(`Path must be absolute: ${mod.path}`)
      }
      if (!this.name.length) {
        const cmdName = path.basename(mod.path, path.extname(mod.path))
        this.name = [cmdName]
      }
      this.path = mod.path
    }

    if (!this.name.length) {
      throw new Error('No name provided')
    }

    if (mod.description) {
      this.description = mod.description
    }

    this.positionals = new Positionals(mod.positionals)

    if (mod.dependencies) {
      const d = mod.dependencies
      this.dependencies = (Array.isArray(d) ? d : (d?.split(' ') ?? [])).map(v => v.trim())
    }

    if (mod.useStrictFlags) {
      this.useStrictFlags = mod.useStrictFlags
    }

    if (!mod.default) {
      throw new Error(`No default function provided in ${this.path}`)
    }

    this.default = mod.default

    this.flagsOption = {
      ...(mod.flags ?? {}),
      ...(mod.output === 'bash' ? bashFlags : {}),
      ...(mod.output === 'bool' ? boolFlags : {}),
      ...helpFlags,
    }

    if (typeof mod.stdin !== 'undefined') {
      if (validateStdinType(mod.stdin)) {
        this.stdin = mod.stdin
      } else {
        throw new Error(`Invalid stdin: ${mod.stdin}`)
      }
    }

    if (typeof mod.output !== 'undefined') {
      if (validateOutputType(mod.output)) {
        this.output = mod.output
      } else {
        throw new Error(`Invalid output: ${mod.output}`)
      }
    }

    if (typeof mod.positionalType !== 'undefined') {
      this.positionalType = mod.positionalType
    }
    if (typeof mod.useUnshiftStdin !== 'undefined') {
      this.useUnshiftStdin = mod.useUnshiftStdin
    }
    if (typeof mod.useArgsObject !== 'undefined') {
      this.useArgsObject = mod.useArgsObject
    }
    if (typeof mod.runtime !== 'undefined') {
      this.runtime = mod.runtime
    }
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
          Object.entries(cmd.flagsOption).map(([flag, deets]) => {
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
      options: cmd.flagsOption,
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

  static async init(opt: GlobalOptions & {name?: string | string[]}) {
    const mod = await import(opt.path)
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
    mod: ModuleOptions & ParameterOnly & {argv?: string[]; default?: T},
    handler?: T,
  ): () => void {
    const cmd = new Command({...mod, ...(handler ? {default: handler} : {})})
    const sub = () => cmd.exec(mod.argv || process.argv.slice(2))
    if (typeof mod.filename !== 'undefined' && mod.filename === process.argv[1]) {
      sub()
    }
    return sub
  }

  // static execute<T extends (...args: any[]) => any>(
  //   mod: ModuleOptions & ParameterOnly & {argv?: string[]; default?: T},
  //   handler?: T,
  // ): [T, () => void] {
  //   const cmd = new Command({...mod, ...(handler ? {default: handler} : {})})
  //   const sub = () => cmd.exec(mod.argv || process.argv.slice(2))
  //   const _handler = mod.default || handler
  //   if (typeof mod.filename !== 'undefined' && mod.filename === process.argv[1]) {
  //     sub()
  //   }
  //   return [_handler, sub]
  // }
}
