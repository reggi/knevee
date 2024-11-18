import output from '../artifacts/output.json' with {type: 'json'}
import importer from '../artifacts/importer.json' with {type: 'json'}
import userError from '../artifacts/user-error.json' with {type: 'json'}
import run from '../artifacts/run.json' with {type: 'json'}

export type EvalStringInput = {
  path?: string
  outputType: string | boolean
  flags: any
  args: string[]
}

export const evalString = ({path, outputType, flags, args}: EvalStringInput) => {
  if (!path) {
    throw new Error('No path provided for subprocess')
  }
  return [
    output.code,
    importer.code,
    userError.code,
    run.code,
    `importer(${JSON.stringify(path)}).then(cmd => ${run.name}({
  outputType: ${JSON.stringify(outputType)},
  handleOutput: ${output.name},
  UserError: ${userError.name},
  func: cmd.default,
  args: ${JSON.stringify(args)}.map(v => v === null ? undefined : v),
  flags: ${JSON.stringify(flags)}
}))`,
  ].join('\n')
}

// console.log(evalString({
//   path: './examples/alpha.ts',
//   outputType: 'json',
//   flags: {},
//   args: []
// }))
