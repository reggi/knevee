import {executablePassthrough} from '../../src/index.ts'

export const command = executablePassthrough({
  filename: import.meta.filename,
  name: 'pig-latin',
  description: 'Converts the name to pig latin',
  output: 'log',
  positionals: '<sentence...>',
  default: (...sentence) => {
    sentence.pop()
    return sentence
      .map(word => {
        // Check if the first character is a vowel
        if (/[aeiou]/i.test(word[0])) {
          return word + 'ay'
        } else {
          // Find the first vowel position
          const firstVowelIndex = word.search(/[aeiou]/i)
          return word.substring(firstVowelIndex) + word.substring(0, firstVowelIndex) + 'ay'
        }
      })
      .join(' ')
  },
})
