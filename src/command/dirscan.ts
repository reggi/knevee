import fs from 'node:fs/promises'
import path from 'node:path'

/** loops through a folder and gets all the files */
export async function dirscan(
  dir: string,
  depth: number = 2,
  ignoreList: string[] = ['node_modules'],
  allowList: string[] = ['.js', '.ts', '.mjs', '.cjs', '.sh'],
  initial: boolean = true,
): Promise<string[]> {
  const kneveeFilePath = path.join(dir, '.knevee')
  if (initial) {
    try {
      await fs.access(kneveeFilePath)
    } catch {
      throw new Error(`The root directory does not contain a .knevee file: ${dir}`)
    }
  }
  if (depth < 0) return []
  const allEntries = await fs.readdir(dir, {withFileTypes: true})
  const entries = allEntries.filter(entry => !entry.name.startsWith('.') && !ignoreList.includes(entry.name))
  let results: string[] = []
  for (const entry of entries) {
    const pathLocation = path.join(dir, entry.name)
    if (entry.isDirectory()) {
      results = results.concat(await dirscan(pathLocation, depth - 1, ignoreList, allowList, false))
    } else {
      if (allowList.length === 0 || allowList.includes(path.extname(entry.name))) {
        results.push(pathLocation)
      }
    }
  }
  return results
}
