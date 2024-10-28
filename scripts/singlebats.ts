import {executablePassthrough} from '../src/index.ts'

export const handle = name => {
  return [`npm run build:bats`, `rm -rf ./snapshots/${name}`, `./test/bats/bin/bats test/batgen/${name}.bats`]
}

export const command = executablePassthrough({
  filename: import.meta.filename,
  name: 'singlebats',
  description: 'Runs a single bats test',
  stdin: true,
  output: 'bash',
  positionals: '<test-suite>',
  default: handle,
})
