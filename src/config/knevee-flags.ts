import type {FlagOptions} from '../options/flag-options.ts'

export const kneveeFlags = {
  cwd: {
    description: 'The current working directory',
    type: 'string',
    short: 'C',
  },
  runtime: {
    description: 'The runtime to use',
    type: 'string',
  },
  help: {
    description: 'Prints this help',
    type: 'boolean',
    short: 'h',
  },
} satisfies FlagOptions
