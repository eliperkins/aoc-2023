import AdventOfCode2023
import Testing

@Suite("Day 7") struct Day7Tests {
    @Test func part1_test() throws {
        let result = try Day7(input: Day7.sample).solvePart1()
        #expect(result == 6440)
    }

    @Test func part1_solution() throws {
        let result = try Day7().solvePart1()
        #expect(result == 246_795_406)
    }

    @Test func part2_test() throws {
        let result = try Day7(input: Day7.sample).solvePart2()
        #expect(result == 5905)
    }

    @Test func part2_solution() throws {
        let result = try Day7().solvePart2()
        #expect(result == 249_356_515)
    }
}
