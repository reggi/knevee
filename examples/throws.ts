#!/usr/bin/env -S npx tsx ./src/bin.ts
export const description = 'Run a command gamma'
export const positionals = '<name> <age>'
export const output = 'log'
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
  throw new Error('this is a user error')
}
