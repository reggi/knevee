const {executablePassthrough} = require('../../dist/index.cjs')

exports.command = executablePassthrough({
  filename: __filename,
  name: 'greeting',
  description: 'Say hello to someone',
  dependencies: ['echo'],
  output: 'bash',
  positionals: '<name>',
  default: name => {
    return `echo "Welcome ${name}"`
  },
})
