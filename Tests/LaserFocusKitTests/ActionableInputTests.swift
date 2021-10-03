import XCTest
@testable import LaserFocusKit

final class ActionableInputTests: XCTestCase {
  func testComparable() throws {
    let unsortedActionables = [
      ActionableInput(name: "A", localCategory: .completing),
      ActionableInput(name: "B", localCategory: .vital),
      ActionableInput(name: "C", localCategory: .essential),
      ActionableInput(name: "D", localCategory: .retracting),
      ActionableInput(name: "E", localCategory: .essential),
    ]

    XCTAssertEqual(unsortedActionables.sorted(stable: true).map(\.name), ["B", "C", "E", "A", "D"])
  }
}
