#!/usr/bin/env node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin.ts
export const description = 'Make Uppercase'
export const positionals = '<name>'
export const output = 'log'
export const stdin = 'loopLines'

export default function (input: string) {
  return input.toUpperCase()
}
