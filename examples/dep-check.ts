#!/usr/bin/env -S npx tsx ./src/bin.ts
export const description = 'Run a command gamma'
export const positionals = '<name> <age>'
export const output = 'log'
export const dependencies = 'node'
export const flags = {
  meow: {
    type: 'string',
    description: 'meow',
  },
  woof: {
    type: 'string',
  },
}
export default function () {
  return 'gamma'
}
