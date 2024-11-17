import path from 'node:path'
import {Options} from './options.ts'
import {stdStrings} from '../utils/std-strings.ts'
import {bashFlags, boolFlags, helpFlags} from './flag-options.ts'
import {parsePositionals} from '../positional/index.ts'
import {help} from '../utils/help.ts'
import {table} from '../utils/table.ts'
import {flagTable} from '../utils/flag-table.ts'
import runtimes from './runtimes.ts'

function getPath(mod: Options) {
  if (mod.path && !path.isAbsolute(mod.path)) throw new Error('path must be absolute')
  return mod.path
}

function getName(mod: Options): string[] {
  let name = Array.isArray(mod.name) ? mod.name : mod.name ? [mod.name] : []
  if (mod.path && !name.length) {
    name = [path.basename(mod.path, path.extname(mod.path))]
  }
  if (!name.length) throw new Error('Command must have a name')
  return name
}

function getFlags(mod: Options) {
  return {
    ...(mod.flags ?? {}),
    ...(mod.output === 'bash' ? bashFlags : {}),
    ...(mod.output === 'bool' ? boolFlags : {}),
    ...helpFlags,
  }
}

function getOutputType(mod: Options) {
  if (!mod.output) {
    throw new Error('Command must have an output type')
  }
  return mod.output
}

export type ParsedOptions = ReturnType<typeof parseOptions>

export function parseOptions(options?: Options) {
  const defaultModuleOptions = new Options()
  const mod = {...defaultModuleOptions, ...options}
  const description = mod.description
  const name = getName(mod)
  const dependencies = stdStrings(mod.dependencies)
  const positionals = parsePositionals(mod.positionals, mod.positionalType)
  const flags = getFlags(mod)
  const defaultFunc = mod.default
  const fullName = name.join(' ')
  const outputType = getOutputType(mod)
  const runtime = mod.runtime
    ? stdStrings(mod.runtime)
    : mod?.runtimeKey && runtimes[mod?.runtimeKey]
      ? runtimes[mod.runtimeKey]
      : undefined
  const filename = mod.__filename || mod.importMeta?.filename
  const path = filename ? filename : getPath(mod)
  const helpText = help({
    name,
    description,
    dependencies,
    table: table(flagTable(flags)),
    positionalRules: positionals.rules,
  })
  return {
    ...mod,
    name,
    path,
    dependencies,
    positionals,
    flags,
    default: defaultFunc,
    fullName,
    outputType,
    helpText,
    runtime,
    filename,
  }
}
