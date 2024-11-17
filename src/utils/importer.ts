/** aids in importing a cjs or mjs js file with or without nested default or nested command property  */
export async function importer(path: string) {
  const cmd = await import(path)
  if (typeof cmd.command !== 'undefined' && typeof cmd.command.default !== 'undefined') {
    return cmd.command
  }
  if (typeof cmd.default !== 'undefined' && typeof cmd.default.default !== 'undefined') {
    return cmd.default
  }
  if (typeof cmd.default !== 'undefined') {
    return cmd
  }
  throw new Error('No command found')
}
