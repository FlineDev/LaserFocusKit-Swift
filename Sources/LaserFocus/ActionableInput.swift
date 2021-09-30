import Foundation
import BetterCodable

/// An actionable item to be prioritized at any level.
public struct ActionableInput: Codable {
  /// The name of the actionable item.
  public var name: String

  /// The category an actionable item is rated as.
  public var localCategory: Category

  /// The children of this actionable
  @DefaultEmptyArray
  public var children: [ActionableInput]

  /// Initializes an actionable item with given id, category and children.
  public init(name: String, localCategory: Category, children: [ActionableInput] = []) {
    self.name = name
    self.localCategory = localCategory
    self.children = children
  }
}

extension ActionableInput: Identifiable {
  public var id: String {
    name
  }
}

extension ActionableInput: Comparable {
  public static func < (lhs: ActionableInput, rhs: ActionableInput) -> Bool {
    lhs.localCategory < rhs.localCategory
  }
}
