import {executablePassthrough} from '../../src/index.ts'

export const command = executablePassthrough({
  name: 'optional',
  description: 'An example with an optional argument',
  dependencies: ['echo'],
  output: 'bash',
  positionals: '<name> [greeting]',
  default: (name, greeting = 'Welcome') => {
    return `echo "${greeting} ${name}"`
  },
})
