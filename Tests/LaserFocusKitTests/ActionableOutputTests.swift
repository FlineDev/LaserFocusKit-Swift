import XCTest

@testable import LaserFocusKit

final class ActionableOutputTests: XCTestCase {
   func testInitAndComparable() throws {
      let unsortedActionableOutputs = [
         ActionableOutput(
            input: ActionableInput(name: "A", localCategory: .completing, children: []),
            ancestors: [
               ActionableInput(name: "A1", localCategory: .essential, children: []),
               ActionableInput(name: "A2", localCategory: .vital, children: []),
               ActionableInput(name: "A3", localCategory: .optional, children: []),
            ]
         ),
         ActionableOutput(
            input: ActionableInput(name: "B", localCategory: .essential, children: []),
            ancestors: [
               ActionableInput(name: "B1", localCategory: .vital, children: []),
               ActionableInput(name: "B2", localCategory: .vital, children: []),
            ]
         ),
         ActionableOutput(
            input: ActionableInput(name: "C", localCategory: .essential, children: []),
            ancestors: [
               ActionableInput(name: "C1", localCategory: .optional, children: []),
               ActionableInput(name: "C2", localCategory: .optional, children: []),
               ActionableInput(name: "C3", localCategory: .completing, children: []),
               ActionableInput(name: "C4", localCategory: .completing, children: []),
            ]
         ),
         ActionableOutput(
            input: ActionableInput(name: "D", localCategory: .vital, children: []),
            ancestors: [
               ActionableInput(name: "D1", localCategory: .optional, children: []),
               ActionableInput(name: "D2", localCategory: .optional, children: []),
               ActionableInput(name: "D3", localCategory: .essential, children: []),
            ]
         ),
         ActionableOutput(
            input: ActionableInput(name: "E", localCategory: .completing, children: []),
            ancestors: [
               ActionableInput(name: "F1", localCategory: .vital, children: [])
            ]
         ),
         ActionableOutput(
            input: ActionableInput(name: "F", localCategory: .essential, children: []),
            ancestors: [
               ActionableInput(name: "F1", localCategory: .vital, children: []),
               ActionableInput(name: "F3", localCategory: .completing, children: []),
            ]
         ),
         ActionableOutput(
            input: ActionableInput(name: "G", localCategory: .vital, children: []),
            ancestors: []
         ),
      ]

      XCTAssertEqual(
         unsortedActionableOutputs.map(\.globalCategory),
         [.optional, .essential, .optional, .optional, .completing, .completing, .vital]
      )
      XCTAssertEqual(
         unsortedActionableOutputs.map(\.averageCategoryRawValue).map { $0.rounded(fractionDigits: 2) },
         [2.50, 1.33, 3.20, 2.75, 2.0, 2.0, 1.0]
      )
      XCTAssertEqual(unsortedActionableOutputs.sorted(stable: true).map(\.name), ["G", "B", "E", "F", "A", "D", "C"])
   }
}
