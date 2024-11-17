import path from 'node:path'

export function cmdName(opt: {dir: string; file: string}) {
  const {dir, file} = opt
  const relative = path.relative(dir, file)
  const basename = path.basename(file, path.extname(file))
  const coreKeys = path
    .dirname(relative)
    .split(path.sep)
    .filter(v => v !== '.')
  const safeBasename = basename === 'index' ? [] : [basename]
  const name = [...coreKeys, ...safeBasename]
  return {name, path: file}
}
