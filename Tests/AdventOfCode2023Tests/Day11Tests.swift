import AdventOfCode2023
import Testing

@Suite("Day 11") struct Day11Tests {
    @Test func part1_test() throws {
        let result = try Day11(input: Day11.sample).solvePart1()
        #expect(result == 374)
    }

    @Test func part1_solution() throws {
        let result = try Day11().solvePart1()
        #expect(result == 9_312_968)
    }

    @Test func part2_test() throws {
        let result10 = try Day11(input: Day11.sample).sumOfShortestLengths(expandingBy: 10)
        #expect(result10 == 1030)

        let result100 = try Day11(input: Day11.sample).sumOfShortestLengths(expandingBy: 100)
        #expect(result100 == 8410)
    }

    @Test func part2_solution() throws {
        let result = try Day11().solvePart2()
        #expect(result == 597_714_117_556)
    }
}
