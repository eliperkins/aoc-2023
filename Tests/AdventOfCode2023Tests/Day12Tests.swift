import AdventOfCode2023
import Testing

@Suite("Day 12") struct Day12Tests {
    @Test func part1_test() throws {
        let result = try Day12(input: Day12.sample).solvePart1()
        #expect(result == 21)
    }

    @Test func part1_solution() throws {
        let result = try Day12().solvePart1()
        #expect(result == 7017)
    }

    @Test func part2_test() throws {
        let result = try Day12(input: Day12.sample).solvePart2()
        #expect(result == 525152)
    }

    @Test func part2_solution() throws {
        let result = try Day12().solvePart2()
        #expect(result == 527_570_479_489)
    }
}
