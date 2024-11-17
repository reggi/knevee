#!/usr/bin/env tsx ./src/bin.ts
export const description = 'Run a command gamma'
export const positionals = '<name> <age>'
export const output = 'log'
export const dependencies = 'node-blorq'
export const flags = {
  meow: {
    type: 'string',
    description: 'meow',
  },
}
export default function () {
  return 'gamma'
}
