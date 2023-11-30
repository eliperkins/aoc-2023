import AdventOfCodeKit
import XCTest

final class GraphTests: XCTestCase {
    /*
      A — B
         / \
        C   D
         \ /
          E
     */
    let graph = Graph(
        items: ["A", "B", "C", "D", "E"],
        map: [
            "A": ["B"],
            "B": ["A", "C", "D"],
            "C": ["B", "E"],
            "D": ["B", "E"],
            "E": ["C", "D"],
        ]
    )

    func test_bfs() throws {
        let path = graph.breadthFirstSearch(from: "A", to: "C")
        XCTAssertEqual(path, ["A", "B", "C"])
    }

    func test_bfs_traversal() throws {
        XCTAssertEqual(
            Array(graph.breadthFirstTraversal(from: "A")),
            [
                ["A"],
                ["A", "B"],
                ["A", "B", "C"],
                ["A", "B", "D"],
                ["A", "B", "C", "E"],
            ]
        )
    }

    func test_floydWarshall() throws {
        let aPaths = graph.floydWarshall().filter { $0.source == "A" }
            .sorted(by: { $0.destination < $1.destination })
        let possiblePaths = Set([
            Graph.PathResult(source: "A", destination: "B", path: ["A", "B"]),
            Graph.PathResult(source: "A", destination: "C", path: ["A", "B", "C"]),
            Graph.PathResult(source: "A", destination: "D", path: ["A", "B", "D"]),
            Graph.PathResult(source: "A", destination: "E", path: ["A", "B", "D", "E"]),
            Graph.PathResult(source: "A", destination: "E", path: ["A", "B", "C", "E"]),
        ])
        XCTAssertTrue(possiblePaths.subtracting(aPaths).count == 1)
    }

}

extension String: Identifiable {
    public var id: String { self }
}
