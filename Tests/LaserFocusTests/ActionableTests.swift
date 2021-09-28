import XCTest
@testable import LaserFocus

final class ActionableTests: XCTestCase {
  func testComparable() throws {
    let unsortedActionables = [
      ActionableInput(id: "A", localCategory: .completing, children: []),
      ActionableInput(id: "B", localCategory: .vital, children: []),
      ActionableInput(id: "C", localCategory: .essential, children: []),
      ActionableInput(id: "D", localCategory: .retracting, children: []),
      ActionableInput(id: "E", localCategory: .essential, children: []),
    ]

    XCTAssertEqual(unsortedActionables.sorted(stable: true).map(\.id), ["B", "C", "E", "A", "D"])
  }
}
