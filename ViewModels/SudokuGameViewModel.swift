import Foundation
import Combine
import SwiftUI

class SudokuGameViewModel: ObservableObject {
    @Published var game: SudokuGame
    @Published var elapsedTime: Int = 0
    @Published var score: Int = 0
    @Published var showCompletionDialog: Bool = false
    @Published var showMenu: Bool = true
    
    private var timer: Timer?
    private var cancellables = Set<AnyCancellable>()
    private let baseScore = 1000
    private let maxTimeBonus = 600
    private let maxBonusTime = 600 // 10 minutes
    private let hintPenalty = 50
    
    init() {
        self.game = SudokuGame(difficulty: .easy)
        setupObservers()
    }
    
    // MARK: - Setup
    private func setupObservers() {
        game.$isComplete
            .sink { [weak self] isComplete in
                if isComplete {
                    self?.handleGameCompletion()
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Timer Management
    func startTimer() {
        stopTimer()
        elapsedTime = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.elapsedTime += 1
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func pauseTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func resumeTimer() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.elapsedTime += 1
        }
    }
    
    // MARK: - Score Calculation
    func calculateScore() -> Int {
        var finalScore = baseScore
        
        // Add difficulty bonus
        finalScore += game.difficulty.bonus
        
        // Add time bonus (decreases as time increases)
        if elapsedTime < maxBonusTime {
            let timeBonus = Int(Double(maxTimeBonus) * (1.0 - Double(elapsedTime) / Double(maxBonusTime)))
            finalScore += timeBonus
        }
        
        // Subtract hint penalty
        finalScore -= game.hintsUsed * hintPenalty
        
        return max(finalScore, 0)
    }
    
    // MARK: - Game Actions
    func startNewGame(difficulty: Difficulty) {
        stopTimer()
        game = SudokuGame(difficulty: difficulty)
        elapsedTime = 0
        score = 0
        showCompletionDialog = false
        showMenu = false
        startTimer()
        setupObservers()
    }
    
    func selectCell(row: Int, col: Int) {
        game.selectedCell = (row, col)
    }
    
    func enterNumber(_ number: Int) {
        guard let selected = game.selectedCell else { return }
        game.setNumber(selected.row, selected.col, number)
    }
    
    func clearSelectedCell() {
        guard let selected = game.selectedCell else { return }
        game.clearCell(selected.row, selected.col)
    }
    
    func useHint() {
        game.getHint()
    }
    
    func undo() {
        game.undo()
    }
    
    func redo() {
        game.redo()
    }
    
    // MARK: - Game Completion
    private func handleGameCompletion() {
        stopTimer()
        score = calculateScore()
        showCompletionDialog = true
    }
    
    func returnToMenu() {
        stopTimer()
        showMenu = true
        showCompletionDialog = false
    }
    
    // MARK: - Formatting Helpers
    func formattedTime() -> String {
        let hours = elapsedTime / 3600
        let minutes = (elapsedTime % 3600) / 60
        let seconds = elapsedTime % 60
        
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%d:%02d", minutes, seconds)
        }
    }
    
    deinit {
        stopTimer()
    }
}
