import AdventOfCodeKit
import Foundation

public struct Day5 {
    public static let sample = """
        seeds: 79 14 55 13

        seed-to-soil map:
        50 98 2
        52 50 48

        soil-to-fertilizer map:
        0 15 37
        37 52 2
        39 0 15

        fertilizer-to-water map:
        49 53 8
        0 11 42
        42 0 7
        57 7 4

        water-to-light map:
        88 18 7
        18 25 70

        light-to-temperature map:
        45 77 23
        81 45 19
        68 64 13

        temperature-to-humidity map:
        0 69 1
        1 0 69

        humidity-to-location map:
        60 56 37
        56 93 4
        """

    public let input: String

    public init(
        input: String? = nil
    ) {
        if let input {
            self.input = input
        } else if let input = try? Input.day(5) {
            self.input = input
        } else {
            self.input = Self.sample
        }
    }

    public struct Almanac {
        let lookupMaps: [[(Int, Int, Int)]]

        public init(input: [[(Int, Int, Int)]]) {
            self.lookupMaps = input
        }

        public func lookup(position: Int) -> Int {
            var position = position
            for group in lookupMaps {
                for (destination, source, length) in group {
                    let sourceRange = source..<(source + length)
                    if sourceRange.contains(position) {
                        position = destination + position - source
                        break
                    }
                }
            }
            return position
        }

        public func minLocation(from ranges: [Range<Int>]) -> Int {
            var current = IndexSet()
            var next = IndexSet()

            // Start mapping with initial ranges, then apply the lookup maps to swap them out
            for range in ranges {
                current.insert(integersIn: range)
            }

            for group in lookupMaps {
                for (destination, source, length) in group {
                    let sourceSet = IndexSet(integersIn: source..<(source + length))
                    for sourceRange in sourceSet.intersection(current).rangeView {
                        let offset = source + destination
                        let start = sourceRange.lowerBound - offset
                        let end = sourceRange.upperBound - offset
                        let destinationRange = start..<end
                        next.insert(integersIn: destinationRange)
                        current.remove(integersIn: sourceRange)
                    }
                }
                current.formUnion(next)
                next.removeAll()
            }

            // Result is a number of incongruent ranges from mapping, so lowest range bounds is the lowest location possible
            return current.rangeView.map { $0.lowerBound }.min() ?? 0
        }
    }

    enum ParsingError: Error {
        case failedToParse
    }

    public func solvePart1() throws -> Int {
        let xs = input.lines.split(whereSeparator: \.isEmpty)
        guard let seedData = xs.first?.first else { throw ParsingError.failedToParse }
        let rest = xs.dropFirst()
        let seeds = seedData.split(separator: " ").map(String.init).compactMap(Int.init)

        let maps =
            rest
            .map { $0.dropFirst() }
            .map { group in
                group.map { $0.split(separator: " ").map(String.init).compactMap(Int.init) }
                    .map {
                        ($0[0]!, $0[1]!, $0[2]!)
                    }
            }

        let almanac = Almanac(input: maps)
        return
            seeds
            .map(almanac.lookup(position:))
            .min()
            ?? 0
    }

    public func solvePart2() async throws -> Int {
        let xs = input.lines.split(whereSeparator: \.isEmpty)
        guard let seedData = xs.first?.first else { throw ParsingError.failedToParse }
        let rest = xs.dropFirst()
        let seedNums = seedData.split(separator: " ").map(String.init).compactMap(Int.init)
        let seedRanges = seedNums.chunks(ofCount: 2).compactMap { xs -> Range<Int>? in
            guard let start = xs.first, let length = xs.last else { return nil }
            return start..<(start + length)
        }
        let maps =
            rest
            .map { $0.dropFirst() }
            .map { group in
                group.map { $0.split(separator: " ").map(String.init).compactMap(Int.init) }
                    .map {
                        ($0[0]!, $0[1]!, $0[2]!)
                    }
            }

        let almanac = Almanac(input: maps)
        return almanac.minLocation(from: seedRanges)
    }
}
