import fs from 'node:fs/promises'

/** checks the type (dir or file) of a path */
export async function pathType(path: string): Promise<{file?: string; dir?: string}> {
  try {
    const stat = await fs.stat(path)
    if (stat.isFile()) return {file: path}
    if (stat.isDirectory()) return {dir: path}
    return {}
  } catch (e) {
    return {}
  }
}
