import type {PositionalsParsed} from './parse-rule.ts'
import type {ValidatedArgv} from './validate.ts'

export function asNamedObject({items}: PositionalsParsed, argv: ValidatedArgv) {
  return items.reduce((acc, curr, index) => {
    if (curr.rest) {
      acc[curr.name] = argv.slice(index)
    } else {
      acc[curr.name] = argv[index]
    }
    return acc
  }, {})
}
