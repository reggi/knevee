import path from 'node:path'
import {Options} from './options.ts'
import {stdStrings} from '../utils/std-strings.ts'
import {bashFlags, boolFlags, helpFlags} from './flag-options.ts'
import {parsePositionals} from '../positional/index.ts'
import {help} from '../utils/help.ts'
import {table} from '../utils/table.ts'
import {flagTable} from '../utils/flag-table.ts'
import runtimes from './runtimes.ts'

function getName(mod: Options): string[] {
  if (typeof mod.name === 'string') return [mod.name]
  let name: string[] = mod.name
  if (mod.path && !mod.name.length) {
    name = [path.basename(mod.path, path.extname(mod.path))]
  }
  return name
}

export type ParsedOptions = ReturnType<typeof parseOptions>

export function parseOptions(options?: Partial<Options>) {
  const defaultModuleOptions = new Options()
  const mod = {...defaultModuleOptions, ...options}
  const description = mod.description
  const name = getName(mod)
  const dependencies = stdStrings(mod.dependencies)
  const positionals = parsePositionals(mod.positionals, mod.positionalType)
  const flags = {
    ...mod.flags,
    ...(mod.output === 'bash' ? bashFlags : {}),
    ...(mod.output === 'bool' ? boolFlags : {}),
    ...helpFlags,
  }
  const defaultFunc = mod.default
  const fullName = name.join(' ')
  const outputType = mod.output
  const runtime = mod.runtime
    ? stdStrings(mod.runtime)
    : mod?.runtimeKey && runtimes[mod?.runtimeKey]
      ? runtimes[mod.runtimeKey]
      : undefined
  const filename = mod.__filename || mod.importMeta?.filename
  const path = filename ? filename : mod.path
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
