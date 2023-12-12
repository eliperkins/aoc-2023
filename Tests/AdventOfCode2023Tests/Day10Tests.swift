import AdventOfCode2023
import Testing

@Suite("Day 10") struct Day10Tests {
    @Test(
        "Part 1 test cases",
        arguments: [
            (Day10.sample, 4),
            (Day10.sample2, 4),
            (Day10.sample3, 8),
            (Day10.sample4, 8),
        ]
    )
    func part1_test(input: String, output: Int) throws {
        let result = try Day10(input: input).solvePart1()
        #expect(result == output)
    }

    @Test func part1_solution() throws {
        let result = try Day10().solvePart1()
        #expect(result == 6942)
    }

    @Test(
        "Part 1 test cases",
        arguments: [
            (
                """
                ...........
                .S-------7.
                .|F-----7|.
                .||.....||.
                .||.....||.
                .|L-7.F-J|.
                .|..|.|..|.
                .L--J.L--J.
                ...........
                """,
                4
            ),
            (
                """
                ..........
                .S------7.
                .|F----7|.
                .||....||.
                .||....||.
                .|L-7F-J|.
                .|..||..|.
                .L--JL--J.
                ..........
                """,
                4
            ),
            (
                """
                .F----7F7F7F7F-7....
                .|F--7||||||||FJ....
                .||.FJ||||||||L7....
                FJL7L7LJLJ||LJ.L-7..
                L--J.L7...LJS7F-7L7.
                ....F-J..F7FJ|L7L7L7
                ....L7.F7||L7|.L7L7|
                .....|FJLJ|FJ|F7|.LJ
                ....FJL-7.||.||||...
                ....L---J.LJ.LJLJ...
                """,
                8
            ),
            (
                """
                FF7FSF7F7F7F7F7F---7
                L|LJ||||||||||||F--J
                FL-7LJLJ||||||LJL-77
                F--JF--7||LJLJ7F7FJ-
                L---JF-JLJ.||-FJLJJ7
                |F|F-JF---7F7-L7L|7|
                |FFJF7L7F-JF7|JL---7
                7-L-JL7||F7|L7F-7F7|
                L.L7LFJ|||||FJL7||LJ
                L7JLJL-JLJLJL--JLJ.L
                """,
                10
            ),
        ]
    )
    func part2_test(input: String, output: Int) throws {
        let result = try Day10(input: input).solvePart2()
        #expect(result == output)
    }

    @Test func part2_solution() throws {
        let result = try Day10().solvePart2()
        #expect(result == 297)
    }
}
