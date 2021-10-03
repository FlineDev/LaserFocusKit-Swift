<img width="1164" alt="Laser Focus Header" src="https://user-images.githubusercontent.com/6942160/135471993-bc65430a-dd45-4810-9139-f59cdab56c4b.png">

# LaserFocusKit-Swift
Utility library for calculations when applying the [Laser Focus](https://dev.to/jeehut/laser-focus-priority-strategy-31ok) priority strategy.

## Usage

<img width="1000" alt="VECTOR" src="https://user-images.githubusercontent.com/6942160/135472228-a5a98734-6e17-4e2d-bb09-43414d76c5ee.png">

This library calculates the overall priority for a given graph of categorized actionable items, such as features or tasks. It supports any number of actionable item levels, e.g. you can provide an entire range of levels like "Epic", "Story", "Feature", "Task", "Sub-Task", "Step" as input. The main method takes just the top level ("Epic" in this case) and walks through the other children levels automatically.

For example, imagine you have the features "A", "B", and "C". Some of them have 3 tasks "1", "2", and "3". And some of the tasks have subtasks, "x", "y", and "z". So the input is this top level array with its children:

```swift
let inputs: [ActionableInput] = [
  .init(name: "A", localCategory: .vital, children: [
    .init(name: "A1", localCategory: .vital, children: [
      .init(name: "A1x", localCategory: .vital),
      .init(name: "A1y", localCategory: .essential),
      .init(name: "A1z", localCategory: .completing)]
    ),
    .init(name: "A2", localCategory: .essential),
    .init(name: "A3", localCategory: .completing, children: [
      .init(name: "A3x", localCategory: .vital),
      .init(name: "A3y", localCategory: .essential),
      .init(name: "A3z", localCategory: .completing)]
    )]
  ),
  .init(name: "B", localCategory: .optional, children: [
    .init(name: "B1", localCategory: .vital),
    .init(name: "B2", localCategory: .essential, children: [
      .init(name: "B2x", localCategory: .vital),
      .init(name: "B2y", localCategory: .retracting),
      .init(name: "B2z", localCategory: .completing)]
    )]
  ),
  .init(name: "C", localCategory: .completing)
]
```

What we want to know in the Laser Focus strategy, is the global category for each "leaf" element in the graph, or the elements without children, the "atomic" elements, so to say. These elements are not further split(table) and can directly be worked on. Just calling the `LaserFocus.prioritizedAtoms(inputs:)` gives us exactly these elements:

```swift
let outputs: [ActionableOutput] = LaserFocus.prioritizedAtoms(inputs: inputs)

```

Each element in `ActionableOutput` has a `globalCategory` which includes the overall category of the atomic actionable, which serves as the primary prioritization point. Additionally, each `ActionableOutput` also has an `averageCategoryRawValue` numeric property which can be used to prioritize tasks with the same `globalCategory` for improved precision.

The simplest way to get the list of tasks in the correct priority order is to just call `sorted()` on the outputs as `ActionableOutput` is `Comparable`:

```swift
let sortedOutputs: [ActionableOutput] = outputs.sorted()

print(sortedOutputs.map(\.name)) // => ["A1x", "A1y", "A2", "A1z", "A3x", "A3y", "A3z", "C", "B2x", "B1", "B2z", "B2y"]
```

Note that both the input `ActionableInput` and output type `ActionableOutput` are `Codable` and can therefore be easily read from & written to JSON.
