import {knevee} from '../../src/index.ts'
import {greeting} from './greeting.ts'

const [helloWorld] = knevee({
  filename: import.meta.filename,
  name: 'hello-world',
  description: 'This is a test',
  dependencies: ['echo'],
  output: 'bash',
  default: () => {
    return greeting('world')
  },
})

export default helloWorld
