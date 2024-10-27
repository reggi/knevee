#!/usr/bin/env knevee

export const description = 'Example command alpha'
export const dependencies = ['echo']
export const output = 'bash'
export const positionals = '<name>'

export default name => {
  return `echo "Welcome ${name}"`
}
