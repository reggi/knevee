import {pathType} from './path-type.ts'
import {cmdName} from './cmd-name.ts'
import {dirscan} from './dirscan.ts'
import {search} from './search.ts'
import {parseOptions} from '../options/index.ts'
import {table} from '../utils/table.ts'
import {importer} from '../utils/importer.ts'
import {debug} from '../utils/debug.ts'
import {absPath} from './abs-path.ts'
import {help} from '../utils/help.ts'
import {flagTable} from '../utils/flag-table.ts'
import {stdStrings} from '../utils/std-strings.ts'
import {parseArgsBeforePositional} from '../utils/parse-args.ts'
import pkg from '../../package.json' with {type: 'json'}
import {fixArgv} from '../utils/fix-argv.ts'
import {fixFlags} from '../utils/fix-flags.ts'
import {kneveeFlags} from './knevee-flags.ts'

export async function command(opt?: {cwd?: string; argv?: string[]}) {
  const logger = debug('knevee:command')
  logger('start')
  const runtimeKey = process.argv[0].split('/').pop()
  // aparently flag args with spaces get split up
  const argvOne = fixArgv(opt?.argv || process.argv.slice(2))

  let {values: flags, positionals: argv} = parseArgsBeforePositional({
    args: argvOne,
    options: kneveeFlags,
    strict: true,
    allowPositionals: true,
  })

  // have to remove the quotes from the flags
  flags = fixFlags(flags)

  if (flags.version) {
    console.log(pkg.version)
    return process.exit(0)
  }

  if (flags.help) {
    console.log(
      help({
        name: ['knevee'],
        description: 'A command line tool that runs other command line tools',
        table: table(flagTable(kneveeFlags)),
        positionalRules: stdStrings('[runtime] [--] [flags] <dir-or-file> [subcommands] [command-args...]'),
      }),
    )
    return process.exit(0)
  }

  const cwd = absPath(flags?.cwd || opt?.cwd || process.cwd())

  const target = argv.shift()

  let {file, dir} = target ? await pathType(absPath(target, cwd)) : {}

  if (file) {
    logger('file match')
    // run command
    const command = cmdName({dir: cwd, file: file})
    logger('end')
    return {command, argv}
  }

  // if it's not a dir it can be a subcommand
  if (!dir) {
    logger('subcommand match')
    dir = cwd
    target && argv.unshift(target)
  } else {
    logger('dir match')
  }

  logger('running dirscan')
  const files = await dirscan(dir)
  const commands = files.map(file => cmdName({dir, file}))
  const {match, results} = search(commands, argv, command => command.name)
  if (!match && !results.length) {
    throw new Error('No command found')
  }
  // run command or list commands
  if (match) {
    logger('matched command "%s"', match.name.join(' '))
    logger('end')
    return {command: match, argv: argv.slice(match.name.length)}
  }
  const hydratedCommands = await Promise.all(
    results.map(async ({name, path}) => {
      logger('importing %s', path)
      return parseOptions({name, path, ...(await importer(path))})
    }),
  )
  const data = hydratedCommands.map(command => [command.fullName, command.description])
  console.log(table(data, {gap: 5}))
  logger('end')
  return process.exit(0)
}
