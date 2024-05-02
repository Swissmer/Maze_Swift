import SwiftUI

struct ContentView: View {
    // Показ бокового меню
    @State private var inspectorActive = true
    // Переменные для ToolBar
    @State private var selectedView = "Maze"
    let listView = ["Maze", "Сave"]

    var body: some View {
        Group {
            if selectedView == "Maze" {
                MazeView()
            } else {
                CaveView()
            }
        }
        .padding()
        .toolbar(content: {
            ToolbarItem(placement: .status) {
                HStack {
                    Text("Type:")
                    Picker("", selection: $selectedView) {
                        ForEach(listView, id: \.self) { color in
                            Text(color)
                        }
                    }
                }
            }
            ToolbarItem {
                Spacer()
            }
            ToolbarItem {
                Button(action: {
                    inspectorActive.toggle()
                }, label: {
                    Label("Option", systemImage: "sidebar.right")
                })
            }
        })
        .inspector(isPresented: $inspectorActive) {
            if selectedView == "Maze" {
                SideBarView()
            } else {
                CaveSideBarView()
            }
        }
    }
}
