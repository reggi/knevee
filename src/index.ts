import {evaluate} from './evaluate/index.ts'
import {command} from './command/index.ts'
import {importer} from './utils/importer.ts'
import {parseOptions} from './options/index.ts'
import {Options} from './options/options.ts'
import {configEntry} from './config/index.ts'
import {debug} from './utils/debug.ts'
import {UserError} from './evaluate/user-error.ts'

const id = Symbol('knevee')
let count = -1

export type KneveeOptions = Partial<Options>

function knevee(opt?: KneveeOptions) {
  count = count + 1
  const logger = debug(`knevee:${count}`)
  logger('start %d', count)
  const filename = opt?.__filename || opt?.importMeta?.filename
  logger('filename is set to %s', filename)
  const executable = async ({nullifyRuntime}: {nullifyRuntime?: boolean} = {}) => {
    const logger = debug(`knevee:executable:${count}`)
    try {
      logger('start')
      if (filename) {
        logger(`filename match`)
        const options = parseOptions(opt)
        const argv = process.argv.slice(2)
        // when this runs as a functional aka `knevee()` file we don't need to use a child process
        if (nullifyRuntime) options.runtime = undefined
        const results = await evaluate(options, argv)
        logger('end')
        return results
      }
      const config = configEntry(opt)
      const {command: cmd, argv} = await command(config)
      logger('importing the file for metadata')
      const mod = await importer(cmd.path)
      if (mod.id === id) {
        logger('exports knevee function')
        return mod.default()
      }
      const options = parseOptions({...config, ...cmd, ...mod})
      if (nullifyRuntime) options.runtime = undefined
      const results = await evaluate(options, argv)
      logger('end')
      return results
    } catch (e) {
      logger('caught error')
      if (e instanceof UserError) {
        logger('throwing as UserError')
        throw e.error
      } else {
        logger('KNEVEE_THROW=%s', process.env.KNEVEE_THROW)
        if (e instanceof Error) {
          if (process.env.KNEVEE_THROW) {
            throw e
          }
          console.error(e.message)
        }
        process.exit(1)
      }
    }
  }
  if (filename === process.argv[1]) {
    logger(`filename and process.argv[1] are the same, running executable`)
    executable({nullifyRuntime: true})
  }
  logger('end')
  return {...opt, executable}
}

knevee.id = id

export {knevee}
