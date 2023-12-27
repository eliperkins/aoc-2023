import AdventOfCodeKit
import Algorithms

public struct Day12 {
    public static let sample = """
        ???.### 1,1,3
        .??..??...?##. 1,1,3
        ?#?#?#?#?#?#?#? 1,3,1,6
        ????.#...#... 4,1,1
        ????.######..#####. 1,6,5
        ?###???????? 3,2,1
        """

    public let input: String

    public init(
        input: String? = nil
    ) {
        if let input {
            self.input = input
        } else if let input = try? Input.day(12) {
            self.input = input
        } else {
            self.input = Self.sample
        }
    }

    public enum OperationState: Character, Hashable {
        case operational = "."
        case damaged = "#"
        case unknown = "?"
    }

    final class Cache {
        struct Key: Hashable {
            let records: [OperationState]
            let groupings: [Int]
        }

        private var storage: [Key: Int] = [:]

        subscript(key: Key) -> Int? {
            get {
                storage[key]
            }
            set {
                storage[key] = newValue
            }
        }

        func memoize(key: Key, _ block: () -> Int) -> Int {
            if let cached = self[key] {
                return cached
            }
            let value = block()
            self[key] = value
            return value
        }
    }

    private let cache = Cache()

    func possibilities(
        records: [OperationState],
        matching groupings: [Int]
    ) -> Int {
        if records.isEmpty {
            // recursion matched
            if groupings.isEmpty {
                return 1
            }

            // still have groups to match
            return 0
        }

        if groupings.isEmpty {
            // still have springs to count
            if records.contains(.damaged) {
                return 0
            }

            // only trailing zeros
            return 1
        }

        let cacheKey = Cache.Key(records: records, groupings: groupings)
        return cache.memoize(key: cacheKey) {
            var result = 0
            if let firstRecord = records.first, let firstGroupSize = groupings.first {
                if firstGroupSize > records.count {
                    // not enough records to match
                    return 0
                }

                if firstRecord != .damaged {
                    // convert unknown to operational
                    result += possibilities(records: Array(records.dropFirst()), matching: groupings)
                }

                // convert unknown to damaged
                if firstRecord == .unknown || firstRecord == .damaged {
                    let group = records[..<firstGroupSize]
                    let nextOutsideOfGroupIsDamaged = records[firstGroupSize...].first == .damaged
                    if !group.contains(.operational) && !nextOutsideOfGroupIsDamaged {
                        result += possibilities(
                            records: Array(records.dropFirst(firstGroupSize + 1)),
                            matching: Array(groupings.dropFirst())
                        )
                    }
                }
            }

            return result
        }
    }

    public func solvePart1() throws -> Int {
        input.lines.compactMap { line -> ([OperationState], [Int])? in
            let parts = line.split(separator: " ")
            guard let records = parts.first?.compactMap(OperationState.init),
                let groupings = parts.last?.split(separator: ",").compactMap({ Int(String($0)) })
            else {
                return nil
            }

            return (records, groupings)
        }
        .map { records, groupings in
            possibilities(records: records, matching: groupings)
        }
        .sum()
    }

    public func solvePart2() throws -> Int {
        input.lines.compactMap { line -> ([OperationState], [Int])? in
            let parts = line.split(separator: " ")
            guard let records = parts.first?.compactMap(OperationState.init),
                let groupings = parts.last?.split(separator: ",").compactMap({ Int(String($0)) })
            else {
                return nil
            }

            return (
                Array(Array(repeating: records, count: 5).joined(by: .unknown)),
                Array(Array(repeating: groupings, count: 5).joined())
            )
        }
        .map { records, groupings in
            possibilities(records: records, matching: groupings)
        }
        .sum()
    }
}
