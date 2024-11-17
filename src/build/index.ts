#!/usr/bin/env node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning
import {json2md} from './json2md.ts'
import {mdInclude} from './md-include.ts'
import {stringifyTypescript} from './stringify-ts.ts'
import {tsdoc2json} from './tsdoc2json.ts'
import fs from 'node:fs/promises'

async function writeFile(content: string | Promise<any>, file) {
  const resolve = await content
  return fs.writeFile(file, typeof resolve === 'string' ? resolve : JSON.stringify(resolve, null, 2))
}

await writeFile(stringifyTypescript('./src/evaluate/output.ts'), './src/artifacts/output.json')
await writeFile(stringifyTypescript('./src/utils/importer.ts'), './src/artifacts/importer.json')
await writeFile(stringifyTypescript('./src/evaluate/user-error.ts'), './src/artifacts/user-error.json')
await writeFile(stringifyTypescript('./src/evaluate/run.ts'), './src/artifacts/run.json')
await writeFile(json2md(await tsdoc2json('./src/options/options.ts')), './src/artifacts/options-table.md')
await writeFile(mdInclude('./README.md'), './README.md')
