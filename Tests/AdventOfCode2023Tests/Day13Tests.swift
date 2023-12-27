import AdventOfCode2023
import Testing

@Suite("Day 13") struct Day13Tests {
    @Test func part1_test() throws {
        let result = try Day13(input: Day13.sample).solvePart1()
        #expect(result == 405)
    }

    @Test func part1_solution() throws {
        let result = try Day13().solvePart1()
        #expect(result == 33780)
    }

    @Test func part2_test() throws {
        let result = try Day13(input: Day13.sample).solvePart2()
        #expect(result == 400)
    }

    @Test func part2_solution() throws {
        let result = try Day13().solvePart2()
        #expect(result == 23479)
    }
}
