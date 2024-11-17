#!/usr/bin/env npx tsx ./src/bin.ts
const description = 'Run a command gamma'
const positionals = '<name> <age>'
const output = 'log'
const flags = {
  meow: {
    type: 'string',
    description: 'meow',
  },
}
function gamma() {
  return 'gamma'
}

module.exports = {
  description,
  positionals,
  output,
  flags,
  default: gamma,
}
