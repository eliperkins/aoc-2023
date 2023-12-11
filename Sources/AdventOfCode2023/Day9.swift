import AdventOfCodeKit

public struct Day9 {
    public static let sample = """
        0 3 6 9 12 15
        1 3 6 10 15 21
        10 13 16 21 30 45
        """

    public let input: String

    public init(
        input: String? = nil
    ) {
        if let input {
            self.input = input
        } else if let input = try? Input.day(9) {
            self.input = input
        } else {
            self.input = Self.sample
        }
    }

    @inlinable
    public func differenceSequence(base: [Int]) -> [Int] {
        zip(base, base.dropFirst()).map { $1 - $0 }
    }

    @inlinable
    public func next(in sequence: [Int]) -> Int {
        let differences = differenceSequence(base: sequence)
        if differences.allSatisfy({ $0 == 0 }) {
            return sequence.last!
        }
        return sequence.last! + next(in: differences)
    }

    @inlinable
    public func previous(in sequence: [Int]) -> Int {
        let differences = differenceSequence(base: sequence)
        if differences.allSatisfy({ $0 == 0 }) {
            return sequence.first!
        }
        return sequence.first! - previous(in: differences)
    }

    public func solvePart1() throws -> Int {
        input.lines.map { line in
            let sequence = line.split(separator: " ").map { Int($0)! }
            return next(in: sequence)
        }
        .sum()
    }

    public func solvePart2() throws -> Int {
        input.lines.map { line in
            let sequence = line.split(separator: " ").map { Int($0)! }
            return previous(in: sequence)
        }
        .sum()
    }
}
