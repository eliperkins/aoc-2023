import AdventOfCodeKit
import Foundation
import RegexBuilder

public struct Day8 {
    public static let sample = """
        RL

        AAA = (BBB, CCC)
        BBB = (DDD, EEE)
        CCC = (ZZZ, GGG)
        DDD = (DDD, DDD)
        EEE = (EEE, EEE)
        GGG = (GGG, GGG)
        ZZZ = (ZZZ, ZZZ)
        """

    public static let sample2 = """
        LLR

        AAA = (BBB, BBB)
        BBB = (AAA, ZZZ)
        ZZZ = (ZZZ, ZZZ)
        """

    public static let sample3 = """
        LR

        11A = (11B, XXX)
        11B = (XXX, 11Z)
        11Z = (11B, XXX)
        22A = (22B, XXX)
        22B = (22C, 22C)
        22C = (22Z, 22Z)
        22Z = (22B, 22B)
        XXX = (XXX, XXX)
        """

    public let input: String

    public init(
        input: String? = nil
    ) {
        if let input {
            self.input = input
        } else if let input = try? Input.day(8) {
            self.input = input
        } else {
            self.input = Self.sample
        }
    }

    struct Node: Equatable {
        let name: String

        let left: String
        let right: String
    }

    enum Instruction: Character {
        case left = "L"
        case right = "R"
    }

    enum ParsingError: Error {
        case failedToParse
    }

    func parse() throws -> ([Instruction], [String: Node]) {
        guard let instructionsInput = input.lines.first else { throw ParsingError.failedToParse }
        let rest = input.lines.dropFirst().dropFirst()

        let pattern = Regex {
            Capture(Repeat(.word, count: 3))
            " = ("
            Capture(Repeat(.word, count: 3))
            ", "
            Capture(Repeat(.word, count: 3))
            ")"
        }

        let nodes = rest.compactMap { line -> Node? in
            guard let match = line.firstMatch(of: pattern) else {
                return nil
            }
            let (_, name, left, right) = match.output
            return Node(name: String(name), left: String(left), right: String(right))
        }

        let instructions = instructionsInput.compactMap(Instruction.init(rawValue:))
        let map = Dictionary(uniqueKeysWithValues: zip(nodes.map(\.name), nodes))
        return (instructions, map)
    }

    public func solvePart1() throws -> Int {
        let (instructions, map) = try parse()
        let startNode = map["AAA"]!
        let endNode = map["ZZZ"]!
        var currentNode = startNode
        var stepCount = 0
        while currentNode != endNode {
            let instruction = instructions[stepCount % instructions.count]
            switch instruction {
            case .left:
                currentNode = map[currentNode.left]!
            case .right:
                currentNode = map[currentNode.right]!
            }
            stepCount += 1
        }
        return stepCount
    }

    public func solvePart2() throws -> Int {
        let (instructions, map) = try parse()

        let startNodes = map.filter { $0.0.hasSuffix("A") }.values

        func stepCount(node: Node) -> Int {
            var currentNode = node
            var stepCount = 0
            while !currentNode.name.hasSuffix("Z") {
                let instruction = instructions[stepCount % instructions.count]
                switch instruction {
                case .left:
                    currentNode = map[currentNode.left]!
                case .right:
                    currentNode = map[currentNode.right]!
                }
                stepCount += 1
            }
            return stepCount
        }

        return startNodes.map(stepCount(node:)).lcm()
    }
}
