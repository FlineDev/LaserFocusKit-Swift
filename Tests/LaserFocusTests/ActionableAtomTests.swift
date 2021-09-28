import XCTest
@testable import LaserFocus

final class ActionableAtomTests: XCTestCase {
  func testInitAndComparable() throws {
    let unsortedActionableAtoms = [
      ActionableOutput(
        input: ActionableInput(id: "A", localCategory: .completing, children: []),
        ancestors: [
          ActionableInput(id: "A1", localCategory: .essential, children: []),
          ActionableInput(id: "A2", localCategory: .vital, children: []),
          ActionableInput(id: "A3", localCategory: .optional, children: []),
        ]
      ),
      ActionableOutput(
        input: ActionableInput(id: "B", localCategory: .essential, children: []),
        ancestors: [
          ActionableInput(id: "B1", localCategory: .vital, children: []),
          ActionableInput(id: "B2", localCategory: .vital, children: []),
        ]
      ),
      ActionableOutput(
        input: ActionableInput(id: "C", localCategory: .essential, children: []),
        ancestors: [
          ActionableInput(id: "C1", localCategory: .optional, children: []),
          ActionableInput(id: "C2", localCategory: .optional, children: []),
          ActionableInput(id: "C3", localCategory: .completing, children: []),
          ActionableInput(id: "C4", localCategory: .completing, children: []),
        ]
      ),
      ActionableOutput(
        input: ActionableInput(id: "D", localCategory: .vital, children: []),
        ancestors: [
          ActionableInput(id: "D1", localCategory: .optional, children: []),
          ActionableInput(id: "D2", localCategory: .optional, children: []),
          ActionableInput(id: "D3", localCategory: .essential, children: []),
        ]
      ),
      ActionableOutput(
        input: ActionableInput(id: "E", localCategory: .completing, children: []),
        ancestors: [
          ActionableInput(id: "F1", localCategory: .vital, children: []),
        ]
      ),
      ActionableOutput(
        input: ActionableInput(id: "F", localCategory: .essential, children: []),
        ancestors: [
          ActionableInput(id: "F1", localCategory: .vital, children: []),
          ActionableInput(id: "F3", localCategory: .completing, children: []),
        ]
      ),
      ActionableOutput(
        input: ActionableInput(id: "G", localCategory: .vital, children: []),
        ancestors: []
      ),
    ]

    XCTAssertEqual(
      unsortedActionableAtoms.map(\.globalCategory),
      [.optional, .essential, .optional, .optional, .completing, .completing, .vital]
    )
    XCTAssertEqual(
      unsortedActionableAtoms.map(\.averageCategoryRawValue).map { $0.rounded(fractionDigits: 2) },
      [2.50, 1.33, 3.20, 2.75, 2.0, 2.0, 1.0]
    )
    XCTAssertEqual(unsortedActionableAtoms.sorted(stable: true).map(\.id), ["G", "B", "E", "F", "A", "D", "C"])
  }
}
