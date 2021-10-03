import XCTest
@testable import LaserFocusKit

final class ActionableInputTests: XCTestCase {
  func testComparable() throws {
    let unsortedActionables = [
      ActionableInput(name: "A", localCategory: .completing, children: []),
      ActionableInput(name: "B", localCategory: .vital, children: []),
      ActionableInput(name: "C", localCategory: .essential, children: []),
      ActionableInput(name: "D", localCategory: .retracting, children: []),
      ActionableInput(name: "E", localCategory: .essential, children: []),
    ]

    XCTAssertEqual(unsortedActionables.sorted(stable: true).map(\.name), ["B", "C", "E", "A", "D"])
  }
}
