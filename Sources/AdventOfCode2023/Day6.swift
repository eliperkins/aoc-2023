import AdventOfCodeKit

public struct Day6 {
    public static let sample = """
        Time:      7  15   30
        Distance:  9  40  200
        """

    public let input: String

    public init(
        input: String? = nil
    ) {
        if let input {
            self.input = input
        } else if let input = try? Input.day(6) {
            self.input = input
        } else {
            self.input = Self.sample
        }
    }

    enum ParsingError: Error {
        case failedToParse
    }

    @inlinable
    func calculateDistances(raceDuration: Int, recordDistance: Int) -> Int {
        let hasNoMidpoint = raceDuration.isMultiple(of: 2)
        let midpoint = hasNoMidpoint ? raceDuration / 2 : (raceDuration / 2) + 1

        let range = 1...midpoint
        for holdDuration in range {
            let distance = holdDuration * (raceDuration - holdDuration)
            if distance > recordDistance {
                let result = (midpoint - holdDuration) * 2
                return hasNoMidpoint ? result + 1 : result
            }
        }

        return 0
    }

    public func solvePart1() throws -> Int {
        let lines = input.lines.map {
            $0.split(separator: " ").map(String.init).compactMap(Int.init)
        }

        guard let times = lines.first, let distances = lines.last else {
            throw ParsingError.failedToParse
        }

        return zip(times, distances)
            .map { time, distance in
                let x = calculateDistances(raceDuration: time, recordDistance: distance)
                print(x)
                return x
            }
            .product()
    }

    public func solvePart2() throws -> Int {
        let lines = input.lines
            .map {
                $0.split(separator: " ").map(String.init).dropFirst().filter { !$0.isEmpty }.joined()
            }
            .compactMap(Int.init)

        guard let time = lines.first, let distance = lines.last else {
            throw ParsingError.failedToParse
        }

        return calculateDistances(raceDuration: time, recordDistance: distance)
    }
}
