import AdventOfCodeKit
import Algorithms

public struct Day11 {
    public static let sample = """
        ...#......
        .......#..
        #.........
        ..........
        ......#...
        .#........
        .........#
        ..........
        .......#..
        #...#.....
        """

    public let input: String

    public init(
        input: String? = nil
    ) {
        if let input {
            self.input = input
        } else if let input = try? Input.day(11) {
            self.input = input
        } else {
            self.input = Self.sample
        }
    }

    func expanding(by size: Int) throws -> Matrix<Character> {
        let map = Matrix(string: input)
        let blankRows = map.rows
            .enumerated()
            .filter({ $0.element.allSatisfy { $0 == "." } })
            .map(\.offset)
        let blankColumns = map.columns
            .enumerated()
            .filter({ $0.element.allSatisfy { $0 == "." } })
            .map(\.offset)
        let blankRowSentinel = [Character](repeating: ".", count: map.columns.count + blankColumns.count)
        return Matrix(
            map.rows.enumerated().flatMap { (yOffset, row) -> [[Character]] in
                if blankRows.contains(yOffset) {
                    return Array(repeating: blankRowSentinel, count: size)
                }

                let xs = row.enumerated().flatMap { (xOffset, character) -> [Character] in
                    if blankColumns.contains(xOffset) {
                        return Array(repeating: character, count: size)
                    }
                    return [character]
                }

                return [xs]
            }
        )

    }

    public func solvePart1() throws -> Int {
        try sumOfShortestLengths(expandingBy: 2)
    }

    public func sumOfShortestLengths(expandingBy multiplier: Int) throws -> Int {
        let map = Matrix(string: input)
        let blankRows = map.rows
            .enumerated()
            .filter({ $0.element.allSatisfy { $0 == "." } })
            .map(\.offset)
        let blankColumns = map.columns
            .enumerated()
            .filter({ $0.element.allSatisfy { $0 == "." } })
            .map(\.offset)
        let points = Set(
            map.collectLocations { character, _ in character == "#" }
                .map(\.1)
                .map(Point.init)
        )

        return product(points, points)
            .reduce(0) { acc, next in
                acc
                    + next.0.manhattanDistance(
                        multiplyingBy: multiplier,
                        rows: blankRows,
                        columns: blankColumns,
                        to: next.1
                    )
            } / 2
    }

    public func solvePart2() throws -> Int {
        try sumOfShortestLengths(expandingBy: 1_000_000)
    }
}

extension Point {
    func manhattanDistance(multiplyingBy multiplier: Int, rows: [Int], columns: [Int], to point: Point) -> Int {
        let columnRange = min(x, point.x)...max(x, point.x)
        let rowRange = min(y, point.y)...max(y, point.y)
        let multiplier = multiplier - 1
        let additionalExpansion =
            rows.filter { rowRange.contains($0) }.count * multiplier + columns.filter { columnRange.contains($0) }.count
            * multiplier

        return manhattanDistance(to: point) + additionalExpansion
    }
}
