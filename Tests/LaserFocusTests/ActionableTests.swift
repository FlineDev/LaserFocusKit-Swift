import XCTest
@testable import LaserFocus

final class ActionableTests: XCTestCase {
  func testComparable() throws {
    let unsortedActionables = [
      Actionable(id: "A", category: .completing, parts: []),
      Actionable(id: "B", category: .vital, parts: []),
      Actionable(id: "C", category: .essential, parts: []),
      Actionable(id: "D", category: .retracting, parts: []),
      Actionable(id: "E", category: .essential, parts: []),
    ]

    XCTAssertEqual(unsortedActionables.sorted(stable: true).map(\.id), ["B", "C", "E", "A", "D"])
  }
}
