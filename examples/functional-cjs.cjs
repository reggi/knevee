#!/usr/bin/env -S npx tsx ./src/bin.ts
const {knevee} = require('../dist/index.cjs')

module.exports = knevee({
  __filename,
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
