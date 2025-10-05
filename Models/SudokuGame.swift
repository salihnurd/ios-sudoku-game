import Foundation

// MARK: - Difficulty Level
enum Difficulty: String, CaseIterable {
    case easy = "Kolay"
    case medium = "Orta"
    case hard = "Zor"
    
    var emptyCells: Int {
        switch self {
        case .easy: return 40
        case .medium: return 50
        case .hard: return 60
        }
    }
    
    var bonus: Int {
        switch self {
        case .easy: return 100
        case .medium: return 300
        case .hard: return 500
        }
    }
}

// MARK: - Move History
struct Move: Equatable {
    let row: Int
    let col: Int
    let oldValue: Int
    let newValue: Int
}

// MARK: - Sudoku Game Model
class SudokuGame: ObservableObject {
    @Published var grid: [[Int]]
    @Published var initialGrid: [[Int]]
    @Published var selectedCell: (row: Int, col: Int)?
    @Published var invalidCells: Set<String> = []
    @Published var isComplete: Bool = false
    @Published var hintsUsed: Int = 0
    
    private var solution: [[Int]]
    var moveHistory: [Move] = []
    private var redoStack: [Move] = []
    
    let difficulty: Difficulty
    
    init(difficulty: Difficulty = .easy) {
        self.difficulty = difficulty
        self.grid = Array(repeating: Array(repeating: 0, count: 9), count: 9)
        self.initialGrid = Array(repeating: Array(repeating: 0, count: 9), count: 9)
        self.solution = Array(repeating: Array(repeating: 0, count: 9), count: 9)
        generatePuzzle()
    }
    
    // MARK: - Puzzle Generation
    func generatePuzzle() {
        // Generate complete solution
        solution = Array(repeating: Array(repeating: 0, count: 9), count: 9)
        fillGrid(&solution)
        
        // Copy solution to grid
        grid = solution.map { $0 }
        
        // Remove cells based on difficulty
        var cellsToRemove = difficulty.emptyCells
        var attempts = 0
        let maxAttempts = 1000
        
        while cellsToRemove > 0 && attempts < maxAttempts {
            let row = Int.random(in: 0..<9)
            let col = Int.random(in: 0..<9)
            
            if grid[row][col] != 0 {
                let backup = grid[row][col]
                grid[row][col] = 0
                
                // Check if puzzle still has unique solution
                var testGrid = grid.map { $0 }
                let solutionCount = countSolutions(&testGrid, 0, 0, 2)
                
                if solutionCount == 1 {
                    cellsToRemove -= 1
                } else {
                    grid[row][col] = backup
                }
            }
            attempts += 1
        }
        
        // Save initial state
        initialGrid = grid.map { $0 }
        moveHistory.removeAll()
        redoStack.removeAll()
        hintsUsed = 0
        isComplete = false
        invalidCells.removeAll()
    }
    
    // MARK: - Grid Filling Algorithm
    private func fillGrid(_ grid: inout [[Int]]) -> Bool {
        for row in 0..<9 {
            for col in 0..<9 {
                if grid[row][col] == 0 {
                    var numbers = Array(1...9)
                    numbers.shuffle()
                    
                    for num in numbers {
                        if isValidPlacement(grid, row, col, num) {
                            grid[row][col] = num
                            
                            if fillGrid(&grid) {
                                return true
                            }
                            
                            grid[row][col] = 0
                        }
                    }
                    return false
                }
            }
        }
        return true
    }
    
    // MARK: - Solution Counting
    private func countSolutions(_ grid: inout [[Int]], _ row: Int, _ col: Int, _ limit: Int) -> Int {
        if row == 9 {
            return 1
        }
        
        let nextRow = col == 8 ? row + 1 : row
        let nextCol = (col + 1) % 9
        
        if grid[row][col] != 0 {
            return countSolutions(&grid, nextRow, nextCol, limit)
        }
        
        var count = 0
        for num in 1...9 {
            if isValidPlacement(grid, row, col, num) {
                grid[row][col] = num
                count += countSolutions(&grid, nextRow, nextCol, limit)
                grid[row][col] = 0
                
                if count >= limit {
                    return count
                }
            }
        }
        return count
    }
    
    // MARK: - Validation
    func isValidPlacement(_ grid: [[Int]], _ row: Int, _ col: Int, _ num: Int) -> Bool {
        // Check row
        for c in 0..<9 {
            if c != col && grid[row][c] == num {
                return false
            }
        }
        
        // Check column
        for r in 0..<9 {
            if r != row && grid[r][col] == num {
                return false
            }
        }
        
        // Check 3x3 box
        let boxRow = (row / 3) * 3
        let boxCol = (col / 3) * 3
        for r in boxRow..<boxRow + 3 {
            for c in boxCol..<boxCol + 3 {
                if (r != row || c != col) && grid[r][c] == num {
                    return false
                }
            }
        }
        
        return true
    }
    
    func validateCurrentState() {
        invalidCells.removeAll()
        
        for row in 0..<9 {
            for col in 0..<9 {
                if grid[row][col] != 0 {
                    if !isValidPlacement(grid, row, col, grid[row][col]) {
                        invalidCells.insert("\(row)-\(col)")
                    }
                }
            }
        }
        
        checkCompletion()
    }
    
    // MARK: - Game Actions
    func setNumber(_ row: Int, _ col: Int, _ number: Int) {
        guard canModifyCell(row, col) else { return }
        
        let oldValue = grid[row][col]
        grid[row][col] = number
        
        let move = Move(row: row, col: col, oldValue: oldValue, newValue: number)
        moveHistory.append(move)
        redoStack.removeAll()
        
        validateCurrentState()
    }
    
    func clearCell(_ row: Int, _ col: Int) {
        guard canModifyCell(row, col) else { return }
        setNumber(row, col, 0)
    }
    
    func canModifyCell(_ row: Int, _ col: Int) -> Bool {
        return initialGrid[row][col] == 0
    }
    
    // MARK: - Undo/Redo
    func canUndo() -> Bool {
        return !moveHistory.isEmpty
    }
    
    func canRedo() -> Bool {
        return !redoStack.isEmpty
    }
    
    func undo() {
        guard let move = moveHistory.popLast() else { return }
        grid[move.row][move.col] = move.oldValue
        redoStack.append(move)
        validateCurrentState()
    }
    
    func redo() {
        guard let move = redoStack.popLast() else { return }
        grid[move.row][move.col] = move.newValue
        moveHistory.append(move)
        validateCurrentState()
    }
    
    // MARK: - Hint System
    func getHint() {
        var emptyCells: [(Int, Int)] = []
        
        for row in 0..<9 {
            for col in 0..<9 {
                if grid[row][col] == 0 && initialGrid[row][col] == 0 {
                    emptyCells.append((row, col))
                }
            }
        }
        
        guard !emptyCells.isEmpty else { return }
        
        let (row, col) = emptyCells.randomElement()!
        setNumber(row, col, solution[row][col])
        hintsUsed += 1
        selectedCell = (row, col)
    }
    
    // MARK: - Completion Check
    func checkCompletion() {
        // Check if grid is full
        for row in 0..<9 {
            for col in 0..<9 {
                if grid[row][col] == 0 {
                    isComplete = false
                    return
                }
            }
        }
        
        // Check if all cells are valid
        isComplete = invalidCells.isEmpty
    }
    
    // MARK: - Game Reset
    func newGame(difficulty: Difficulty? = nil) {
        // This would be handled by creating a new SudokuGame instance
    }
}
