//
// Генерация лабиринта
//

import Foundation

struct MazeGenerator {
    public lazy var verticalWalls: [[Bool]] = {
       vWalls
    }()
    public lazy var horizontalWalls: [[Bool]] = {
       hWalls
    }()
    public var countRow: Int { rows }
    public var countColumn: Int { cols }
    private var vWalls = [[Bool]]()
    private var hWalls = [[Bool]]()
    private var rows = 0
    private var cols = 0
    private var sideLine = [Int]()
    private var counter = 1
    public mutating func generate(rows: Int, cols: Int) {
        guard rows > 0 && cols > 0 else { return }

        self.rows = rows
        self.cols = cols

        vWalls = (0..<rows).map { _ in
            (0..<cols).map { _ in
                return false
            }
        }
        hWalls = (0..<rows).map { _ in
            (0..<cols).map { _ in
                return false
            }
        }
        generate()
    }
    private mutating func generate() {
        guard rows > 0 && cols > 0 else { return }
        clearGenerator()
        for i in 0..<rows - 1 {
            assignSet()
            addVerticaleWalls(row: i)
            addHorizontalWalls(row: i)
            checkHorizontalWalls(row: i)
            prepareNewLine(row: i)
        }
        addEndLine()
    }
    private mutating func clearGenerator() {
        counter = 1
        sideLine = (0..<cols).map { _ in
            0
        }
    }
    private mutating func addEndLine() {
        assignSet()
        addVerticaleWalls(row: rows - 1)
        checkEndLine()
    }
    private mutating func checkEndLine() {
        for i in 0..<cols - 1 {
            if sideLine[i] != sideLine[i + 1] {
                vWalls[rows - 1][i] = false
                mergeSet(index: i, element: sideLine[i])
            }
            hWalls[rows - 1][i] = true
        }
        hWalls[rows - 1][cols - 1] = true
    }
    private mutating func addVerticaleWalls(row: Int) {
        for i in 0..<cols - 1 {
            if Bool.random() || sideLine[i] == sideLine[i + 1] {
                vWalls[row][i] = true
            } else {
                mergeSet(index: i, element: sideLine[i])
            }
        }
        vWalls[row][cols - 1] = true
    }
    private mutating func addHorizontalWalls(row: Int) {
        for i in 0..<cols {
            if calculateSet(element: sideLine[i]) != 1 && Bool.random() {
                hWalls[row][i] = true
            }
        }
    }
    private mutating func mergeSet(index: Int, element: Int) {
        let mutableSet = sideLine[index + 1]
        for (index, item) in sideLine.enumerated() where item == mutableSet {
            sideLine[index] = element
        }
    }
    private func calculateSet(element: Int) -> Int {
        return sideLine.reduce(0) { partialResult, item in
            if item == element {
                return partialResult + 1
            } else {
                return partialResult
            }
        }
    }
    private mutating func checkHorizontalWalls(row: Int) {
        for i in 0..<cols where countHorizontalWalls(element: sideLine[i], row: row) == 0 {
            hWalls[row][i] = false
        }
    }
    private func countHorizontalWalls(element: Int, row: Int) -> Int {
        var result = 0
        for i in 0..<cols {
            if sideLine[i] == element && hWalls[row][i] == false {
                result += 1
            }
        }
        return result
    }
    private mutating func prepareNewLine(row: Int) {
        for i in 0..<cols where hWalls[row][i] == true {
            sideLine[i] = 0
        }
    }
    private mutating func assignSet() {
        for (index, item) in sideLine.enumerated() where item == 0 {
            sideLine[index] = counter
            counter += 1
        }
    }
}
