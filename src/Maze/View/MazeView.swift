import SwiftUI

struct MazeView: View {
    @ObservedObject var maze = Maze.shared

    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                if maze.isLoad {
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        path.addLine(to: CGPoint(x: 0, y: 0))
                        path.addLine(to: CGPoint(x: maze.size, y: 0))
                        path.addLine(to: CGPoint(x: maze.size, y: maze.size))
                        path.addLine(to: CGPoint(x: 0, y: maze.size))
                        path.addLine(to: CGPoint(x: 0, y: 0))
                    }
                    .stroke(.black, lineWidth: 2)
                    Path { path in
                        for valueY in 0..<maze.countRow {
                            for valueX in 0..<maze.countColumn {
                                if self.maze.verticalWalls[valueY][valueX] {
                                    let wallPosX = CGFloat(maze.dotSizeX * (valueX + 1))
                                    let wallPosY = CGFloat(maze.dotSizeY * (valueY + 1))
                                    path.move(to: CGPoint(x: wallPosX, y: wallPosY))
                                    path.addLine(to: CGPoint(x: wallPosX, y: wallPosY - CGFloat(maze.dotSizeY)))
                                }

                                if self.maze.horizontalWalls[valueY][valueX] {
                                    let wallPosX = CGFloat(maze.dotSizeX * (valueX + 1))
                                    let wallPosY = CGFloat(maze.dotSizeY * (valueY + 1))
                                    path.move(to: CGPoint(x: wallPosX, y: wallPosY))
                                    path.addLine(to: CGPoint(x: wallPosX - CGFloat(maze.dotSizeX), y: wallPosY))
                                }
                            }
                        }
                    }.stroke(.black, lineWidth: 2)
                        .frame(width: CGFloat(maze.size), height: CGFloat(maze.size))

                    if maze.isLoadPath {
                        Path { path in
                            let startDrawPosX = CGFloat(maze.path[0].x * maze.dotSizeX + maze.dotSizeX / 2)
                            let startDrawPosY = CGFloat(maze.path[0].y * maze.dotSizeY + maze.dotSizeY / 2)
                            path.move(to: CGPoint(x: startDrawPosX, y: startDrawPosY))
                            for i in maze.path {
                                let nextDrawPosX = CGFloat(i.x * maze.dotSizeX + maze.dotSizeX / 2)
                                let nextDrawPosY = CGFloat(i.y * maze.dotSizeY + maze.dotSizeY / 2)
                                path.addLine(to: CGPoint(x: nextDrawPosX, y: nextDrawPosY))
                            }
                        }
                        .stroke(.red, lineWidth: 2)
                        .frame(width: CGFloat(maze.size), height: CGFloat(maze.size))
                    }
                }
            }
            .frame(width: CGFloat(maze.size), height: CGFloat(maze.size))
            .padding()
        }
    }
}
