import {knevee} from '../../src/index.ts'

const [exec, startsWithT] = knevee(
  {
    name: 'starts-with-t',
    description: 'Checks if name starts with t',
    output: 'bool',
    positionals: '<name>',
  },
  name => {
    return name.startsWith('t') ? name : false
  },
)

if (import.meta.filename === process.argv[1]) {
  exec()
}
export {startsWithT}
