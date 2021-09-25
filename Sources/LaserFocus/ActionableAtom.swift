import Foundation
import HandySwift

/// The leaf element in a graph of actionables with parts, or the "lowest level" of actionables without any parts.
/// For prioritization, use the `overallCategory` level first and `averageCategoryRawValue` second if `overallCategory` level is same.
public struct ActionableAtom: Codable, Identifiable {
  /// The identifier of the actionable item.
  public let id: String

  /// The enclosing actionables this atomic actionable is part of.
  public let enclosingPath: [Actionable]

  /// The derived overall category level for this atomic (leaf) actionable element, considering all enclosing actionables this is part of.
  public let overallCategory: Category

  /// The average raw value of all enclosing actionables categories for more precise prioritization within a category level.
  public let averageCategoryRawValue: Double

  /// Initializes an atomic actionable item and calculates priority relevant fields automatically.
  public init(actionable: Actionable, enclosingPath: [Actionable]) {
    self.id = actionable.id
    self.enclosingPath = enclosingPath

    self.overallCategory = (enclosingPath.map(\.category) + [actionable.category]).max()!
    self.averageCategoryRawValue = (enclosingPath.map(\.category).map(\.rawValue) + [actionable.category.rawValue]).average()
  }
}

extension ActionableAtom: Comparable {
  public static func < (lhs: ActionableAtom, rhs: ActionableAtom) -> Bool {
    guard lhs.overallCategory != rhs.overallCategory else {
      return lhs.averageCategoryRawValue < rhs.averageCategoryRawValue
    }

    return lhs.overallCategory < rhs.overallCategory
  }
}
