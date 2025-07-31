import BetterCodable
import Foundation

/// An actionable item to be prioritized at any level.
public class ActionableInput: Codable {
   /// The name of the actionable item.
   public var name: String

   /// The category an actionable item is rated as.
   public var localCategory: Category

   /// The identifiers of this inputs ancestors.
   public var ancestorIds: [ActionableInput.ID]

   /// The children of this actionable
   @DefaultEmptyArray
   public var children: [ActionableInput]

   /// Initializes an actionable item with given id, category and children.
   public init(
      name: String,
      localCategory: Category,
      ancestorIds: [ActionableInput.ID] = [],
      children: [ActionableInput] = []
   ) {
      self.name = name
      self.localCategory = localCategory
      self.ancestorIds = ancestorIds
      self.children = children
   }
}

extension ActionableInput: Identifiable {
   public var id: String {
      name
   }
}

extension ActionableInput: Comparable {
   public static func == (lhs: ActionableInput, rhs: ActionableInput) -> Bool {
      lhs.localCategory == rhs.localCategory
   }

   public static func < (lhs: ActionableInput, rhs: ActionableInput) -> Bool {
      lhs.localCategory < rhs.localCategory
   }
}
