import XCTest
@testable import LaserFocus

final class CategoryTests: XCTestCase {
  func testComparable() throws {
    XCTAssertEqual(
      [Category.optional, .vital, .retracting, .essential, .optional, .completing].sorted(),
      [Category.vital, .essential, .completing, .optional, .optional, .retracting]
    )
  }
}
