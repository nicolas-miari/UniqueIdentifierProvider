import XCTest
import UniqueIdentifierProvider

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

  func testArchiveUnarchivePreservesContents() throws {
    // GIVEN
    let provider = UniqueIdentifierProviderFactory.newIdentifierProvider()
    let id1 = provider.newUncheckedIdentifier()
    let id2 = provider.newUncheckedIdentifier()

    // WHEN
    let fileWrapper = try provider.fileWrapper()
    let recovered = try UniqueIdentifierProviderFactory.loadIdentifierProvider(from: fileWrapper)

    // THEN
    XCTAssertTrue(recovered.contains(id1))
    XCTAssertTrue(recovered.contains(id2))
  }

  func testLoadFromEmptyFileFails () throws {
    let file = FileWrapper()

    XCTAssertThrowsError(try UniqueIdentifierProviderFactory.loadIdentifierProvider(from: file))
  }
}
