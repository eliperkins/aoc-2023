import AdventOfCodeKit

public struct Day2 {
    public static let sample = """
        Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
        Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
        Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
        Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
        Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
        """

    public let input: String

    public init(
        input: String? = nil
    ) {
        if let input {
            self.input = input
        } else if let input = try? Input.day(2) {
            self.input = input
        } else {
            self.input = Self.sample
        }
    }

    struct Pull {
        let red: Int
        let green: Int
        let blue: Int
    }

    func makeGamesByID() -> [Int: [Pull]] {
        Dictionary(
            uniqueKeysWithValues:
                input
                .lines
                .compactMap { line in
                    let gameID = #/Game (\d+):/#
                    // let pullValues = #/(((?<count>\d+) (?<color>blue|red|green)(, )*)+;)+/#
                    if let match = line.firstMatch(of: gameID), let rest = line.split(separator: ":").last {
                        let id = match.1
                        let pull = rest.split(separator: ";").map { pull in
                            let parts = pull.split(separator: ", ")
                            let values = Dictionary(
                                uniqueKeysWithValues: parts.map {
                                    let xs = $0.split(separator: " ")
                                    let count = Int(xs.first!)!
                                    let color = String(xs.last!)
                                    return (color, count)
                                }
                            )
                            return Pull(
                                red: values["red", default: 0],
                                green: values["green", default: 0],
                                blue: values["blue", default: 0]
                            )
                        }
                        return (Int(id)!, pull)
                    }
                    return nil
                }
        )
    }

    public func solvePart1() throws -> Int {
        makeGamesByID()
            .map { key, pulls in
                let allPassing = pulls.allSatisfy { pulls in
                    pulls.red <= 12 && pulls.green <= 13 && pulls.blue <= 14
                }
                return allPassing ? key : 0
            }
            .sum()
    }

    public func solvePart2() throws -> Int {
        makeGamesByID()
            .values
            .map { pulls in
                var reds = 0
                var greens = 0
                var blues = 0
                for pull in pulls {
                    reds = max(pull.red, reds)
                    greens = max(pull.green, greens)
                    blues = max(pull.blue, blues)
                }
                return reds * greens * blues
            }
            .sum()
    }
}
