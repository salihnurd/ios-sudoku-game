import Foundation

struct GameState: Codable {
    let grid: [[Int]]
    let initialGrid: [[Int]]
    let difficulty: String
    let elapsedTime: Int
    let hintsUsed: Int
    let moveHistory: [SavedMove]
}

struct SavedMove: Codable {
    let row: Int
    let col: Int
    let oldValue: Int
    let newValue: Int
}

struct GameStatistics: Codable {
    var gamesPlayed: Int = 0
    var gamesWon: Int = 0
    var bestTimeEasy: Int?
    var bestTimeMedium: Int?
    var bestTimeHard: Int?
    var totalScore: Int = 0
    
    mutating func recordWin(difficulty: Difficulty, time: Int, score: Int) {
        gamesPlayed += 1
        gamesWon += 1
        totalScore += score
        
        switch difficulty {
        case .easy:
            if let best = bestTimeEasy {
                bestTimeEasy = min(best, time)
            } else {
                bestTimeEasy = time
            }
        case .medium:
            if let best = bestTimeMedium {
                bestTimeMedium = min(best, time)
            } else {
                bestTimeMedium = time
            }
        case .hard:
            if let best = bestTimeHard {
                bestTimeHard = min(best, time)
            } else {
                bestTimeHard = time
            }
        }
    }
}

class GameDataService {
    static let shared = GameDataService()
    
    private let savedGameKey = "savedGame"
    private let statisticsKey = "gameStatistics"
    
    private init() {}
    
    // MARK: - Game State
    func saveGame(_ game: SudokuGame, elapsedTime: Int) {
        let moves = game.moveHistory.map { move in
            SavedMove(row: move.row, col: move.col, oldValue: move.oldValue, newValue: move.newValue)
        }
        
        let gameState = GameState(
            grid: game.grid,
            initialGrid: game.initialGrid,
            difficulty: game.difficulty.rawValue,
            elapsedTime: elapsedTime,
            hintsUsed: game.hintsUsed,
            moveHistory: moves
        )
        
        if let encoded = try? JSONEncoder().encode(gameState) {
            UserDefaults.standard.set(encoded, forKey: savedGameKey)
        }
    }
    
    func loadGame() -> GameState? {
        guard let data = UserDefaults.standard.data(forKey: savedGameKey),
              let gameState = try? JSONDecoder().decode(GameState.self, from: data) else {
            return nil
        }
        return gameState
    }
    
    func deleteSavedGame() {
        UserDefaults.standard.removeObject(forKey: savedGameKey)
    }
    
    // MARK: - Statistics
    func saveStatistics(_ stats: GameStatistics) {
        if let encoded = try? JSONEncoder().encode(stats) {
            UserDefaults.standard.set(encoded, forKey: statisticsKey)
        }
    }
    
    func loadStatistics() -> GameStatistics {
        guard let data = UserDefaults.standard.data(forKey: statisticsKey),
              let stats = try? JSONDecoder().decode(GameStatistics.self, from: data) else {
            return GameStatistics()
        }
        return stats
    }
}
