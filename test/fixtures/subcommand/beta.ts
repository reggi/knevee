#!/usr/bin/env tsx ./src/bin/knevee-file.ts tsx -e --

export const description = 'Example command beta'
export const dependencies = ['echo']
export const output = 'bash'
export const positionals = '<name>'

export default name => {
  return `echo "Welcome ${name}"`
}
