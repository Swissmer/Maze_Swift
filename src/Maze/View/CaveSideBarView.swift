import SwiftUI

struct CaveSideBarView: View {
    var cave = CaveViewModel.shared
    // Переменные для View
    @State private var openFile = false
    @State var rowValue = ""
    @State var columnValue = ""
    @State var birthCount = ""
    @State var deathCount = ""
    @State var stepValue = ""

    var body: some View {
        List {
            HStack {
                Spacer()
                Button("Open File") {
                    openFile.toggle()
                }
                Spacer()
            }
            Divider()
            Form {
                TextField("Row:", text: $rowValue)
                TextField("Column", text: $columnValue)
            }
            HStack {
                Spacer()
                Button("Generate") {
                    print("Результат генерации:", cave.generateCave(row: rowValue, column: columnValue))
                }
                Spacer()
            }
            Divider()
            Form {
                TextField("Birth", text: $birthCount)
                TextField("Death", text: $deathCount)
                HStack {
                    TextField("Step:", text: $stepValue)
                    Text("milliseconds")
                }
            }
            HStack {
                Spacer()
                Button("Auto") {
                    cave.startGame(step: stepValue, birth: birthCount, death: deathCount)
                }
                Button("Stop") {
                    cave.stopGame()
                }
                Button("Next") {
                    cave.nextGame(birth: birthCount, death: deathCount)
                }
                Spacer()
            }
        }.listStyle(.sidebar)
            .fileImporter(isPresented: $openFile, allowedContentTypes: [.text], onCompletion: { result in
                cave.openFile(result)
            })
    }
}
