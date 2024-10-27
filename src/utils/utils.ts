import {Command} from '../Command.ts'
import {getTable} from './table.ts'
import {readdir, stat} from 'node:fs/promises'
import path, {join} from 'node:path'

export function normalizeArrayOfStrings(value: string | string[] = []): string[] {
  if (Array.isArray(value)) {
    value = value.map(v => {
      if (typeof v !== 'string') {
        throw new Error('All items in the array must be strings')
      }
      return v.trim()
    })
  } else if (typeof value === 'string') {
    value = value.split(' ').map(v => v.trim())
  } else {
    throw new Error('Unable to normalize array')
  }
  return value
}

export function splitArgv(argv: string[], splitCount: number = 1): string[][] {
  const result: string[][] = []
  let remainingArgs = argv
  for (let i = 0; i < splitCount; i++) {
    const doubleDashIndex = remainingArgs.indexOf('--')
    if (doubleDashIndex === -1) {
      result.push(remainingArgs)
      return result
    }
    result.push(remainingArgs.slice(0, doubleDashIndex))
    remainingArgs = remainingArgs.slice(doubleDashIndex + 1)
  }
  result.push(remainingArgs)
  return result
}

export class UserError extends Error {
  error: Error
  constructor(error: Error) {
    super(error.message)
    this.error = error
  }
}

export function config() {
  const cwd = process.cwd()
  const [_, __] = splitArgv(process.argv.slice(2), 1)
  const runtime = __ ? _ : undefined
  const path = __ ? __.shift() : _.shift()
  const argv = __ ? __ : _
  if (!path) {
    throw new Error('No path provided')
  }
  return {
    ...(runtime ? {runtime} : {}),
    path: normalizePath({cwd, path}),
    argv,
    cwd,
  }
}

export function filterAndMatchItems<T extends {name: string[]}>(
  items: T[],
  argv: string[],
): {match: T | undefined; results: T[]} {
  // Filter out argv elements that do not exist in any item's keys
  const relevantArgv = argv.filter(arg => items.some(item => item.name.includes(arg)))
  // Finding exact matches first
  const match = items.find(
    item => item.name.length === relevantArgv.length && relevantArgv.every(arg => item.name.includes(arg)),
  )
  // Return exact match if found
  if (match) {
    return {match, results: []}
  }
  // Filter items that contain all relevant argv elements and have equal or more keys than argv
  const results = items.filter(
    item => relevantArgv.every(arg => item.name.includes(arg)) && item.name.length >= argv.length,
  )
  return {results, match: undefined}
}

/** loops through a folder and gets all the files */
export async function dirscan(dir: string): Promise<string[]> {
  const allEntries = await readdir(dir, {withFileTypes: true})
  const entries = allEntries.filter(entry => !entry.name.startsWith('.'))
  let results: string[] = []
  for (const entry of entries) {
    const path = join(dir, entry.name)
    if (entry.isDirectory()) {
      results = results.concat(await dirscan(path))
    } else {
      results.push(path)
    }
  }
  return results
}

export async function resolveDirectory(opt: {path: string; argv: string[]}) {
  const pointer = opt.path
  const argv = opt.argv
  const files = await dirscan(pointer)
  const relFiles = files.map(file => {
    const relative = path.relative(pointer, file)
    const basename = path.basename(file, path.extname(file))
    const coreKeys = path
      .dirname(relative)
      .split(path.sep)
      .filter(v => v !== '.')
    const safeBasename = basename === 'index' ? [] : [basename]
    const name = [...coreKeys, ...safeBasename]
    return {name, path: file}
  })
  const resolve = await (async () => {
    const {match, results} = filterAndMatchItems(relFiles, argv)
    if (!match && results.length === 0) {
      throw new Error('No commands match')
    }
    // if more than one command matches show a table of all the commands
    if (results.length) {
      const commands = await Promise.all(
        results.map(({name, path}) => {
          return Command.init({name, path})
        }),
      )
      const table = commands.map(command => [command.fullname, command.description])
      console.log(getTable(table, {gap: 5}))
      return process.exit(0)
    }
    if (!match) {
      throw new Error('No commands match')
    }
    return match
  })()
  return {
    ...resolve,
    argv: argv.slice(resolve.name.length),
  }
}

export function normalizePath(opts: {path: string; cwd: string}) {
  if (!opts.path) {
    throw new Error('No file / dir provided')
  }
  if (typeof opts.path !== 'string') {
    throw new Error('Path must be a string')
  }
  if (!path.isAbsolute(opts.path)) {
    return path.resolve(opts.cwd, opts.path)
  }
  return opts.path
}

export function resolveFile(opts: {path: string}) {
  const cmdName = path.basename(opts.path, path.extname(opts.path))
  return {name: [cmdName], path: opts.path}
}

export async function resolvePath(opts: {path: string; cwd: string; argv: string[]}) {
  const cwd = opts.cwd
  let _pointer = opts.path
  let argv = opts.argv
  let pointer = normalizePath(opts)
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
  if (stats.isFile()) return resolveFile({path: pointer})
  if (!stats.isDirectory()) throw new Error('Path must be a file or directory')
  return resolveDirectory({path: pointer, argv})
}

export function wrapError(e: UserError | Error) {
  if (e instanceof UserError) {
    throw e.error
  } else {
    if (e instanceof Error) {
      if (process.env.KNEVEE_THROW) {
        throw e
      }
      console.error(e.message)
    }
    process.exit(1)
  }
}
