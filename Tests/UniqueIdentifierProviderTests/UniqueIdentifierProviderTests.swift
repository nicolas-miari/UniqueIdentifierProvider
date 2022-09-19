import XCTest
@testable import UniqueIdentifierProvider

final class UniqueIdentifierProviderTests: XCTestCase {

  func testUniqueness() throws {

    let provider = UniqueIdentifierProviderFactory.newIdentifierProvider()

    let id1 = try provider.newIdentifier()
    let id2 = try provider.newIdentifier()

    XCTAssertNotEqual(id1, id2)
  }

  func testUncheckedUniqueness() throws {

    let provider = UniqueIdentifierProviderFactory.newIdentifierProvider()

    let id1 = provider.newUncheckedIdentifier()
    let id2 = provider.newUncheckedIdentifier()

    XCTAssertNotEqual(id1, id2)
  }
}
