import {executablePassthrough} from '../../src/index.ts'

export const command = executablePassthrough({
  output: 'json',
  useArgsObject: true,
  positionalType: 'positionalAsNamedObject',
  positionals: '<name> <favoriteFood...>',
  default: ({name, favoriteFood}) => {
    return {name, favoriteFood}
  },
})
