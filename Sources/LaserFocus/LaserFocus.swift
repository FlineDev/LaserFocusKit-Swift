import Foundation

public enum LaserFocus {
  /// Returns the actionable items without children (= atoms) with calculated global category as primary & average category raw value as secondary priority.
  static func prioritizedAtoms(inputs: [ActionableInput], ancestors: [ActionableInput] = []) -> [ActionableOutput] {
    var outputs: [ActionableOutput] = []

    for input in inputs {
      if input.children.isEmpty {
        outputs.append(.init(input: input, ancestors: ancestors))
      } else {
        outputs.append(
          contentsOf: LaserFocus.prioritizedAtoms(inputs: input.children, ancestors: ancestors + [input])
        )
      }
    }

    return outputs
  }
}
