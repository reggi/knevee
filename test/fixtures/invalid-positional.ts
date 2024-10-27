import {knevee} from '../../src/index.ts'

const [exec, greeting] = knevee(
  {
    name: 'greeting',
    description: 'Say hello to someone',
    dependencies: ['echo'],
    output: 'bash',
    positionals: '<name [greeting]',
  },
  (name, greeting = 'Welcome') => {
    return `echo "${greeting} ${name}"`
  },
)

if (import.meta.filename === process.argv[1]) {
  exec()
}
export {greeting}
