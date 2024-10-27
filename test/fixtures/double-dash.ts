import {knevee} from '../../src/index.ts'

const [exec, greeting] = knevee(
  {
    name: 'greeting',
    description: 'Say hello to someone',
    dependencies: ['echo'],
    output: 'stdout',
    positionals: '<name> -- [beautiful-prose...]',
  },
  (name, flags) => {
    return flags['--']
  },
)

if (import.meta.filename === process.argv[1]) {
  exec()
}
export {greeting}
