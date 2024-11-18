import eslintPluginImport from 'eslint-plugin-import'
import typescriptParser from '@typescript-eslint/parser'
import path from 'path'

/** @type {import('eslint').Linter.Config[]} */
export default [
  {
    files: ['**/*.ts'],
    ignores: ['dist/**', 'coverage/**'],
    languageOptions: {
      parser: typescriptParser,
      parserOptions: {
        project: path.resolve(process.cwd(), './tsconfig.json'),
        ecmaFeatures: {
          jsx: true,
        },
      },
    },
    plugins: {
      import: eslintPluginImport,
    },
    rules: {
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
