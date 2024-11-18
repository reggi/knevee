import {type ParseArgsConfig} from 'node:util'

export type FlagOptions = {
  [longOption: string]: NonNullable<ParseArgsConfig['options']>[number] & {description?: string}
}

export const helpFlags = {
  help: {
    type: 'boolean',
    description: 'Prints command help message',
    short: 'h',
  },
} satisfies FlagOptions

export const boolFlags = {
  emoji: {
    type: 'boolean',
    description: 'Returns boolean value as emoji ✅ or ❌',
    short: 'e',
    default: false,
  },
  int: {
    type: 'boolean',
    description: 'Returns boolean value as 1 or 0',
    short: 'i',
    default: false,
  },
} satisfies FlagOptions

export const bashFlags = {
  print: {
    type: 'boolean',
    description: 'Prints the bash command instead of running it',
    short: 'p',
    default: false,
  },
} satisfies FlagOptions
