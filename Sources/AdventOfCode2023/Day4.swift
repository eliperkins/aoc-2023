import AdventOfCodeKit
import Numerics

public struct Day4 {
    public static let sample = """
        Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
        Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
        Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
        Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
        Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
        Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
        """

    public let input: String

    public init(
        input: String? = nil
    ) {
        if let input {
            self.input = input
        } else if let input = try? Input.day(4) {
            self.input = input
        } else {
            self.input = Self.sample
        }
    }

    struct Card {
        let winningNumbers: Set<Int>
        let myNumbers: Set<Int>
        let matchingNumbers: Set<Int>

        init(winningNumbers: Set<Int>, myNumbers: Set<Int>) {
            self.winningNumbers = winningNumbers
            self.myNumbers = myNumbers
            self.matchingNumbers = winningNumbers.intersection(myNumbers)
        }

        var score: Int {
            if matchingNumbers.isEmpty {
                return 0
            }

            let real = Double(matchingNumbers.count - 1)
            return Int(Double.exp2(real))
        }

        var isWinning: Bool {
            !matchingNumbers.isEmpty
        }
    }

    public func solvePart1() throws -> Int {
        input.lines
            .compactMap {
                if let gameInput = $0.split(separator: ": ").last {
                    let numbers = gameInput.split(separator: " | ")
                    if let first = numbers.first, let last = numbers.last {
                        let winningNumbers = Set(first.split(separator: " ").map(String.init).compactMap(Int.init))
                        let myNumbers = Set(last.split(separator: " ").map(String.init).compactMap(Int.init))
                        return Card(winningNumbers: winningNumbers, myNumbers: myNumbers)
                    }
                }
                return nil
            }
            .map(\.score)
            .sum()
    }

    public func solvePart2() throws -> Int {
        let cards = input.lines
            .compactMap {
                if let gameInput = $0.split(separator: ": ").last {
                    let numbers = gameInput.split(separator: " | ")
                    if let first = numbers.first, let last = numbers.last {
                        let winningNumbers = Set(first.split(separator: " ").map(String.init).compactMap(Int.init))
                        let myNumbers = Set(last.split(separator: " ").map(String.init).compactMap(Int.init))
                        return Card(winningNumbers: winningNumbers, myNumbers: myNumbers)
                    }
                }
                return nil
            }

        var cardCounts = [Int: Int](
            uniqueKeysWithValues:
                zip(
                    Array(cards.indices),
                    Array(repeating: 1, count: cards.count)
                )
        )

        for (winnerIndex, card) in cards.enumerated() where card.isWinning {
            let numberOfWinners = cardCounts[winnerIndex, default: 1]
            let startingIncrementIndex = winnerIndex + 1
            for index in startingIncrementIndex...startingIncrementIndex.advanced(by: card.matchingNumbers.count - 1) {
                cardCounts[index, default: 1] += numberOfWinners
            }
        }

        return cardCounts.values.sum()
    }
}
