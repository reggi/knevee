import * as fs from 'fs'
import * as path from 'path'
import {fileURLToPath} from 'url'
import ts from 'typescript'

const tsConfig = JSON.parse(fs.readFileSync(path.resolve('./tsconfig.json'), 'utf-8'))

export default {
  outputDir: './coverage',
  reports: ['v8', 'console-details'],
  entryFilter: {
    '**/node_modules/**': false,
    '**/src/build/**': false,
    '**/*.md': false,
    '**/*': true,
  },
  sourceFilter: {
    '**/node_modules/**': false,
    '**/src/build/**': false,
    '**/*.md': false,
    '**/src/**': true,
  },
  all: {
    dir: ['./src'],
    transformer: async entry => {
      const filePath = fileURLToPath(entry.url)
      const originalSource = fs.readFileSync(filePath, 'utf-8')
      const result = ts.transpileModule(originalSource, tsConfig)
      entry.source = result.outputText
      entry.sourceMap = result.sourceMapText
    },
  },
  onEnd: coverageResults => {
    const thresholds = {
      bytes: 100,
      statements: 100,
      branches: 95,
      functions: 100,
      lines: 100,
    }
    const errors = []
    const {summary} = coverageResults
    Object.keys(thresholds).forEach(k => {
      const pct = summary[k].pct
      if (pct < thresholds[k]) {
        errors.push(`Coverage threshold for ${k} (${pct} %) not met: ${thresholds[k]} %`)
      }
    })
    if (errors.length) {
      const errMsg = errors.join('\n')
      console.log(errMsg)
      process.exit(1)
    }
  },
}
