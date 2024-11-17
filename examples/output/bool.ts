#!/usr/bin/env node --experimental-strip-types --experimental-detect-module --disable-warning=MODULE_TYPELESS_PACKAGE_JSON --disable-warning=ExperimentalWarning ./src/bin.ts
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
