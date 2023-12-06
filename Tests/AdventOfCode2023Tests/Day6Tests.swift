import AdventOfCode2023
import Testing

@Suite("Day 6") struct Day6Tests {
    @Test func part1_test() throws {
        let result = try Day6(input: Day6.sample).solvePart1()
        #expect(result == 288)
    }

    @Test func part1_solution() throws {
        let result = try Day6().solvePart1()
        #expect(result == 4_811_940)
    }

    @Test func part2_test() throws {
        let result = try Day6(input: Day6.sample).solvePart2()
        #expect(result == 71503)
    }

    @Test func part2_solution() throws {
        let result = try Day6().solvePart2()
        #expect(result == 30_077_773)
    }
}
