import {executablePassthrough} from '../../src/index.ts'

export const command = executablePassthrough({
  output: 'json',
  default: () => {
    return {ok: 200}
  },
})
