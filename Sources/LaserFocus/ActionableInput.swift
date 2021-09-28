import Foundation
import BetterCodable

/// An actionable item to be prioritized at any level.
public struct ActionableInput: Codable, Identifiable {
  /// The identifier of the actionable item.
  public let id: String

  /// The category an actionable item is rated as.
  public let localCategory: Category

  /// The children of this actionable
  @DefaultEmptyArray
  public var children: [ActionableInput]
}

extension ActionableInput: Comparable {
  public static func < (lhs: ActionableInput, rhs: ActionableInput) -> Bool {
    lhs.localCategory < rhs.localCategory
  }
}
