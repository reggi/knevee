import path from 'node:path'
import {pathType} from './path-type.ts'
import {cmdName} from './cmd-name.ts'
import {dirscan} from './dirscan.ts'
import {search} from './search.ts'
import {parseOptions} from '../options/index.ts'
import {table} from '../utils/table.ts'
import {importer} from '../utils/importer.ts'
import type {Config} from '../config/index.ts'
import {debug} from '../utils/debug.ts'

export async function command(config: Config) {
  const logger = debug('knevee:command')
  logger('start')
  const {cwd, target, argv} = config
  let {file, dir} = target ? await pathType(path.resolve(cwd, target)) : {}

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
