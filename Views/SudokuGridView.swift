import SwiftUI

struct SudokuGridView: View {
    @ObservedObject var viewModel: SudokuGameViewModel
    
    var body: some View {
        GeometryReader { geometry in
            let cellSize = min(geometry.size.width, geometry.size.height) / 9
            
            ZStack {
                // Background
                Rectangle()
                    .fill(Color(UIColor.systemBackground))
                
                // Grid lines
                ForEach(0..<10) { index in
                    // Horizontal lines
                    Path { path in
                        let y = CGFloat(index) * cellSize
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: cellSize * 9, y: y))
                    }
                    .stroke(lineWidth: index % 3 == 0 ? 3 : 1)
                    .foregroundColor(index % 3 == 0 ? .primary : .gray)
                    
                    // Vertical lines
                    Path { path in
                        let x = CGFloat(index) * cellSize
                        path.move(to: CGPoint(x: x, y: 0))
                        path.addLine(to: CGPoint(x: x, y: cellSize * 9))
                    }
                    .stroke(lineWidth: index % 3 == 0 ? 3 : 1)
                    .foregroundColor(index % 3 == 0 ? .primary : .gray)
                }
                
                // Cells
                ForEach(0..<9) { row in
                    ForEach(0..<9) { col in
                        SudokuCellView(
                            value: viewModel.game.grid[row][col],
                            isInitial: viewModel.game.initialGrid[row][col] != 0,
                            isSelected: viewModel.game.selectedCell?.row == row && viewModel.game.selectedCell?.col == col,
                            isInvalid: viewModel.game.invalidCells.contains("\(row)-\(col)"),
                            cellSize: cellSize
                        )
                        .position(
                            x: CGFloat(col) * cellSize + cellSize / 2,
                            y: CGFloat(row) * cellSize + cellSize / 2
                        )
                        .onTapGesture {
                            viewModel.selectCell(row: row, col: col)
                        }
                    }
                }
            }
            .frame(width: cellSize * 9, height: cellSize * 9)
        }
    }
}

struct SudokuCellView: View {
    let value: Int
    let isInitial: Bool
    let isSelected: Bool
    let isInvalid: Bool
    let cellSize: CGFloat
    
    var body: some View {
        ZStack {
            // Background
            Rectangle()
                .fill(backgroundColor)
                .frame(width: cellSize - 1, height: cellSize - 1)
            
            // Value
            if value != 0 {
                Text("\(value)")
                    .font(.system(size: cellSize * 0.5, weight: isInitial ? .bold : .regular))
                    .foregroundColor(textColor)
            }
        }
    }
    
    private var backgroundColor: Color {
        if isInvalid {
            return Color.red.opacity(0.3)
        } else if isSelected {
            return Color.blue.opacity(0.2)
        } else if isInitial {
            return Color.blue.opacity(0.1)
        } else {
            return Color.clear
        }
    }
    
    private var textColor: Color {
        if isInvalid {
            return .red
        } else if isInitial {
            return .blue
        } else {
            return .primary
        }
    }
}

struct SudokuGridView_Previews: PreviewProvider {
    static var previews: some View {
        SudokuGridView(viewModel: SudokuGameViewModel())
            .frame(width: 350, height: 350)
    }
}
