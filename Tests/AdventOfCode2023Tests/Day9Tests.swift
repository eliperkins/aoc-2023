import AdventOfCode2023
import Testing

@Suite("Day 9") struct Day9Tests {
    @Test func part1_test() throws {
        let result = try Day9(input: Day9.sample).solvePart1()
        #expect(result == 114)
    }

    @Test func part1_solution() throws {
        let result = try Day9().solvePart1()
        #expect(result == 2_175_229_206)
    }

    @Test func part2_test() throws {
        let result = try Day9(input: Day9.sample).solvePart2()
        #expect(result == 2)
    }

    @Test func part2_solution() throws {
        let result = try Day9().solvePart2()
        #expect(result == 942)
    }
}
