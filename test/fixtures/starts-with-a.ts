import {executablePassthrough} from '../../src/index.ts'

export const command = executablePassthrough({
  name: 'starts-with-a',
  description: 'Checks if the name starts with the letter "a"',
  output: 'bool',
  positionals: '<name>',
  default: name => {
    return name.startsWith('a')
  },
})
