import SwiftUI

struct NumberInputView: View {
    @ObservedObject var viewModel: SudokuGameViewModel
    
    private let numbers = Array(1...9)
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 0) {
                ForEach(numbers.prefix(5), id: \.self) { number in
                    NumberButton(number: number) {
                        viewModel.enterNumber(number)
                    }
                }
            }
            
            HStack(spacing: 0) {
                ForEach(numbers.suffix(4), id: \.self) { number in
                    NumberButton(number: number) {
                        viewModel.enterNumber(number)
                    }
                }
            }
        }
        .disabled(viewModel.game.selectedCell == nil || !canModifySelectedCell())
    }
    
    private func canModifySelectedCell() -> Bool {
        guard let selected = viewModel.game.selectedCell else { return false }
        return viewModel.game.canModifyCell(selected.row, selected.col)
    }
}

struct NumberButton: View {
    let number: Int
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("\(number)")
                .font(.system(size: 24, weight: .semibold))
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal, 4)
    }
}

struct NumberInputView_Previews: PreviewProvider {
    static var previews: some View {
        NumberInputView(viewModel: SudokuGameViewModel())
            .padding()
    }
}
