import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SudokuGameViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.showMenu {
                MenuView(viewModel: viewModel)
            } else {
                GameView(viewModel: viewModel)
            }
        }
        .alert("Tebrikler! 🎉", isPresented: $viewModel.showCompletionDialog) {
            Button("Yeni Oyun") {
                viewModel.returnToMenu()
            }
            Button("Menüye Dön") {
                viewModel.returnToMenu()
            }
        } message: {
            Text("Puzzle'ı tamamladınız!\n\nSüre: \(viewModel.formattedTime())\nSkor: \(viewModel.score)")
        }
    }
}

struct GameView: View {
    @ObservedObject var viewModel: SudokuGameViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            // Header
            HStack {
                Button(action: {
                    viewModel.returnToMenu()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    HStack {
                        Image(systemName: "clock")
                        Text(viewModel.formattedTime())
                            .font(.headline)
                    }
                    HStack {
                        Image(systemName: "lightbulb.fill")
                        Text("İpucu: \(viewModel.game.hintsUsed)")
                            .font(.subheadline)
                    }
                }
            }
            .padding()
            
            // Sudoku Grid
            SudokuGridView(viewModel: viewModel)
                .aspectRatio(1, contentMode: .fit)
                .padding(.horizontal)
            
            // Controls
            ControlsView(viewModel: viewModel)
                .padding(.horizontal)
            
            // Number Input
            NumberInputView(viewModel: viewModel)
                .padding(.horizontal)
            
            Spacer()
        }
        .background(Color(UIColor.systemBackground))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
