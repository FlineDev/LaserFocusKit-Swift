import Foundation
import HandySwift

/// The prioritized actionable item.
/// For prioritization, use the `globalCategory` level first and `averageCategoryRawValue` second if `globalCategory` level is same.
public struct ActionableOutput: Codable, Identifiable {
  /// The identifier of the actionable item.
  public let id: String

  /// The enclosing actionables IDs this atomic actionable is part of.
  public let ancestorIds: [ActionableInput.ID]

  /// The derived overall category level for this atomic (leaf) actionable element, considering all enclosing actionables this is part of.
  public let globalCategory: Category

  /// The average raw value of all enclosing actionables categories for more precise prioritization within a category level.
  public let averageCategoryRawValue: Double

  /// Initializes an atomic actionable item and calculates priority relevant fields automatically.
  public init(input: ActionableInput, ancestors: [ActionableInput]) {
    self.id = input.id
    self.ancestorIds = ancestors.map(\.id)

    self.globalCategory = (ancestors.map(\.localCategory) + [input.localCategory]).max()!
    self.averageCategoryRawValue = (ancestors.map(\.localCategory).map(\.rawValue) + [input.localCategory.rawValue]).average()
  }
}

extension ActionableOutput: Comparable {
  public static func < (lhs: ActionableOutput, rhs: ActionableOutput) -> Bool {
    guard lhs.globalCategory != rhs.globalCategory else {
      return lhs.averageCategoryRawValue < rhs.averageCategoryRawValue
    }

    return lhs.globalCategory < rhs.globalCategory
  }
}
