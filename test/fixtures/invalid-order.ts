import {executablePassthrough} from '../../src/index.ts'

export const command = executablePassthrough({
  positionals: '[optional] <required>',
  default: () => {
    // noop
  },
})
