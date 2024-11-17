#!/usr/bin/env node ./src/bin.ts
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
  },
  default: function (...args) {
    throw new Error('this is a user error')
  },
})
