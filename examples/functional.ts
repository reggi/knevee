#!/usr/bin/env -S npx tsx ./src/bin.ts
import {knevee} from '../src/index.ts'

export default knevee({
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
    woof: {
      type: 'string',
    },
  },
  default: function (...args) {
    return 'gamma'
  },
})
