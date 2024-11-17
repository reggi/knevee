#!/usr/bin/env node ./src/bin.ts
export const description = 'Make Uppercase'
export const positionals = '<name>'
export const output = 'log'
export const stdin = 'loopLines'

export default function (input: string) {
  return input.toUpperCase()
}
