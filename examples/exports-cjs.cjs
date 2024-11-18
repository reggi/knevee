#!/usr/bin/env -S npx tsx ./src/bin.ts
const description = 'Run a command gamma'
const positionals = '<name> <age>'
const output = 'log'
const flags = {
  meow: {
    type: 'string',
    description: 'meow',
  },
  woof: {
    type: 'string',
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
