import Combine
import Foundation

final class Maze: ObservableObject {
    static var shared = Maze()
    // модель
    private var model = MazeModel()
    // из модели
    @Published public var verticalWalls: [[Bool]] = []
    @Published public var horizontalWalls: [[Bool]] = []
    @Published public var countRow: Int = 0
    @Published public var countColumn: Int = 0
    // для view
    @Published public var isLoad = false
    @Published public var dotSizeX: Int = 0
    @Published public var dotSizeY: Int = 0
    // естируются
    @Published public var path: [Point] = []
    @Published public var isLoadPath = false
    // размеры окна
    public let size: Int = 500

    private init() {}

    // Открываем файл
    public func openFile(_ result: Result<URL, any Error>) {
        do {
            let fileUrl = try result.get()
            if fileUrl.startAccessingSecurityScopedResource() {
                defer {fileUrl.stopAccessingSecurityScopedResource()}
                print("Результат File:", validateMazeData(from: (try String(contentsOf: fileUrl))))
            } else {
                print("Доступ к файлу закрыт!")
            }
        } catch {
            print(error)
        }
    }

    // Генератор лабиринта
    public func generateMaze(rows: String, cols: String) {
        // валидация
        guard let row1 = Int(rows), row1 > 0, row1 <= 50,
              let col1 = Int(rows), col1 > 0, col1 <= 50
        else {return}

        var generator = MazeGenerator()
        generator.generate(rows: row1, cols: col1)
        self.setValue(generator.verticalWalls, generator.horizontalWalls)
    }

    // Поиск пути
    public func searchPath(x1: String, y1: String, x2: String, y2: String) {
        // валидация
        guard let xTmp1 = Int(x1), xTmp1 >= 0, xTmp1 < countColumn,
              let yTmp1 = Int(y1), yTmp1 >= 0, yTmp1 < countRow,
              let xTmp2 = Int(x2), xTmp2 >= 0, xTmp2 < countColumn,
              let yTmp2 = Int(y2), yTmp2 >= 0, yTmp2 < countRow
        else {return}

        self.path = findRoute(from: Point(x: xTmp1, y: yTmp1), to: Point(x: xTmp2, y: yTmp2))
        print(self.path)
        self.isLoadPath = true
    }

    // Проверка данных из файла
    private func validateMazeData(from fileContent: String) -> Bool {
        // этап загрузки
        self.isLoad = true
        // рабочие переменные
        var matrixTmp1: [[Bool]] = []
        var matrixTmp2: [[Bool]] = []
        let result = true
        let lines = fileContent.components(separatedBy: .newlines)
        // получение первой строки
        let firstLine = lines[0].components(separatedBy: " ")
        // проверка размера
        guard lines[0].components(separatedBy: " ").count == 2,
              let countRow = Int(firstLine[0]), lines.count > countRow + 2,
              let countColumn = Int(firstLine[1]),
              countColumn <= 50, countRow <= 50 else {return false}

        // проверка 1й матрицы
        for index in 1...countRow {
            let elements = lines[index].components(separatedBy: " ")
            guard elements.count == countColumn,
                  elements.allSatisfy({Int($0) != nil && ($0 == "1" || $0 == "0")}) else {return false}
            matrixTmp1.append(elements.map { $0 == "1" })
        }

        // проверка пробела
        guard lines[countRow + 1] == "" else {return false}

        // проверка 2й матрицы
        for index in countRow+2...(countRow + 2) + countRow - 1 {
            let elements = lines[index].components(separatedBy: " ")
            guard elements.count == countColumn,
                  elements.allSatisfy({Int($0) != nil && ($0 == "1" || $0 == "0")}) else {return false}
            matrixTmp2.append(elements.map { $0 == "1" })
        }

        setValue(matrixTmp1, matrixTmp2)

        return result
    }

    // Доп функция (установка значений)
    private func setValue(_ arrTmp1: [[Bool]], _ arrTmp2: [[Bool]]) {
        self.countRow = arrTmp1.count
        self.countColumn = arrTmp1[0].count
        self.verticalWalls = arrTmp1
        self.horizontalWalls = arrTmp2
        self.dotSizeX = self.size / countColumn
        self.dotSizeY = self.size / countRow
        self.isLoad = true
        self.isLoadPath = false
    }
}
