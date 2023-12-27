import AdventOfCodeKit
import Collections

public struct Day13 {
    public static let sample = """
        #.##..##.
        ..#.##.#.
        ##......#
        ##......#
        ..#.##.#.
        ..##..##.
        #.#.##.#.

        #...##..#
        #....#..#
        ..##..###
        #####.##.
        #####.##.
        ..##..###
        #....#..#
        """

    public let input: String

    public init(
        input: String? = nil
    ) {
        if let input {
            self.input = input
        } else if let input = try? Input.day(13) {
            self.input = input
        } else {
            self.input = Self.sample
        }
    }

    private func findMirror(in collection: [[Character]], tolerance: Int = 0) -> Int? {
        for index in collection.indices {
            let toMatch = collection[(index + 1)...]
            let pairs = Array(zip(collection[0...index].reversed(), toMatch))
            if pairs.isEmpty {
                continue
            }
            let summarization = pairs.reduce(0) { acc, next in
                let (left, right) = next
                return acc
                    + zip(left, right).reduce(0) { innerAcc, innerNext in
                        let (left, right) = innerNext
                        return innerAcc + (left == right ? 0 : 1)
                    }
            }

            if summarization == tolerance {
                return index + 1
            }
        }

        return nil

    }

    private func findHoriztonalMirror(matrix: Matrix<Character>, tolerance: Int = 0) -> Int? {
        findMirror(in: matrix.rows, tolerance: tolerance)
    }

    private func findVerticalMirror(matrix: Matrix<Character>, tolerance: Int = 0) -> Int? {
        findMirror(in: matrix.columns, tolerance: tolerance)
    }

    public func solvePart1() throws -> Int {
        let chunks = input.lines.split(separator: "")
        return chunks.map { chunk -> Matrix<Character> in
            Matrix(chunk.map(Array.init))
        }.map {
            if let verticalLine = findVerticalMirror(matrix: $0) {
                return verticalLine
            } else if let horizontalLine = findHoriztonalMirror(matrix: $0) {
                return horizontalLine * 100
            }
            fatalError("Missing mirror!")
        }
        .sum()
    }

    public func solvePart2() throws -> Int {
        let chunks = input.lines.split(separator: "")
        return chunks.map { chunk -> Matrix<Character> in
            Matrix(chunk.map(Array.init))
        }.map {
            if let verticalLine = findVerticalMirror(matrix: $0, tolerance: 1) {
                return verticalLine
            } else if let horizontalLine = findHoriztonalMirror(matrix: $0, tolerance: 1) {
                return horizontalLine * 100
            }
            fatalError("Missing mirror!")
        }
        .sum()

    }
}
