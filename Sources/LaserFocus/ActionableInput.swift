import Foundation
import BetterCodable

/// An actionable item to be prioritized at any level.
public struct ActionableInput: Codable, Identifiable {
  /// The identifier of the actionable item.
  public var id: String

  /// The category an actionable item is rated as.
  public var localCategory: Category

  /// The children of this actionable
  @DefaultEmptyArray
  public var children: [ActionableInput]

  /// Initializes an actionable item with given id, category and children.
  public init(id: String, localCategory: Category, children: [ActionableInput] = []) {
    self.id = id
    self.localCategory = localCategory
    self.children = children
  }
}

extension ActionableInput: Comparable {
  public static func < (lhs: ActionableInput, rhs: ActionableInput) -> Bool {
    lhs.localCategory < rhs.localCategory
  }
}
