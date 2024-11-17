import which from 'which'

export async function depCheck(dependencies: string[]) {
  const cmd = this
  for (const dep of dependencies) {
    try {
      await which(dep)
    } catch (e) {
      throw new Error(`"${dep}" is not installed. Please install it and try again.`)
    }
  }
}
