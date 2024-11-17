#!/usr/bin/env npx tsx ./src/bin.ts
import {knevee} from '../../src/index.ts'

export default knevee({
  importMeta: import.meta,
  name: 'gamma',
  output: 'bool',
  description: 'Run a command gamma',
  default: function (...args) {
    return true
  },
})
