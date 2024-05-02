import XCTest
@testable import Maze

final class Tests: XCTestCase {

    func testCaveGenerate_1() throws {
        // given
        let row = 0, column = 0
        // when
        let result = CaveModel().generateCave(row: row, column: column)
        // then
        XCTAssertTrue(result.isEmpty)
    }

    func testCaveGenerate_2() throws {
        // given
        let row = -5, column = 20
        // when
        let result = CaveModel().generateCave(row: row, column: column)
        // then
        XCTAssertTrue(result.isEmpty)
    }

    func testCaveGenerate_3() throws {
        // given
        let row = 10, column = 10
        // when
        let result = CaveModel().generateCave(row: row, column: column)
        // then
        XCTAssertTrue(!result.isEmpty)
    }

    func testCaveGenerate_4() throws {
        // given
        let row = 51, column = 10
        // when
        let result = CaveModel().generateCave(row: row, column: column)
        // then
        XCTAssertTrue(result.isEmpty)
    }

    func testCaveGenerate_5() throws {
        // given
        let row = 49, column = 1
        // when
        let result = CaveModel().generateCave(row: row, column: column)
        // then
        XCTAssertTrue(!result.isEmpty)
    }

    func testMazeGenerator_1() {
        let maze = Maze.shared
        maze.generateMaze(rows: "5", cols: "5")
        XCTAssertEqual(maze.countRow, maze.countColumn)
    }

    func testMazeGenerator_2() {
        let maze = Maze.shared
        maze.generateMaze(rows: "7", cols: "7")
        XCTAssertEqual(maze.horizontalWalls.count, 7)
        XCTAssertEqual(maze.verticalWalls.count, 7)
    }

    func testFindRoute_1() {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "test", ofType: "txt") ?? "")
        let result: Result<URL, Error> = .success(url)
        Maze.shared.openFile(result)
        let vWalls = [[false, false, false, true], [true, false, true, true],
                      [false, true, false, true], [false, false, false, true]]
        let hWalls = [[true, false, true, false], [false, false, true, false],
                      [true, true, false, true], [true, true, true, true]]
        XCTAssertEqual(vWalls, Maze.shared.verticalWalls)
        XCTAssertEqual(hWalls, Maze.shared.horizontalWalls)
    }

    func testFindRoute_2() {
        let maze = Maze.shared
        maze.generateMaze(rows: "4", cols: "4")
        XCTAssertFalse(maze.findRoute(from: Maze.Point(x: 0, y: 0), to: Maze.Point(x: 3, y: 3)).isEmpty)
        XCTAssertFalse(maze.findRoute(from: Maze.Point(x: 0, y: 0), to: Maze.Point(x: 1, y: 3)).isEmpty)
        XCTAssertFalse(maze.findRoute(from: Maze.Point(x: 2, y: 1), to: Maze.Point(x: 1, y: 3)).isEmpty)
    }

}
