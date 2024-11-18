export class UserError extends Error {
  error: Error
  constructor(error: Error) {
    super(error.message)
    this.error = error
  }
}
