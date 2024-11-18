export type RunInput = {
  outputType: string | boolean
  flags: any
  args: string[]
  UserError: any
  handleOutput: any
  func: any
}

export async function run({outputType, handleOutput, UserError, func, args, flags}: RunInput) {
  let value
  try {
    value = await func(...args)
  } catch (e) {
    throw new UserError(e)
  }
  return await handleOutput(outputType, value, flags)
}
