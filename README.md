# iOS Sudoku Game 🎮

A fully functional iOS Sudoku game built with SwiftUI, featuring automatic puzzle generation, multiple difficulty levels, and a comprehensive scoring system.

## Features ✨

### Core Game Features
- **9x9 Interactive Grid**: Touch-based cell selection with visual feedback
- **Automatic Puzzle Generation**: Unique puzzles with guaranteed single solutions using backtracking algorithm
- **Three Difficulty Levels**:
  - Kolay (Easy): 40 empty cells
  - Orta (Medium): 50 empty cells
  - Zor (Hard): 60 empty cells
- **Real-time Validation**: Instant visual feedback for invalid moves
- **Game Completion Detection**: Automatic win detection with celebration dialog

### Advanced Features
- **Smart Hint System**: Reveals correct numbers for random empty cells
- **Unlimited Undo/Redo**: Complete move history tracking
- **Live Timer**: Real-time elapsed time tracking
- **Advanced Scoring System**:
  - Base score: 1000 points
  - Time bonus: Up to 600 points (decreases over 10 minutes)
  - Hint penalty: -50 points per hint
  - Difficulty bonus: Easy +100, Medium +300, Hard +500

### User Interface
- **Modern SwiftUI Design**: Native iOS look and feel
- **Dark/Light Mode Support**: Automatic theme switching
- **Responsive Layout**: Optimized for iPhone and iPad
- **Interactive Grid Features**:
  - Selected cell highlighting (blue overlay)
  - Error indication (red background)
  - Initial cell protection (blue text, bold)
  - 3x3 box separation with thick borders

### Game Controls
- **Number Input Panel**: 1-9 buttons for easy number entry
- **Control Buttons**:
  - Geri Al (Undo): Revert last move
  - İleri Al (Redo): Restore undone move
  - İpucu (Hint): Get a hint for an empty cell
  - Temizle (Clear): Delete selected cell value

## Architecture 🏗️

The project follows the MVVM (Model-View-ViewModel) pattern for clean separation of concerns:

```
SudokuGame/
├── SudokuGameApp.swift          # Main app entry point
├── Models/
│   └── SudokuGame.swift         # Core game logic and puzzle generation
├── ViewModels/
│   └── SudokuGameViewModel.swift # State management, timer, scoring
├── Views/
│   ├── ContentView.swift        # Main game view coordinator
│   ├── SudokuGridView.swift     # Interactive 9x9 grid component
│   ├── ControlsView.swift       # Game control buttons
│   ├── NumberInputView.swift    # Number input panel
│   └── MenuView.swift           # Main menu and difficulty selection
└── Services/
    └── GameDataService.swift    # Data persistence (future feature)
```

## Technical Details 🔧

### Puzzle Generation Algorithm
1. Creates a complete valid Sudoku solution using recursive backtracking
2. Randomly removes cells based on selected difficulty level
3. Ensures unique solution by counting possible solutions (stops at 2)
4. Maintains game balance and solvability

### Validation System
Comprehensive validation checks for:
- **Row Uniqueness**: No duplicate numbers 1-9 in any row
- **Column Uniqueness**: No duplicate numbers 1-9 in any column
- **3x3 Box Uniqueness**: No duplicate numbers 1-9 in any 3x3 sub-grid
- **Real-time Feedback**: Immediate visual indication of invalid placements
- **Solution Verification**: Automatic detection when puzzle is correctly solved

### Technologies Used
- **SwiftUI**: Modern declarative UI framework
- **Combine**: Reactive programming for state management
- **ObservableObject**: View model state management
- **Foundation**: Core Swift functionality

## Requirements 📋

- iOS 14.0+
- Xcode 12.0+
- Swift 5.0+

## Installation 🚀

1. Clone the repository:
```bash
git clone https://github.com/salihnurd/ios-sudoku-game.git
```

2. Open in Xcode:
```bash
cd ios-sudoku-game
open SudokuGame.xcodeproj
```

3. Build and run on simulator or device

## Usage 💡

### Starting a New Game
1. Launch the app to see the main menu
2. Select a difficulty level (Kolay, Orta, or Zor)
3. The game starts immediately with a new puzzle

### Playing the Game
1. Tap any empty cell to select it
2. Use the number buttons (1-9) to enter a value
3. Invalid entries will be highlighted in red
4. Use control buttons to undo, redo, get hints, or clear cells

### Game Controls
- **Geri Al**: Undo your last move
- **İleri Al**: Redo an undone move
- **İpucu**: Get a hint (reveals correct number for a random empty cell)
- **Temizle**: Clear the selected cell

### Winning
- Complete the puzzle with all valid numbers
- View your final score and time
- Choose to start a new game or return to menu

## Game Rules 📖

1. Fill the 9x9 grid with digits 1-9
2. Each row must contain all digits 1-9 without repetition
3. Each column must contain all digits 1-9 without repetition
4. Each 3x3 box must contain all digits 1-9 without repetition
5. Blue numbers are initial clues and cannot be modified

## Scoring System 🏆

Your final score is calculated based on:
- **Base Score**: 1000 points
- **Difficulty Bonus**: 100 (Easy), 300 (Medium), 500 (Hard)
- **Time Bonus**: Up to 600 points (best if completed within 10 minutes)
- **Hint Penalty**: -50 points per hint used

## Future Enhancements 🔮

- [ ] Game state persistence (save/load)
- [ ] Statistics tracking across multiple games
- [ ] Daily challenge mode
- [ ] Leaderboard integration
- [ ] Custom color themes
- [ ] Sound effects and animations
- [ ] Accessibility improvements
- [ ] Apple Pencil support for iPad
- [ ] Game Center achievements

## Contributing 🤝

Contributions are welcome! Please feel free to submit a Pull Request.

## License 📄

This project is available under the MIT License.

## Author ✍️

Created with ❤️ by salihnurd

## Acknowledgments 🙏

- SwiftUI framework by Apple
- Turkish localization for user interface
- Classic Sudoku puzzle game concept
