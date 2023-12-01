import AdventOfCode2023
import Testing

@Suite("Day 1") struct Day1Tests {
    @Test func part1_test() throws {
        #expect(try Day1(input: Day1.sample).solvePart1() == 142)
    }

    @Test func part1_solution() throws {
        #expect(try Day1().solvePart1() == 54634)
    }

    @Test func part2_findFirst() throws {
        let day = Day1()
        #expect(try day.findFirst(in: "one2three4five") == 1)
        #expect(try day.findFirst(in: "oneoneone2three4five") == 1)
        #expect(try day.findFirst(in: "xtwone3four") == 2)
        #expect(try day.findFirst(in: "7pqrstsixteen") == 7)
    }

    @Test func part2_findLast() throws {
        let day = Day1()
        #expect(try day.findLast(in: "one2three4five") == 5)
        #expect(try day.findLast(in: "oneoneone2three4five") == 5)
        #expect(try day.findLast(in: "xtwone3four") == 4)
        #expect(try day.findLast(in: "7pqrstsixteen") == 6)
    }

    @Test func part2_test() throws {
        #expect(try Day1(input: Day1.sample2).solvePart2() == 281)
    }

    @Test func part2_solution() throws {
        #expect(try Day1().solvePart2() == 53855)
    }
}
