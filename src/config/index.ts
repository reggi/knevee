import {table} from '../utils/table.ts'
import {help} from '../utils/help.ts'
import {flagTable} from '../utils/flag-table.ts'
import {stdStrings} from '../utils/std-strings.ts'
import {parseArgsBeforePositional} from './parse-args.ts'
import {kneveeFlags} from './knevee-flags.ts'
import {absPath} from './abs-path.ts'
import pkg from '../../package.json' with {type: 'json'}
import {debug} from '../utils/debug.ts'
import {fixArgv} from './fix-argv.ts'
import {fixFlags} from './fix-flags.ts'

export type Config = {
  cwd: string
  runtime?: string | string[]
  target?: string
  help?: boolean
  argv: string[]
}

export function configEntry(opt?: {cwd?: string; argv?: string[]}) {
  const logger = debug('knevee:configEntry')
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
  return {...flags, cwd, target, argv, runtimeKey}
}
