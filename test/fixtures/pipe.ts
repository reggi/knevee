import {executablePassthrough} from '../../src/index.ts'

export const command = executablePassthrough({
  name: 'optional',
  description: 'An example with an optional argument',
  dependencies: ['echo'],
  output: 'bash',
  stdin: true,
  positionals: '<name>',
  default: name => {
    return `echo "${name}"`
  },
})
