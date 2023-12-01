import AdventOfCodeKit
import Foundation

public struct Day1 {
    public static let sample = """
        1abc2
        pqr3stu8vwx
        a1b2c3d4e5f
        treb7uchet
        """

    public static let sample2 = """
        two1nine
        eightwothree
        abcone2threexyz
        xtwone3four
        4nineeightseven2
        zoneight234
        7pqrstsixteen
        """

    public let input: String

    public init(
        input: String? = nil
    ) {
        if let input {
            self.input = input
        } else if let input = try? Input.day(1) {
            self.input = input
        } else {
            self.input = Self.sample
        }
    }

    public func solvePart1() throws -> Int {
        input.lines.compactMap { line in
            let xs = line.unicodeScalars.compactMap { scalar in
                Int(String(scalar))
            }
            guard let first = xs.first, let last = xs.last else {
                return nil
            }
            return (first * 10) + last
        }
        .sum()
    }

    let numbers = [
        "one": 1,
        "two": 2,
        "three": 3,
        "four": 4,
        "five": 5,
        "six": 6,
        "seven": 7,
        "eight": 8,
        "nine": 9,
    ]

    enum Error: Swift.Error {
        case missingNumberInString
    }

    func findMatches(in line: String, replacements: [String: Int]) throws -> Int {
        for (index, value) in line.indexed() {
            if let num = Int(String(value)) {
                return num
            }

            let substring = line[line.startIndex...index]
            for (key, value) in replacements where substring.hasSuffix(key) {
                return value
            }
        }
        throw Error.missingNumberInString
    }

    public func findFirst(in line: String) throws -> Int {
        try findMatches(in: line, replacements: numbers)
    }

    public func findLast(in line: String) throws -> Int {
        try findMatches(
            in: String(line.reversed()),
            replacements: Dictionary(
                uniqueKeysWithValues: zip(numbers.keys.map { String($0.reversed()) }, numbers.values)))
    }

    public func solvePart2() throws -> Int {
        input.lines.compactMap { line in
            guard let first = try? findFirst(in: line),
                let last = try? findLast(in: line)
            else { return nil }
            return (first * 10) + last
        }
        .sum()
    }
}
