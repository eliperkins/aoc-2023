import AdventOfCodeKit

public struct Day3 {
    public static let sample = """
        467..114..
        ...*......
        ..35..633.
        ......#...
        617*......
        .....+.58.
        ..592.....
        ......755.
        ...$.*....
        .664.598..
        """

    public let input: String

    public init(
        input: String? = nil
    ) {
        if let input {
            self.input = input
        } else if let input = try? Input.day(3) {
            self.input = input
        } else {
            self.input = Self.sample
        }
    }

    struct NumberPosition: Hashable {
        let start: Point
        let end: Point
    }

    struct Symbol: Hashable {
        let point: Point
        let value: String
    }

    final class ParsingState {
        var start: Point
        var end: Point
        var value: Int
        init(start: Point, end: Point, value: Int) {
            self.start = start
            self.end = end
            self.value = value
        }
        var touchedSymbols = [Point: String]()
    }

    func parsePositions(in matrix: Matrix<String>) -> [NumberPosition: (Int, Set<Symbol>)] {
        var numbers = [NumberPosition: (Int, Set<Symbol>)]()
        var state: ParsingState?
        matrix.forEachPoint { value, point in
            func finalizeState() {
                if let stateToAdd = state {
                    let position = NumberPosition(start: stateToAdd.start, end: stateToAdd.end)
                    var symbols = Set<Symbol>()
                    for (key, value) in stateToAdd.touchedSymbols {
                        symbols.insert(Symbol(point: key, value: value))
                    }
                    numbers[position] = (stateToAdd.value, symbols)
                    state = nil
                }
            }

            if let digit = Int(value) {
                if let state, state.start.y == point.y {
                    state.value *= 10
                    state.value += digit
                    state.end = point
                } else {
                    finalizeState()
                    state = ParsingState(start: point, end: point, value: digit)
                }

                for point in point.adjacent {
                    if let symbol = matrix.at(point: point) {
                        if Int(symbol) == nil && symbol != "." {
                            state?.touchedSymbols[point] = symbol
                        }
                    }
                }
            } else {
                finalizeState()
            }
        }
        return numbers
    }

    public func solvePart1() throws -> Int {
        let matrix = Matrix(input.lines.map { $0.unicodeScalars.map { String($0) } })
        let numbers = parsePositions(in: matrix)
        return numbers.values
            .filter { !$0.1.isEmpty }
            .map(\.0)
            .sum()
    }

    public func solvePart2() throws -> Int {
        let matrix = Matrix(input.lines.map { $0.unicodeScalars.map { String($0) } })
        let numbers = parsePositions(in: matrix)

        var sum = 0
        var computedIntersections = Set<Point>()
        for x in numbers.values {
            let (lhs, lhsTouchedSymbols): (Int, Set<Symbol>) = x
            for y in numbers.values where x != y {
                let (rhs, rhsTouchedSymbols): (Int, Set<Symbol>) = y
                for symbol in lhsTouchedSymbols.intersection(rhsTouchedSymbols) where symbol.value == "*" {
                    if !computedIntersections.contains(symbol.point) {
                        sum += lhs * rhs
                        computedIntersections.insert(symbol.point)
                    }
                }
            }
        }

        return sum
    }
}
