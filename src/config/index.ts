import {splitArgv} from '../utils/split-argv.ts'
import {table} from '../utils/table.ts'
import {help} from '../utils/help.ts'
import {flagTable} from '../utils/flag-table.ts'
import {stdStrings} from '../utils/std-strings.ts'
import {parseArgsBeforePositional} from './parse-args.ts'
import {kneveeFlags} from './knevee-flags.ts'
import {absPath} from './abs-path.ts'

export type Config = {
  cwd: string
  runtime: string | string[] | undefined
  target: string | undefined
  help?: boolean | undefined
  argv: string[]
}

export function configEntry(opt?: {cwd?: string; argv?: string[]}) {
  const runtimeKey = process.argv[0].split('/').pop()
  const argvOne = opt?.argv || process.argv.slice(2)
  const [beforeDoubleDash, afterDoubleDash] = splitArgv(argvOne)
  const runtime = afterDoubleDash ? beforeDoubleDash : undefined
  const argvTwo = afterDoubleDash ? afterDoubleDash : beforeDoubleDash

  const {values: flags, positionals: argv} = parseArgsBeforePositional({
    args: argvTwo,
    options: kneveeFlags,
    strict: true,
    allowPositionals: true,
  })

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
  return {...flags, cwd, runtime: runtime || flags.runtime, target, argv, runtimeKey}
}
