import AdventOfCode2023
import Testing

@Suite("Day 4") struct Day4Tests {
    @Test func part1_test() throws {
        let result = try Day4(input: Day4.sample).solvePart1()
        #expect(result == 13)
    }

    @Test func part1_solution() throws {
        let result = try Day4().solvePart1()
        #expect(result == 20117)
    }

    @Test func part2_test() throws {
        let result = try Day4(input: Day4.sample).solvePart2()
        #expect(result == 30)
    }

    @Test func part2_solution() throws {
        let result = try Day4().solvePart2()
        #expect(result == 13_768_818)
    }
}
