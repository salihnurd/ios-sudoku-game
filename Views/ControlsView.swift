import SwiftUI

struct ControlsView: View {
    @ObservedObject var viewModel: SudokuGameViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            ControlButton(
                icon: "arrow.uturn.backward",
                label: "Geri Al",
                isEnabled: viewModel.game.canUndo()
            ) {
                viewModel.undo()
            }
            
            ControlButton(
                icon: "arrow.uturn.forward",
                label: "İleri Al",
                isEnabled: viewModel.game.canRedo()
            ) {
                viewModel.redo()
            }
            
            ControlButton(
                icon: "lightbulb.fill",
                label: "İpucu",
                isEnabled: true
            ) {
                viewModel.useHint()
            }
            
            ControlButton(
                icon: "trash",
                label: "Temizle",
                isEnabled: viewModel.game.selectedCell != nil && canModifySelectedCell()
            ) {
                viewModel.clearSelectedCell()
            }
        }
    }
    
    private func canModifySelectedCell() -> Bool {
        guard let selected = viewModel.game.selectedCell else { return false }
        return viewModel.game.canModifyCell(selected.row, selected.col)
    }
}

struct ControlButton: View {
    let icon: String
    let label: String
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.title2)
                Text(label)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(isEnabled ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
            .cornerRadius(8)
        }
        .disabled(!isEnabled)
        .foregroundColor(isEnabled ? .blue : .gray)
    }
}

struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView(viewModel: SudokuGameViewModel())
            .padding()
    }
}
