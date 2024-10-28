import {executablePassthrough} from '../../src/index.ts'

export const command = executablePassthrough({
  output: 'json',
  useArgsObject: true,
  positionalType: 'positionalAsNamedObject',
  positionals: '<firstName> <lastName> <age> <location>',
  default: ({firstName, lastName, age, location}) => {
    return {firstName, lastName, age, location}
  },
})
