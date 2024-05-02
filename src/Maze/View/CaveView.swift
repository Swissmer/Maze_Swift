import SwiftUI

struct CaveView: View {
    @ObservedObject var cave = CaveViewModel.shared

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<cave.countRow, id: \.self) { yTmp in
                HStack(spacing: 0) {
                    ForEach(0..<cave.countColumn, id: \.self) { xTmp in
                        Rectangle()
                            .fill(cave.matrix[yTmp][xTmp] == true ? Color.black : Color.white)
                            .frame(width: CGFloat(cave.dotSizeX), height: CGFloat(cave.dotSizeY))
                    }
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .frame(width: CGFloat(cave.size), height: CGFloat(cave.size))
        .padding()
        .onReceive(cave.timer) { _ in
            cave.updateGame()
        }
        .onChange(of: cave.nextTap) {
            cave.updateGame()
        }
    }
}
