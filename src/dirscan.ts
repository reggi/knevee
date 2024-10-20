import {readdir} from 'node:fs/promises'
import {join} from 'node:path'

/** loops through a folder and gets all the files */
export default async function dirscan(dir: string): Promise<string[]> {
  const allEntries = await readdir(dir, {withFileTypes: true})
  const entries = allEntries.filter(entry => !entry.name.startsWith('.'))
  let results: string[] = []
  for (const entry of entries) {
    const path = join(dir, entry.name)
    if (entry.isDirectory()) {
      results = results.concat(await dirscan(path))
    } else {
      results.push(path)
    }
  }
  return results
}
