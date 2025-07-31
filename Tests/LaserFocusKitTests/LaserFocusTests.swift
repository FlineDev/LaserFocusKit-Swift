import XCTest

@testable import LaserFocusKit

final class LaserFocusTests: XCTestCase {
   func testPrioritizedAtoms() throws {
      let inputs: [ActionableInput] = [
         .init(
            name: "A",
            localCategory: .vital,
            children: [
               .init(
                  name: "A1",
                  localCategory: .vital,
                  ancestorIds: ["A"],
                  children: [
                     .init(name: "A1a", localCategory: .vital),
                     .init(name: "A1b", localCategory: .essential),
                     .init(name: "A1c", localCategory: .completing),
                     .init(name: "A1d", localCategory: .optional),
                     .init(name: "A1e", localCategory: .retracting),
                  ]
               ),
               .init(
                  name: "A2",
                  localCategory: .essential,
                  ancestorIds: ["A"],
                  children: [
                     .init(name: "A2a", localCategory: .vital),
                     .init(name: "A2b", localCategory: .essential),
                     .init(name: "A2c", localCategory: .completing),
                     .init(name: "A2d", localCategory: .optional),
                     .init(name: "A2e", localCategory: .retracting),
                  ]
               ),
               .init(
                  name: "A3",
                  localCategory: .completing,
                  ancestorIds: ["A"],
                  children: [
                     .init(name: "A3a", localCategory: .vital),
                     .init(name: "A3b", localCategory: .essential),
                     .init(name: "A3c", localCategory: .completing),
                     .init(name: "A3d", localCategory: .optional),
                     .init(name: "A3e", localCategory: .retracting),
                  ]
               ),
               .init(
                  name: "A4",
                  localCategory: .optional,
                  ancestorIds: ["A"],
                  children: [
                     .init(name: "A4a", localCategory: .vital),
                     .init(name: "A4b", localCategory: .essential),
                     .init(name: "A4c", localCategory: .completing),
                     .init(name: "A4d", localCategory: .optional),
                     .init(name: "A4e", localCategory: .retracting),
                  ]
               ),
               .init(
                  name: "A5",
                  localCategory: .retracting,
                  ancestorIds: ["A"],
                  children: [
                     .init(name: "A5a", localCategory: .vital),
                     .init(name: "A5b", localCategory: .essential),
                     .init(name: "A5c", localCategory: .completing),
                     .init(name: "A5d", localCategory: .optional),
                     .init(name: "A5e", localCategory: .retracting),
                  ]
               ),
            ]
         ),
         .init(
            name: "B",
            localCategory: .optional,
            children: [
               .init(
                  name: "B1",
                  localCategory: .vital,
                  ancestorIds: ["B"],
                  children: [
                     .init(name: "B1a", localCategory: .vital),
                     .init(name: "B1b", localCategory: .essential),
                     .init(name: "B1c", localCategory: .completing),
                     .init(name: "B1d", localCategory: .optional),
                     .init(name: "B1e", localCategory: .retracting),
                  ]
               ),
               .init(
                  name: "B2",
                  localCategory: .essential,
                  ancestorIds: ["B"],
                  children: [
                     .init(
                        name: "B2a",
                        localCategory: .vital,
                        ancestorIds: ["B", "B2"],
                        children: [
                           .init(name: "B2a1", localCategory: .completing)
                        ]
                     )
                  ]
               ),
            ]
         ),
         .init(name: "C", localCategory: .completing),
      ]

      let outputs = LaserFocus.prioritizedAtoms(inputs: inputs)
      XCTAssertEqual(outputs.count, 32)
      XCTAssertEqual(
         outputs.map(\.name),
         [
            "A1a", "A1b", "A1c", "A1d", "A1e",
            "A2a", "A2b", "A2c", "A2d", "A2e",
            "A3a", "A3b", "A3c", "A3d", "A3e",
            "A4a", "A4b", "A4c", "A4d", "A4e",
            "A5a", "A5b", "A5c", "A5d", "A5e",
            "B1a", "B1b", "B1c", "B1d", "B1e",
            "B2a1", "C",
         ]
      )
      XCTAssertEqual(
         outputs.map(\.globalCategory),
         [
            .vital, .essential, .completing, .optional, .retracting,
            .essential, .essential, .completing, .optional, .retracting,
            .completing, .completing, .completing, .optional, .retracting,
            .optional, .optional, .optional, .optional, .retracting,
            .retracting, .retracting, .retracting, .retracting, .retracting,
            .optional, .optional, .optional, .optional, .retracting,
            .optional, .completing,
         ]
      )
      XCTAssertEqual(outputs.first { $0.name == "A1a" }!.averageCategoryRawValue, 1, accuracy: 0.001)
      XCTAssertEqual(outputs.first { $0.name == "A3c" }!.averageCategoryRawValue, 2.333, accuracy: 0.001)
      XCTAssertEqual(outputs.first { $0.name == "A5e" }!.averageCategoryRawValue, 3.666, accuracy: 0.001)
      XCTAssertEqual(outputs.first { $0.name == "A2b" }!.averageCategoryRawValue, 1.666, accuracy: 0.001)
      XCTAssertEqual(outputs.first { $0.name == "A4d" }!.averageCategoryRawValue, 3, accuracy: 0.001)
      XCTAssertEqual(outputs.first { $0.name == "B1c" }!.averageCategoryRawValue, 2.666, accuracy: 0.001)
      XCTAssertEqual(outputs.first { $0.name == "B2a1" }!.averageCategoryRawValue, 2.5, accuracy: 0.001)
      XCTAssertEqual(outputs.first { $0.name == "C" }!.averageCategoryRawValue, 3, accuracy: 0.001)
   }

   func testReadmeExample() {
      let inputs: [ActionableInput] = [
         .init(
            name: "A",
            localCategory: .vital,
            children: [
               .init(
                  name: "A1",
                  localCategory: .vital,
                  children: [
                     .init(name: "A1x", localCategory: .vital),
                     .init(name: "A1y", localCategory: .essential),
                     .init(name: "A1z", localCategory: .completing),
                  ]
               ),
               .init(name: "A2", localCategory: .essential),
               .init(
                  name: "A3",
                  localCategory: .completing,
                  children: [
                     .init(name: "A3x", localCategory: .vital),
                     .init(name: "A3y", localCategory: .essential),
                     .init(name: "A3z", localCategory: .completing),
                  ]
               ),
            ]
         ),
         .init(
            name: "B",
            localCategory: .optional,
            children: [
               .init(name: "B1", localCategory: .vital),
               .init(
                  name: "B2",
                  localCategory: .essential,
                  children: [
                     .init(name: "B2x", localCategory: .vital),
                     .init(name: "B2y", localCategory: .retracting),
                     .init(name: "B2z", localCategory: .completing),
                  ]
               ),
            ]
         ),
         .init(name: "C", localCategory: .completing),
      ]

      let sortedOutputs: [ActionableOutput] = LaserFocus.prioritizedAtoms(inputs: inputs).sorted()
      XCTAssertEqual(
         sortedOutputs.map(\.name),
         ["A1x", "A1y", "A2", "A1z", "A3x", "A3y", "A3z", "C", "B2x", "B1", "B2z", "B2y"]
      )
   }
}
