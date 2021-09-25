import Foundation
import BetterCodable

/// An actionable item to be prioritized at any level.
public struct Actionable: Codable, Identifiable {
  /// The identifier of the actionable item.
  public let id: String

  /// The category an actionable item is rated as.
  public let category: Category

  /// The children of this actionable
  @DefaultEmptyArray
  public var parts: [Actionable]
}

extension Actionable: Comparable {
  public static func < (lhs: Actionable, rhs: Actionable) -> Bool {
    lhs.category < rhs.category
  }
}
