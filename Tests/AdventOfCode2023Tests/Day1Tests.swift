import AdventOfCode2023
import XCTest

final class Day1Tests: XCTestCase {
    func test_part1_test() throws {
        XCTAssertEqual(try Day1(input: Day1.sample).solvePart1(), 142)
    }

    func test_part1_solution() throws {
        XCTAssertEqual(try Day1().solvePart1(), 54634)
    }

    func test_part2_findFirst() throws {
        let day = Day1()
        XCTAssertEqual(try day.findFirst(in: "one2three4five"), 1)
        XCTAssertEqual(try day.findFirst(in: "oneoneone2three4five"), 1)
        XCTAssertEqual(try day.findFirst(in: "xtwone3four"), 2)
        XCTAssertEqual(try day.findFirst(in: "7pqrstsixteen"), 7)
    }

    func test_part2_findLast() throws {
        let day = Day1()
        XCTAssertEqual(try day.findLast(in: "one2three4five"), 5)
        XCTAssertEqual(try day.findLast(in: "oneoneone2three4five"), 5)
        XCTAssertEqual(try day.findLast(in: "xtwone3four"), 4)
        XCTAssertEqual(try day.findLast(in: "7pqrstsixteen"), 6)
    }

    func test_part2_test() throws {
        XCTAssertEqual(try Day1(input: Day1.sample2).solvePart2(), 281)
    }

    func test_part2_solution() throws {
        XCTAssertEqual(try Day1().solvePart2(), 53855)
    }
}
