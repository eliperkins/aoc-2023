import AdventOfCode2023
import Testing

@Suite("Day 3") struct Day3Tests {
    @Test func part1_test() throws {
        let result = try Day3(input: Day3.sample).solvePart1()
        #expect(result == 4361)
    }

    @Test func part1_solution() throws {
        let result = try Day3().solvePart1()
        #expect(result == 532331)
    }

    @Test func part2_test() throws {
        let result = try Day3(input: Day3.sample).solvePart2()
        #expect(result == 467835)
    }

    @Test func part2_solution() throws {
        let result = try Day3().solvePart2()
        #expect(result == 1)
    }
}
