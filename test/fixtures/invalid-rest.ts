import {executablePassthrough} from '../../src/index.ts'

export const command = executablePassthrough({
  name: 'invalid-rest',
  filename: import.meta.filename,
  positionals: '<sentence...> <invalid>',
  default: () => {
    // noop
  },
})
