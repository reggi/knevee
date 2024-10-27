import {parseArgs, type ParseArgsConfig} from 'node:util'

export type FlagOption = NonNullable<ParseArgsConfig['options']>[number] & {description?: string}
export type FlagOptions = {[longOption: string]: FlagOption}

// function firstPositionalIndex(
//   options: {
//     args?: string[]
//     options?: FlagOptions
//     strict?: boolean
//     allowPositionals?: boolean
//   } = {},
// ) {
//   const {args} = options
//   const {tokens} = parseArgs({
//     ...options,
//     strict: false,
//     tokens: true,
//     allowPositionals: true,
//   })
//   const _firstPositional = tokens.find(v => v.kind === 'positional')
//   const firstPositionalValue = _firstPositional ? _firstPositional.index : -1
//   const start = args.slice(0, firstPositionalValue)
//   const rest = args.slice(firstPositionalValue + 1)
//   const argv = args[firstPositionalValue]
//   const {_, ...flags} = getFlags({...options, args: start})
//   return {flags, argv, rest}
// }

export const getFlags = (
  options: {
    args?: string[]
    options?: FlagOptions
    strict?: boolean
    allowPositionals?: boolean
  } = {},
): any => {
  const {values, positionals} = parseArgs(options)
  return {_: positionals, ...values}
}
