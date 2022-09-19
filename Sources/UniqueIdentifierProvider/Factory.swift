import Foundation

public final class UniqueIdentifierProviderFactory {

  public static func newIdentifierProvider() -> some UniqueIdentifierProvider {
    return UniqueIdentifierProviderImplementation()
  }

  public static func loadIdentifierProvider(from file: FileWrapper) throws -> some UniqueIdentifierProvider {
    guard let data = file.regularFileContents else {
      throw UniqueIdentifierProviderError.missingInputData
    }
    let provider = try JSONDecoder().decode(UniqueIdentifierProviderImplementation.self, from: data)
    return provider
  }
}
