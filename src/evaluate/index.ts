import {parseArgs} from 'node:util'
import type {ParsedOptions} from '../options/index.ts'
import {depCheck} from './dep-check.ts'
import {stdinAsync} from './stdin-async.ts'
import {stdinLoop} from './stdin-loop.ts'
import {evalString} from './eval-string.ts'
import {spawnJsRuntime} from './eval.ts'
import {run} from './run.ts'
import {handleOutput} from './output.ts'
import {UserError} from '../utils/user-error.ts'
import {debug} from '../utils/debug.ts'
import {assemblePositials} from '../utils/parse-args.ts'
import type {ValidatedArgv} from '../positional/validate.ts'
import {fixArgv} from '../utils/fix-argv.ts'
import {fixFlags} from '../utils/fix-flags.ts'

export async function evaluate(config: ParsedOptions, argv: string[]) {
  const logger = debug('knevee:evaluate')
  logger('start')

  const parsedArgs = parseArgs({
    tokens: true,
    args: fixArgv(argv),
    options: config.flags,
    strict: config.useStrictFlags,
    allowPositionals: config.positionals.hasRules,
  })

  const positionals = assemblePositials(parsedArgs.tokens)
  const flags = fixFlags(parsedArgs.values)

  if (flags.help) {
    logger('help flag is set, printing help text and exiting')
    console.log(config.helpText)
    process.exit(0)
  }

  await depCheck(config.dependencies)

  const stdin = await stdinLoop(config.stdin, stdinAsync)

  const loopArgs = stdin.map((stdin, index) => {
    const clonedPositionals = [...positionals]
    logger('stdin loop %d %s', index, stdin)
    if (stdin && config.useUnshiftStdin === true) {
      clonedPositionals.push(stdin)
    }
    const [primary, positionalFlags] = config.positionals.validate(clonedPositionals)
    const out: [...ValidatedArgv, Record<string, any>] = [...primary, {...positionalFlags, ...flags}]
    return out
  })

  const runtime = config.runtime && config.runtime.length ? config.runtime : undefined

  const subprocess = async (args: any[]) => {
    const jsCode = evalString({
      path: config.path,
      outputType: config.outputType,
      flags,
      args,
    })
    return await spawnJsRuntime(runtime, jsCode)
  }

  const mainProcess = async (args: any[]) => {
    return run({
      outputType: config.outputType,
      handleOutput,
      UserError,
      func: config.default,
      args,
      flags,
    })
  }

  const method = runtime ? subprocess : mainProcess
  if (runtime) logger('runtime detected as "%s"', runtime.join(' '))

  let results: (number | null)[] = []
  logger('using loop method "%s"', config.useLoopMethod)
  if (config.useLoopMethod === 'for-await') {
    for (const args of loopArgs) {
      results.push(await method(args))
    }
  } else if (config.useLoopMethod === 'allSettled') {
    await Promise.allSettled(
      loopArgs.map(async args => {
        results.push(await method(args))
      }),
    )
  } else if (config.useLoopMethod === 'all') {
    await Promise.all(
      loopArgs.map(async args => {
        results.push(await method(args))
      }),
    )
  }

  if (runtime) {
    if (results.every(result => result === 0)) {
      logger('all subprocess results are 0, returning 0')
      return process.exit(0)
    } else {
      logger('some subprocess results are not 0, returning 1')
      return process.exit(1)
    }
  }

  logger('end')
  return results
}
