//
// Структура для лабиринта
//

struct MazeModel {
    // 1я матрица (Правые стенки)
    let matrix1: [[Bool]]
    // 2я матрица (Нижние стенки)
    let matrix2: [[Bool]]
    // Размерность строк
    let countRow: Int
    // Размерность столбцов
    let countColumn: Int
}

extension MazeModel {
    init() {
        matrix1 = []
        matrix2 = []
        countRow = 0
        countColumn = 0
    }
}
