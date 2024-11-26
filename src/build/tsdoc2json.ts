#!/usr/bin/env -S npx tsx ./src/bin.ts
import {exec} from 'node:child_process'
import {type KneveeOptions} from '../index.ts'
import {promisify} from 'node:util'

const execAsync = promisify(exec)

export const tsdoc2json = async file => {
  const {stdout} = await execAsync(`deno doc --json ${file}`)
  const data = JSON.parse(stdout.trim())
  return data?.nodes[0].classDef?.properties.map(v => {
    const getTypeString = tsType => {
      if (tsType.kind === 'union') {
        return tsType.union.map(getTypeString).join(' | ')
      } else if (tsType.kind === 'array') {
        return `${getTypeString(tsType.array)}[]`
      } else if (tsType.kind === 'fnOrConstructor') {
        return 'Function'
      }
      return tsType.repr || tsType.keyword
    }
    return {
      name: v.name,
      type: getTypeString(v.tsType),
      doc: v?.jsDoc?.doc,
    }
  })
}

export const command: KneveeOptions = {
  name: 'doc2json',
  description: 'Converts ts file ast with comments to simler json object',
  dependencies: ['deno'],
  output: 'json',
  positionals: '<file.ts>',
  default: tsdoc2json,
}
