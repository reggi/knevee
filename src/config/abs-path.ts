import path from 'node:path'
import os from 'node:os'

/** converts path to absolute path */
export function absPath(filePath: string) {
  if (!filePath) {
    throw new Error('A file path must be provided.')
  }
  if (filePath.startsWith('~')) {
    return path.join(os.homedir(), filePath.slice(1))
  }
  if (path.isAbsolute(filePath)) {
    return path.normalize(filePath)
  }
  return path.resolve(filePath)
}
