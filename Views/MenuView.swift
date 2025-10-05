import SwiftUI

struct MenuView: View {
    @ObservedObject var viewModel: SudokuGameViewModel
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                // Title
                VStack(spacing: 8) {
                    Image(systemName: "square.grid.3x3.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    
                    Text("Sudoku")
                        .font(.system(size: 48, weight: .bold))
                    
                    Text("Klasik Bulmaca Oyunu")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Difficulty Selection
                VStack(spacing: 20) {
                    Text("Zorluk Seviyesi Seç")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    ForEach(Difficulty.allCases, id: \.self) { difficulty in
                        DifficultyButton(
                            difficulty: difficulty,
                            action: {
                                viewModel.startNewGame(difficulty: difficulty)
                            }
                        )
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer()
                
                // Info
                VStack(spacing: 8) {
                    InfoRow(icon: "star.fill", text: "Benzersiz puzzle'lar")
                    InfoRow(icon: "lightbulb.fill", text: "İpucu sistemi")
                    InfoRow(icon: "clock.fill", text: "Süre takibi")
                    InfoRow(icon: "arrow.uturn.backward", text: "Geri alma özelliği")
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
        }
    }
}

struct DifficultyButton: View {
    let difficulty: Difficulty
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(difficulty.rawValue)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("\(difficulty.emptyCells) boş hücre")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Image(systemName: "chevron.right")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
        .foregroundColor(.primary)
    }
}

struct InfoRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24)
            Text(text)
                .font(.subheadline)
            Spacer()
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(viewModel: SudokuGameViewModel())
    }
}
