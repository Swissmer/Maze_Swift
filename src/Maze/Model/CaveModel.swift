//
// Модель для пещеры
//

class CaveModel {
    // Матрица рабочая
    var matrix: [[Bool]] = [[]]
    // Размерность строк
    var countRow: Int = 0
    // Размерность столбцов
    var countColumn: Int = 0
    // Порог рождения
    var birth: Int = 0
    // Порог смерти
    var death: Int = 0

    init() {}

    // Генерация пещеры
    func generateCave(row: Int, column: Int) -> [[Bool]] {
        guard row <= 50, row > 0,
              column <= 50, column > 0 else {return []}

        var matrixTmp: [[Bool]] = []
        for _ in 0..<row {
            var arr: [Bool] = []
            for _ in 0..<column {
                arr.append(Bool.random())
            }
            matrixTmp.append(arr)
        }
        return matrixTmp
    }

    // Получение значения по правилам игры
    func countNeighbors(matrix: [[Bool]], xValue: Int, yValue: Int, death: Int, birth: Int) -> Bool {
        var value = matrix[yValue][xValue]
        let numRows = matrix.count
        let numCols = matrix[0].count
        var black = 0
        var white = 0
        for iTmp in -1...1 {
            for jTmp in -1...1 {
                if iTmp == 0 && jTmp == 0 {
                    continue
                }
                let xTmp = xValue + jTmp
                let yTmp = yValue + iTmp
                if yTmp >= 0 && yTmp < numRows && xTmp >= 0 && xTmp < numCols && matrix[yTmp][xTmp] == false {
                    black += 1
                } else {
                    white += 1
                }
            }
        }
        if value == true && death > white {
            value = false
        } else if value == false && birth < white {
            value = true
        }
        return value
    }
}
