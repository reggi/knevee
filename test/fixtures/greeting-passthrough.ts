import {executablePassthrough} from '../../src/index.ts'

export const command = executablePassthrough({
  filename: import.meta.filename,
  name: 'greeting',
  description: 'Say hello to someone',
  dependencies: ['echo'],
  output: 'bash',
  positionals: '<name>',
  default: (name: string) => {
    return `echo "Welcome ${name}"`
  },
})
