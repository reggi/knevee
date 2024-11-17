#!/usr/bin/env npx tsx ./src/bin.ts
export const command = {
  importMeta: import.meta,
  name: 'gamma',
  output: 'log',
  description: 'Run a command gamma',
  positionals: '<name> <age>',
  flags: {
    meow: {
      type: 'string',
      description: 'meow',
    },
  },
  default: function (...args) {
    return 'gamma'
  },
}
