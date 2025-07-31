import Foundation

/// The categories any actionable item can be rated by.
public enum Category: Int, Codable, CaseIterable {
   /// Absolute minimum needed for first round of testing. Can be ugly.
   case vital = 1

   /// Core aspects required for basic functionality. Can have rough edges.
   case essential = 2

   /// Ironing out rough-edges and completing aspects of functionality.
   case completing = 3

   /// Nice-to-haves that can be delayed to later (versions) or skipped entirely.
   case optional = 4

   /// Nice-to-haves (on first sight) that can (potentially) cause more harm than improve things.
   case retracting = 5
}

extension Category: Identifiable {
   public var id: Int {
      rawValue
   }
}

extension Category: Comparable {
   public static func < (lhs: Category, rhs: Category) -> Bool {
      lhs.rawValue < rhs.rawValue
   }
}
