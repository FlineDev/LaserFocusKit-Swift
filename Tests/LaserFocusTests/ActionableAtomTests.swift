import XCTest
@testable import LaserFocus

final class ActionableAtomTests: XCTestCase {
  func testInitAndComparable() throws {
    let unsortedActionableAtoms = [
      ActionableAtom(
        actionable: Actionable(id: "A", category: .completing, parts: []),
        enclosingPath: [
          Actionable(id: "A1", category: .essential, parts: []),
          Actionable(id: "A2", category: .vital, parts: []),
          Actionable(id: "A3", category: .optional, parts: []),
        ]
      ),
      ActionableAtom(
        actionable: Actionable(id: "B", category: .essential, parts: []),
        enclosingPath: [
          Actionable(id: "B1", category: .vital, parts: []),
          Actionable(id: "B2", category: .vital, parts: []),
        ]
      ),
      ActionableAtom(
        actionable: Actionable(id: "C", category: .essential, parts: []),
        enclosingPath: [
          Actionable(id: "C1", category: .optional, parts: []),
          Actionable(id: "C2", category: .optional, parts: []),
          Actionable(id: "C3", category: .completing, parts: []),
          Actionable(id: "C4", category: .completing, parts: []),
        ]
      ),
      ActionableAtom(
        actionable: Actionable(id: "D", category: .vital, parts: []),
        enclosingPath: [
          Actionable(id: "D1", category: .optional, parts: []),
          Actionable(id: "D2", category: .optional, parts: []),
          Actionable(id: "D3", category: .essential, parts: []),
        ]
      ),
      ActionableAtom(
        actionable: Actionable(id: "E", category: .completing, parts: []),
        enclosingPath: [
          Actionable(id: "F1", category: .vital, parts: []),
        ]
      ),
      ActionableAtom(
        actionable: Actionable(id: "F", category: .essential, parts: []),
        enclosingPath: [
          Actionable(id: "F1", category: .vital, parts: []),
          Actionable(id: "F3", category: .completing, parts: []),
        ]
      ),
      ActionableAtom(
        actionable: Actionable(id: "G", category: .vital, parts: []),
        enclosingPath: []
      ),
    ]

    XCTAssertEqual(
      unsortedActionableAtoms.map(\.overallCategory),
      [.optional, .essential, .optional, .optional, .completing, .completing, .vital]
    )
    XCTAssertEqual(
      unsortedActionableAtoms.map(\.averageCategoryRawValue).map { $0.rounded(fractionDigits: 2) },
      [2.50, 1.33, 3.20, 2.75, 2.0, 2.0, 1.0]
    )
    XCTAssertEqual(unsortedActionableAtoms.sorted(stable: true).map(\.id), ["G", "B", "E", "F", "A", "D", "C"])
  }
}
