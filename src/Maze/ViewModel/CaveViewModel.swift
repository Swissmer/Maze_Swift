import Combine
import SwiftUI

final class CaveViewModel: ObservableObject {
    static var shared = CaveViewModel()
    // модель
    private var model = CaveModel()
    // из модели
    @Published var matrix: [[Bool]] = [[]]
    @Published var countRow: Int = 0
    @Published var countColumn: Int = 0
    @Published var birth: Int = 0
    @Published var death: Int = 0
    // для view
    @Published var isLoad = true
    @Published var dotSizeX: Int = 0
    @Published var dotSizeY: Int = 0
    @Published var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    = .init(upstream: Timer.TimerPublisher(interval: .infinity, runLoop: .main, mode: .common))
    @Published var nextTap: Bool = false
    // размеры окна
    public let size: Int = 500

    private init() {}

    // Открываем файл
    public func openFile(_ result: Result<URL, any Error>) {
        do {
            let fileUrl = try result.get()
            if fileUrl.startAccessingSecurityScopedResource() {
                defer {fileUrl.stopAccessingSecurityScopedResource()}
                print("Результат валидации:", validateCaveData(from: (try String(contentsOf: fileUrl))))
            } else {
                print("Доступ к файлу закрыт!")
            }
        } catch {
            print(error)
        }
    }

    // Генерация пещеры
    func generateCave(row: String, column: String) -> Bool {
        guard let rowTmp = Int(row), rowTmp <= 50, rowTmp > 0,
              let columnTmp = Int(column), columnTmp <= 50, columnTmp > 0 else {return false}

        let matrixTmp = model.generateCave(row: rowTmp, column: columnTmp)
        setValue(matrixTmp, rowTmp, columnTmp)

        return true
    }

    // Нажал auto
    func startGame(step: String, birth: String, death: String) {
        if let stepValue = Double(step), let birthValue = Int(birth), let deathValue = Int(death), !isLoad {
            self.birth = birthValue
            self.death = deathValue
            timer = Timer.publish(every: stepValue, on: .main, in: .common).autoconnect()
        }
    }

    // Нажал stop
    func stopGame() {
        timer.upstream.connect().cancel()
        timer = .init(upstream: Timer.TimerPublisher(interval: .infinity, runLoop: .main, mode: .common))
    }

    // Нажал next
    func nextGame(birth: String, death: String) {
        if !isLoad, let birthValue = Int(birth), let deathValue = Int(death) {
            self.birth = birthValue
            self.death = deathValue
            nextTap.toggle()
        }
    }

    // Обновление игры
    func updateGame() {
        var newMatrix = self.matrix
        for yTmp in 0..<countRow {
            for xTmp in 0..<countColumn {
                newMatrix[yTmp][xTmp]
                = model.countNeighbors(matrix: self.matrix, xValue: xTmp, yValue: yTmp, death: death, birth: birth)
            }
        }
        self.matrix = newMatrix
    }

    // Проверка данных из файла
    private func validateCaveData(from fileContent: String) -> Bool {
        // этап загрузки
        self.isLoad = true
        // рабочая матрицы
        var matrixTmp: [[Bool]] = []

        let lines = fileContent.components(separatedBy: .newlines)
        let firstLine = lines[0].components(separatedBy: " ")

        guard lines[0].components(separatedBy: " ").count == 2,
              let countRow = Int(firstLine[0]), lines.count == countRow + 1,
              let countColumn = Int(firstLine[1]),
              countColumn <= 50, countRow <= 50 else {return false}
        // проверка 1й матрицы
        for index in 1...countRow {
            let elements = lines[index].components(separatedBy: " ")
            guard elements.count == countColumn,
                  elements.allSatisfy({Int($0) != nil && ($0 == "1" || $0 == "0")}) else {return false}
            matrixTmp.append(elements.map { $0 == "1" })
        }
        setValue(matrixTmp, countRow, countColumn)
        return true
    }

    // Доп функция
    private func setValue(_ matrixTmp: [[Bool]], _ countRow: Int, _ countColumn: Int) {
        self.matrix = matrixTmp
        self.countRow = countRow
        self.countColumn = countColumn
        self.dotSizeX = self.size / countColumn
        self.dotSizeY = self.size / countRow
        self.isLoad = false
    }
}
