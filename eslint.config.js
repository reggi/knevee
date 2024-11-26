import eslintPluginImport from 'eslint-plugin-import'
import typescriptParser from '@typescript-eslint/parser'
import path from 'path'
import {recommended} from 'eslint-plugin-treekeeper'
import nodeSpecifier from 'eslint-plugin-node-specifier'
const shared = {
  files: ['src/**/*.ts', 'test/**/*.test.ts'],
  ignores: ['dist/**', 'coverage/**'],
}

/** @type {import('eslint').Linter.Config[]} */
export default [
  recommended(shared),
  {
    ...shared,
    languageOptions: {
      parser: typescriptParser,
      parserOptions: {
        project: path.join(process.cwd(), './tsconfig.json'),
        ecmaFeatures: {
          jsx: true,
        },
      },
    },
    plugins: {
      import: eslintPluginImport,
      'node-specifier': nodeSpecifier,
    },
    rules: {
      'node-specifier/enforce-node-specifier': 'error',
      'import/extensions': [
        'error',
        'ignorePackages',
        {
          js: 'never',
        },
      ],
    },
    settings: {
      'import/extensions': ['.ts'],
    },
  },
]
