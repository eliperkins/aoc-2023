import AdventOfCodeKit

public struct Day7 {
    public static let sample = """
        32T3K 765
        T55J5 684
        KK677 28
        KTJJT 220
        QQQJA 483
        """

    public let input: String

    public init(
        input: String? = nil
    ) {
        if let input {
            self.input = input
        } else if let input = try? Input.day(7) {
            self.input = input
        } else {
            self.input = Self.sample
        }
    }

    public struct Hand: Comparable, CustomDebugStringConvertible {
        public enum Ranking: Comparable {
            case fiveOfAKind
            case fourOfAKind
            case fullHouse
            case threeOfAKind
            case twoPair
            case onePair
            case highCard

            public var strength: Int {
                switch self {
                case .fiveOfAKind: return 6
                case .fourOfAKind: return 5
                case .fullHouse: return 4
                case .threeOfAKind: return 3
                case .twoPair: return 2
                case .onePair: return 1
                case .highCard: return 0
                }
            }

            public static func < (lhs: Ranking, rhs: Ranking) -> Bool {
                lhs.strength < rhs.strength
            }
        }

        public enum Card: Hashable, Comparable, CustomDebugStringConvertible {
            case number(Int)
            case jack
            case queen
            case king
            case ace
            case joker

            enum ParsingError: Error {
                case invalidCharacter(Unicode.Scalar)
            }

            public init(_ character: Unicode.Scalar, jokersEnabled: Bool) throws {
                switch character {
                case "T": self = .number(10)
                case "J": self = jokersEnabled ? .joker : .jack
                case "Q": self = .queen
                case "K": self = .king
                case "A": self = .ace
                default:
                    guard let number = Int(String(character)) else {
                        throw ParsingError.invalidCharacter(character)
                    }
                    self = .number(number)
                }
            }

            public var debugDescription: String {
                switch self {
                case let .number(number):
                    if number == 10 {
                        return "T"
                    }
                    return String(number)
                case .jack: return "J"
                case .queen: return "Q"
                case .king: return "K"
                case .ace: return "A"
                case .joker: return "🃏"
                }
            }

            public var value: Int {
                switch self {
                case let .number(number): return number
                case .jack: return 11
                case .queen: return 12
                case .king: return 13
                case .ace: return 14
                case .joker: return 1
                }
            }

            public static func < (lhs: Card, rhs: Card) -> Bool {
                lhs.value < rhs.value
            }
        }

        public let ranking: Ranking
        public let cards: [Card]

        static func calculateRanking(_ cards: [Card], jokersEnabled: Bool) -> Ranking {
            let counts = Dictionary(grouping: cards, by: { $0 }).mapValues(\.count)
            let sortedCounts = counts.sorted { $0.value > $1.value }

            let numberOfDifferentValues = sortedCounts.count
            let jokerCount = jokersEnabled ? counts[.joker, default: 0] : 0
            let mostCommonCardCount = sortedCounts.first?.value

            switch (numberOfDifferentValues, mostCommonCardCount, jokerCount) {
            case (1, _, _): return .fiveOfAKind
            case (2, 4, 0): return .fourOfAKind
            case (2, 3, 0): return .fullHouse
            case (2, _, _): return .fiveOfAKind
            case (3, 3, 0): return .threeOfAKind
            case (3, 3, 1): return .fourOfAKind
            case (3, 3, 2): return .fiveOfAKind
            case (3, 2, 1): return .fullHouse
            case (3, 2, 2): return .fourOfAKind
            case (3, _, 3): return .fourOfAKind
            case (3, _, _): return .twoPair
            case (4, _, 1): return .threeOfAKind
            case (4, _, 2): return .threeOfAKind
            case (4, _, _): return .onePair
            case (5, _, 1): return .onePair
            default: return .highCard
            }
        }

        public init<S: StringProtocol>(_ stringValue: S, jokersEnabled: Bool) throws {
            let cards = try stringValue.unicodeScalars.compactMap { try Card($0, jokersEnabled: jokersEnabled) }
            self.cards = cards
            self.ranking = Self.calculateRanking(cards, jokersEnabled: jokersEnabled)
        }

        public var debugDescription: String {
            "\(cards) \(ranking)"
        }

        public static func < (lhs: Hand, rhs: Hand) -> Bool {
            if lhs.ranking == rhs.ranking {
                for (lhsCard, rhsCard) in zip(lhs.cards, rhs.cards) where lhsCard != rhsCard {
                    return lhsCard < rhsCard
                }
            }

            return lhs.ranking < rhs.ranking
        }
    }

    func parseHands(jokersEnabled: Bool) throws -> [(Hand, Int)] {
        try input.lines.compactMap { line -> (Hand, Int)? in
            let parts = line.split(separator: " ", maxSplits: 2)
            guard let hand = parts.first,
                let score = parts.last.flatMap({ Int(String($0)) })
            else {
                return nil
            }
            return (try Hand(hand, jokersEnabled: jokersEnabled), score)
        }
    }

    public func solvePart1() throws -> Int {
        try parseHands(jokersEnabled: false)
            .sorted(by: { $0.0 < $1.0 })
            .enumerated()
            .map { ($0 + 1) * $1.1 }
            .sum()
    }

    public func solvePart2() throws -> Int {
        try parseHands(jokersEnabled: true)
            .sorted(by: { $0.0 < $1.0 })
            .enumerated()
            .map { ($0 + 1) * $1.1 }
            .sum()
    }
}
