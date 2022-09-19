import Foundation

public final class UniqueIdentifierProviderImplementation: UniqueIdentifierProvider {

  private var database: [String] = []

  private var failSafeLimit = 10_000

  /// Creates a new identifier.
  public func newIdentifier() throws -> String {

    // Fail-safe to break out of the (highly unlikely, but) potentially infinite while loop in case
    // an external bug prevents it from exiting.
    var failSafeCounter = 0

    while(true) {
      let new = UUID().uuidString

      if !database.contains(new) {
        // This should happen almost all the time
        database.append(new)
        return new
      }

      // This should happen once in the life of the universe. Rare enough that it's not worth
      // throwing an actual error.
      failSafeCounter += 1
      if failSafeCounter > failSafeLimit {
        throw UniqueIdentifierProviderError.internalError
      }
    }
  }

  public func newUncheckedIdentifier() -> String {
    let new = UUID().uuidString
    database.append(new)
    return new
  }

  internal func loadContents(from file: FileWrapper) throws {
    guard let data = file.regularFileContents else {
      return
    }
    self.database = try JSONDecoder().decode([String].self, from: data)
  }

  public func fileWrapper() -> FileWrapper {
    let data = try? JSONEncoder().encode(database)
    return FileWrapper(regularFileWithContents: data ?? Data())
  }
}
