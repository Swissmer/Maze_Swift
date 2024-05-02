//
// Расширение для Maze (поиск пути)
//

import Foundation

extension Maze {
    struct Point {
        let x: Int
        let y: Int
    }
    private func changeCell(value: Int, cell: Int) -> Int {
        if cell == -1 {
            return value
        } else {
            return min(cell, value)
        }
    }
    private func takePossibleSteps(step: Int, map: inout [[Int]]) -> Int {
        var result = 0
        for i in 0..<countRow {
            for j in 0..<countColumn where map[i][j] == step {
                result += 1
                if i < countRow - 1 && horizontalWalls[i][j] == false {
                    map[i + 1][j] = changeCell(value: step + 1, cell: map[i + 1][j])
                }
                if i > 0 && horizontalWalls[i - 1][j] == false {
                    map[i - 1][j] = changeCell(value: step + 1, cell: map[i - 1][j])
                }
                if j < countColumn - 1 && verticalWalls[i][j] == false {
                    map[i][j + 1] = changeCell(value: step + 1, cell: map[i][j + 1])
                }
                if j > 0 && verticalWalls[i][j - 1] == false {
                    map[i][j - 1] = changeCell(value: step + 1, cell: map[i][j - 1])
                }
            }
        }
        return result
    }
    public func findRoute(from start: Point, to end: Point) -> [Point] {
        var route = [Point]()
        var x = end.x
        var y = end.y
        var count = 1
        var step = 0
        var map = (0..<countRow).map { _ in
            (0..<countColumn).map { _ in
                -1
            }
        }
        map[start.y][start.x] = 0
        while count > 0 && map[y][x] == -1 {
            count = takePossibleSteps(step: step, map: &map)
            step += 1
        }
        if map[y][x] != -1 {
            step = map[y][x]
            route.append(Point(x: x, y: y))
            while y != start.y || x != start.x {
                if y < countRow - 1 && horizontalWalls[y][x] == false && map[y + 1][x] == step - 1 {
                    y += 1
                } else if y > 0 && horizontalWalls[y - 1][x] == false && map[y - 1][x] == step - 1 {
                    y -= 1
                } else if x < countColumn - 1 && verticalWalls[y][x] == false && map[y][x + 1] == step - 1 {
                    x += 1
                } else if x > 0 && verticalWalls[y][x - 1] == false && map[y][x - 1] == step - 1 {
                    x -= 1
                }
                route.append(Point(x: x, y: y))
                step -= 1
            }
        }
        return route
    }
}
