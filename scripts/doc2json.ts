import {knevee} from '../src'

export const doc2json = ast => {
  const data = JSON.parse(ast)
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
      doc: v.jsDoc.doc,
    }
  })
}

knevee({
  filename: import.meta.filename,
  name: 'doc2json',
  description: 'Converts deno doc ast to simler json object',
  stdin: true,
  output: 'json',
  positionals: '<json-ast>',
  default: doc2json,
})
