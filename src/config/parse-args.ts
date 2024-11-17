import {parseArgs, type ParseArgsConfig} from 'node:util'

type ParseArgsReturn<T extends ParseArgsConfig> = ReturnType<typeof parseArgs<T>>

export function parseArgsBeforePositional<T extends ParseArgsConfig>(options?: T): ParseArgsReturn<T> {
  const args = options?.args || []
  const {tokens} = parseArgs({
    ...options,
    strict: false,
    tokens: true,
    allowPositionals: true,
  })
  const firstPositionalIndex = tokens?.find(v => v.kind === 'positional')?.index ?? -1
  if (firstPositionalIndex === -1) {
    const result = parseArgs<T>(options)
    return {
      // doing this because dirty [Object: null prototype] on values
      values: {...result.values},
      positionals: [],
    } as unknown as ParseArgsReturn<T>
  }
  const start = args.slice(0, firstPositionalIndex)
  const rest = args.slice(firstPositionalIndex + 1)
  const argv = args[firstPositionalIndex]
  const parsedStart = parseArgs<T>({...options, args: start} as T)
  return {
    // doing this because dirty [Object: null prototype] on values
    values: {...parsedStart.values},
    positionals: [argv, ...rest],
  } as unknown as ParseArgsReturn<T>
}
