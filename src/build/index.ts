#!/usr/bin/env npx tsx
console.log('Entering file')
import {json2md} from './json2md.ts'
import {mdInclude} from './md-include.ts'
import {stringifyTypescript} from './stringify-ts.ts'
import {tsdoc2json} from './tsdoc2json.ts'
import fs from 'node:fs/promises'

async function writeFile(content: string | Promise<any>, file) {
  const resolve = await content
  return fs.writeFile(file, typeof resolve === 'string' ? resolve : JSON.stringify(resolve, null, 2))
}

async function main() {
  try {
    console.log('Building...')
    console.log('converting output')
    await writeFile(stringifyTypescript('./src/evaluate/output.ts'), './src/artifacts/output.json')
    console.log('converting importer')
    await writeFile(stringifyTypescript('./src/utils/importer.ts'), './src/artifacts/importer.json')
    console.log('converting user-error')
    await writeFile(stringifyTypescript('./src/evaluate/user-error.ts'), './src/artifacts/user-error.json')
    console.log('converting run')
    await writeFile(stringifyTypescript('./src/evaluate/run.ts'), './src/artifacts/run.json')
    console.log('rendering options')
    await writeFile(json2md(await tsdoc2json('./src/options/options.ts')), './src/artifacts/options-table.md')
    console.log('rendering README')
    await writeFile(mdInclude('./README.md'), './README.md')
  } catch (error) {
    console.error('Error during build process:', error)
  }
}

main()
