import type {ValidatedArgv} from './validate.ts'

export const asObject = (results: ValidatedArgv[]) => {
  return Object.fromEntries(
    results.map((value, index) => {
      const key = '_'.repeat(index + 1)
      return [key, value]
    }),
  )
}
