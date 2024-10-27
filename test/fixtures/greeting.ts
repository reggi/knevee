import {knevee} from '../../src/index.ts'

const [greeting] = knevee({
  filename: import.meta.filename,
  name: 'greeting',
  description: 'Say hello to someone',
  dependencies: ['echo'],
  output: 'bash',
  positionals: '<name>',
  default: name => {
    return `echo "Welcome ${name}"`
  },
})

export {greeting}
