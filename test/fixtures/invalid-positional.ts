import {executablePassthrough} from '../../src/index.ts'

export const command = executablePassthrough({
  positionals: '<sentence...]',
  default: () => {
    // noop
  },
})
