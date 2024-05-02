import SwiftUI

struct SideBarView: View {
    var maze = Maze.shared
    // Переменные для View
    @State var rowValue = ""
    @State var columnValue = ""
    @State var x1Value = ""
    @State var x2Value = ""
    @State var y1Value = ""
    @State var y2Value = ""
    @State private var openFile = false

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
                    maze.generateMaze(rows: rowValue, cols: columnValue)
                }
                Spacer()
            }
            Divider()
            Form {
                HStack {
                    TextField("x1:", text: $x1Value)
                    TextField("y1:", text: $y1Value)
                }
                HStack {
                    TextField("x2:", text: $x2Value)
                    TextField("y2:", text: $y2Value)
                }
            }
            HStack {
                Spacer()
                Button("Search") {
                    maze.searchPath(x1: x1Value, y1: y1Value, x2: x2Value, y2: y2Value)
                }
                Spacer()
            }
        }.listStyle(.sidebar)
            .fileImporter(isPresented: $openFile, allowedContentTypes: [.text], onCompletion: { result in
                maze.openFile(result)
            })
    }
}
