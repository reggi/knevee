const name = 'greeting'
const description = 'Say hello to someone'
const dependencies = ['echo']
const output = 'bash'
const positionals = '<name>'

export default function (name: string) {
  return `echo "Welcome ${name}"`
}

export {
  name,
  description,
  dependencies,
  output,
  positionals
}