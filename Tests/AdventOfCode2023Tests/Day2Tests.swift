import AdventOfCode2023
import Testing

@Suite("Day 2") struct Day2Tests {
    @Test func part1_test() throws {
        let value = try Day2(input: Day2.sample).solvePart1()
        #expect(value == 8)
    }

    @Test func part1_solution() throws {
        let value = try Day2().solvePart1()
        #expect(value == 2617)
    }

    @Test func part2_test() throws {
        let value = try Day2(input: Day2.sample).solvePart2()
        #expect(value == 2286)
    }

    @Test func part2_solution() throws {
        let value = try Day2().solvePart2()
        #expect(value == 59795)
    }
}
