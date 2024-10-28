const name = 'greeting'
const description = 'Say hello to someone'
const dependencies = ['echo']
const output = 'bash'
const positionals = '<name>'

const greet = name => {
  return `echo "Welcome ${name}"`
}

module.exports = {
  name,
  description,
  dependencies,
  output,
  positionals,
  default: greet,
}
