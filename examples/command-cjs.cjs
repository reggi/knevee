#!/usr/bin/env -S npx tsx ./src/bin.ts

exports.command = {
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
}
