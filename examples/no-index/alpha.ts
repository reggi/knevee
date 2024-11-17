#!/usr/bin/env node ./src/bin.ts
export const description = 'Run command alpha'
export const positionals = '<name> <age>'
export const output = 'log'
export const flags = {
  meow: {
    type: 'string',
    description: 'meow',
  },
}
export default function () {
  return 'gamma'
}
