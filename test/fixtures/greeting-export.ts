export const name = 'greeting'
export const description = 'Say hello to someone'
export const dependencies = ['echo']
export const output = 'bash'
export const positionals = '<name>'
export default (name: string) => {
  return `echo "Welcome ${name}"`
}
