import AdventOfCode2023
import Testing

@Suite("Day 8") struct Day8Tests {
    @Test func part1_test() throws {
        let result = try Day8(input: Day8.sample).solvePart1()
        #expect(result == 2)
        let result2 = try Day8(input: Day8.sample2).solvePart1()
        #expect(result2 == 6)
    }

    @Test func part1_solution() throws {
        let result = try Day8().solvePart1()
        #expect(result == 17873)
    }

    @Test func part2_test() throws {
        let result = try Day8(input: Day8.sample3).solvePart2()
        #expect(result == 6)
    }

    @Test func part2_solution() throws {
        let result = try Day8().solvePart2()
        #expect(result == 15_746_133_679_061)
    }
}
