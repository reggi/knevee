import { spawn } from 'child_process';
import {Cmdobj} from './cmdobj.js'
import dirscan from './dirscan.js'
import {filterItems} from './filter.js'
import {getStdin} from './stdin.js'
import {getTable} from './table.js'
import {stat} from 'node:fs/promises'
import path from 'node:path'
import process from 'node:process'
import {parseArgs} from 'node:util'
import which from 'which'

async function _commandCenter(_pointer: undefined | string, argv: string[]) {
  const cwd = process.cwd()
  if (!_pointer) {
    throw new Error('No file / dir provided')
  }
  let pointer = _pointer
  if (typeof pointer !== 'string') {
    throw new Error('Path must be a string')
  }
  if (!path.isAbsolute(pointer)) {
    pointer = path.resolve(cwd, pointer)
  }

  const cmdName = path.basename(pointer, path.extname(pointer))

  const stats = await (async () => {
    try {
      const stats = await stat(pointer)
      return stats
    } catch (e) {
      // it's not a path maybe command
      pointer = cwd
      argv = [_pointer, ...argv]
      return await stat(cwd)
    }
  })()

  const [files, pointerType] = await (async () => {
    const pointerIsDir = stats.isDirectory()
    const pointerIsFile = stats.isFile()
    const pointerType = pointerIsDir ? 'directory' : pointerIsFile ? 'file' : null
    const files = pointerIsDir ? await dirscan(pointer) : [pointer]
    if (!pointerType) throw new Error('Path must be a file or directory')
    return [files, pointerType]
  })()

  const relFiles = files.map(file => {
    const relative = path.relative(pointer, file)
    const basename = path.basename(file, path.extname(file))
    const coreKeys = path
      .dirname(relative)
      .split(path.sep)
      .filter(v => v !== '.')
    const safeBasename = basename === 'index' ? [] : [basename]
    const keys = [...coreKeys, ...safeBasename]
    return {relative, keys, file}
  })

  const resolve = await (async () => {
    if (pointerType === 'directory') {
      const {match, results} = filterItems(relFiles, argv)
      if (!match && results.length === 0) {
        throw new Error('No commands match')
      }
      // if more than one command matches show a table of all the commands
      if (results.length) {
        const commands = await Promise.all(
          results.map(({keys, file}) => {
            return Cmdobj.init({keys, path: file})
          }),
        )
        const table = commands.map(command => [command.keys.join(' '), command.description])
        console.log(getTable(table, {gap: 5}))
        return process.exit(0)
      }
      if (!match) {
        throw new Error('No commands match')
      }
      return {keys: match.keys, path: match.file}
    } else {
      return {keys: [cmdName], path: pointer}
    }
  })()

  const cmd = await Cmdobj.init(resolve)

  if (pointerType === 'directory') {
    argv = argv.slice(cmd.keys.length)
  }

  const flags: any = (() => {
    const {values, positionals, tokens} = parseArgs({
      args: argv,
      options: cmd.flags,
      strict: cmd.strictFlags,
      allowPositionals: cmd.positionals.length > 0,
      tokens: true,
    })
    const terminatorIndex = tokens.findIndex(token => token.kind === 'option-terminator')
    if (terminatorIndex === -1) {
      return {_: positionals, ...values}
    }
    const beforeTerminator = positionals.slice(0, terminatorIndex)
    const afterTerminator = positionals.slice(terminatorIndex)
    return {_: beforeTerminator, '--': afterTerminator, ...values}
  })()

  if (flags.help) {
    console.log(
      [
        `Usage: ${cmd.keys.join('')} ${cmd.positionals.join(' ')}`,
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
        .join('\n'),
    )
    process.exit(0)
  }

  for (const dep of cmd.dependencies) {
    try {
      await which(dep)
    } catch (e) {
      throw new Error(`"${dep}" is not installed. Please install it and try again.`)
    }
  }

  const stdinLoop = await (async () => {
    if (!cmd.stdin) return [[]]
    const stdin = await getStdin()
    if (!stdin) return [[]]
    if (cmd.stdin == 'loop' || cmd.stdin == 'loopJson') {
      try {
        const parsedJson = JSON.parse(stdin)
        if (parsedJson && Array.isArray(parsedJson)) {
          return parsedJson.map(v => [v])
        }
      } catch (e) {
        // swallow
      }
    }
    if (cmd.stdin == 'loop' || cmd.stdin == 'loopLines') {
      return stdin.split('\n').map(v => [v])
    }
    return [[stdin]]
  })()

  const input = stdinLoop.map(stdin => {
    const clone = {...flags}

    if (stdin && cmd.unshiftStdin) {
      clone._.unshift(...stdin)
    }
    if (cmd.defaultCwdArgIfNone && clone._.length === 0) {
      clone._.push(cwd)
    }
    if (cmd.positionals.length !== 0) {
      const {_, ...rest} = clone
      const truncatedPositionals: string[] = _.slice(0, cmd.positionals.length)
      const hasPositionals = truncatedPositionals.filter(v => v !== undefined)
      if (cmd.requiredPositionals > hasPositionals.length) {
        const missingPositionals = cmd.positionals.slice(hasPositionals.length)
        throw new Error(`Missing required positional arguments: ${missingPositionals.join(', ')}`)
      }
      if (cmd.positionals.length < _.length) {
        const extraPositionals = _.slice(cmd.positionals.length)
        throw new Error(`Extra positional arguments: ${extraPositionals.join(', ')}`)
      }
      const FLAGS_OBJECT = Symbol('FLAGS_OBJECT')
      const includeFlags = cmd.hasAuthoredFlags ? [{...rest, FLAGS_OBJECT}] : []
      return [...truncatedPositionals, ...includeFlags]
    }
    return [clone]
  })

  await Promise.all(
    input.map(async args => {
      try {
        // Create the JavaScript code as a string
        const jsCode = `
          const flags = ${JSON.stringify(flags)};
          import('${cmd.path}').then(async cmd => {
            const value = await cmd.default(...${JSON.stringify(args)});
            if ("${cmd.output}" === 'bool') {
              if (flags.emoji) {
                console.log(value ? '✅' : '❌')
              } else if (flags.int) {
                console.log(value ? 1 : 0)
              } else if (value) {
                console.log(value)
              }
            } else if ('${cmd.output}' === 'lines') {
              if (Array.isArray(value)) {
                console.log(value.join('\\n'))
              } else {
                console.log(value)
              }
            } else if ('${cmd.output}' === 'stdout') {
              console.log(value)
            } else if ('${cmd.output}' === 'json') {
              console.log(JSON.stringify(value, null, 2))
            } else if ('${cmd.output}' === 'bash') {
              const code = [value].flat(Infinity).join('\\n')
              if (flags.print) {
                console.log(code)
              } else {
                import('child_process').then(({execSync}) => {
                  execSync(code, { stdio: 'inherit', shell: true });
                })
              }
            }
          });
        `;

        const child = spawn('node', ['--experimental-default-type=module', '-e', jsCode], { stdio: 'inherit' });

        child.on('exit', (code) => {
          process.exit(code ?? 1);
        });
      } catch (e) {
        throw new UserError(e)
      }
    }),
  )
}

export async function commandCenter(pointer: undefined | string, argv: string[]) {
  try {
    return await _commandCenter(pointer, argv)
  } catch (e) {
    if (e instanceof UserError) {
      throw e.error
    } else {
      if (e instanceof Error) {
        console.error('\x1b[31m%s\x1b[0m', e.message)
      }
      process.exit(1)
    }
  }
}

class UserError extends Error {
  constructor(public error: Error) {
    super(error.message)
  }
}
