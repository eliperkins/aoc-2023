import AdventOfCode2023
import Testing

@Suite("Day 5") struct Day5Tests {
    @Test func lookups() {
        let almanac = Day5.Almanac(
            input: [
                [
                    (50, 98, 2),
                    (52, 50, 48),
                ],
                [
                    (0, 15, 37),
                    (37, 52, 2),
                    (39, 0, 15),
                ],
                [
                    (49, 53, 8),
                    (0, 11, 42),
                    (42, 0, 7),
                    (57, 7, 4),
                ],
                [
                    (88, 18, 7),
                    (18, 25, 70),
                ],
                [
                    (45, 77, 23),
                    (81, 45, 19),
                    (68, 64, 13),
                ],
                [
                    (0, 69, 1),
                    (1, 0, 69),
                ],
                [
                    (60, 56, 37),
                    (56, 93, 4),
                ],
            ]
        )
        #expect(almanac.lookup(position: 79) == 82)
        #expect(almanac.lookup(position: 14) == 43)
        #expect(almanac.lookup(position: 55) == 86)
        #expect(almanac.lookup(position: 13) == 35)
    }

    @Test func part1_test() throws {
        let result = try Day5(input: Day5.sample).solvePart1()
        #expect(result == 35)
    }

    @Test func part1_solution() throws {
        let result = try Day5().solvePart1()
        #expect(result == 825_516_882)
    }

    @Test func part2_test() async throws {
        let result = try await Day5(input: Day5.sample).solvePart2()
        #expect(result == 46)
    }

    @Test func part2_solution() async throws {
        let result = try await Day5().solvePart2()
        #expect(result == 136_096_660)
    }
}
