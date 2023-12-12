import AdventOfCodeKit
import OrderedCollections

public struct Day10 {
    public static let sample = """
        .....
        .S-7.
        .|.|.
        .L-J.
        .....
        """

    public static let sample2 = """
        -L|F7
        7S-7|
        L|7||
        -L-J|
        L|-JF
        """

    public static let sample3 = """
        ..F7.
        .FJ|.
        SJ.L7
        |F--J
        LJ...
        """

    public static let sample4 = """
        7-F7-
        .FJ|7
        SJLL7
        |F--J
        LJ.LJ
        """

    public let input: String

    public init(
        input: String? = nil
    ) {
        if let input {
            self.input = input
        } else if let input = try? Input.day(10) {
            self.input = input
        } else {
            self.input = Self.sample
        }
    }

    struct Pipe: Hashable, CustomDebugStringConvertible {
        enum ConnectionDirection: Hashable {
            case north
            case south
            case east
            case west

            var opposite: ConnectionDirection {
                switch self {
                case .north:
                    return .south
                case .south:
                    return .north
                case .east:
                    return .west
                case .west:
                    return .east
                }
            }
        }

        let point: Point
        let connectionDirections: Set<ConnectionDirection>

        init(point: Point, character: Character) {
            self.point = point
            switch character {
            case "|":
                connectionDirections = [.north, .south]
            case "-":
                connectionDirections = [.east, .west]
            case "L":
                connectionDirections = [.north, .east]
            case "J":
                connectionDirections = [.north, .west]
            case "7":
                connectionDirections = [.south, .west]
            case "F":
                connectionDirections = [.south, .east]
            case ".":
                connectionDirections = []
            case "S":
                connectionDirections = [.north, .south, .east, .west]
            default:
                fatalError("Unexpected character: \(character)")
            }
        }

        var isStartingPoint: Bool {
            connectionDirections == [.north, .south, .east, .west]
        }

        var isGround: Bool {
            connectionDirections.isEmpty
        }

        func connects(to other: Pipe, from direction: ConnectionDirection) -> Bool {
            if isGround || other.isGround {
                return false
            }

            return connectionDirections.contains(direction) && other.connectionDirections.contains(direction.opposite)
        }

        var debugDescription: String {
            switch connectionDirections {
            case [.north, .south, .east, .west]:
                return "S"
            case [.north, .south]:
                return "|"
            case [.east, .west]:
                return "-"
            case [.north, .east]:
                return "L"
            case [.north, .west]:
                return "J"
            case [.south, .west]:
                return "7"
            case [.south, .east]:
                return "F"
            default:
                return "."
            }
        }
    }

    public func solvePart1() throws -> Int {
        let map = try Matrix(string: input).map {
            Pipe(point: Point($1), character: $0)
        }
        let start = map.first(where: \.isStartingPoint)!
        var current = start
        var previousDirection: Pipe.ConnectionDirection?
        var loop = Set<Pipe>([])
        loop.insert(start)
        walkingLoop: while true {
            let directions =
                previousDirection.flatMap({ current.connectionDirections.subtracting([$0]) })
                ?? current.connectionDirections
            directionLoop: for direction in directions {
                let next: Point
                switch direction {
                case .north:
                    next = Point(x: current.point.x, y: current.point.y - 1)
                case .south:
                    next = Point(x: current.point.x, y: current.point.y + 1)
                case .east:
                    next = Point(x: current.point.x + 1, y: current.point.y)
                case .west:
                    next = Point(x: current.point.x - 1, y: current.point.y)
                }

                if let nextPipe = map.at(point: next), current.connects(to: nextPipe, from: direction) {
                    if !loop.contains(nextPipe) {
                        loop.insert(nextPipe)
                        current = nextPipe
                        previousDirection = direction.opposite
                        break directionLoop
                    } else if nextPipe.isStartingPoint {
                        break walkingLoop
                    }
                }
            }
        }

        return loop.count / 2
    }

    public func solvePart2() throws -> Int {
        let map = try Matrix(string: input).map {
            Pipe(point: Point($1), character: $0)
        }
        let start = map.first(where: \.isStartingPoint)!
        var current = start
        var previousDirection: Pipe.ConnectionDirection?
        var loop = OrderedSet<Pipe>([])
        loop.append(start)
        walkingLoop: while true {
            let directions =
                previousDirection.flatMap({ current.connectionDirections.subtracting([$0]) })
                ?? current.connectionDirections
            directionLoop: for direction in directions {
                let next: Point
                switch direction {
                case .north:
                    next = Point(x: current.point.x, y: current.point.y - 1)
                case .south:
                    next = Point(x: current.point.x, y: current.point.y + 1)
                case .east:
                    next = Point(x: current.point.x + 1, y: current.point.y)
                case .west:
                    next = Point(x: current.point.x - 1, y: current.point.y)
                }

                if let nextPipe = map.at(point: next), current.connects(to: nextPipe, from: direction) {
                    if !loop.contains(nextPipe) {
                        loop.append(nextPipe)
                        current = nextPipe
                        previousDirection = direction.opposite
                        break directionLoop
                    } else if nextPipe.isStartingPoint {
                        break walkingLoop
                    }
                }
            }
        }

        let area = zip(loop, loop.dropFirst() + [loop.first!]).reduce(0) { acc, next in
            let (lhs, rhs) = next
            return acc + lhs.point.x * rhs.point.y - lhs.point.y * rhs.point.x
        }
        return abs(area) / 2 - ((loop.count - 1) / 2)
    }
}
