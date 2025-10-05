# Code Structure and Architecture

## Overview
This document explains the architecture and design decisions of the iOS Sudoku Game.

## MVVM Architecture

### Model Layer (`Models/`)
**SudokuGame.swift** - Core game logic
- `SudokuGame` class: Main game model
  - Manages the 9x9 grid state
  - Handles puzzle generation using backtracking algorithm
  - Implements validation logic for rows, columns, and 3x3 boxes
  - Maintains move history for undo/redo functionality
  - Provides hint system by revealing solution cells

#### Key Algorithms:
1. **Puzzle Generation**:
   ```swift
   fillGrid() -> Bool
   ```
   - Uses recursive backtracking to create a valid complete Sudoku solution
   - Randomly shuffles numbers 1-9 for variety
   - Ensures valid placement at each step

2. **Solution Uniqueness**:
   ```swift
   countSolutions() -> Int
   ```
   - Counts possible solutions (stops at 2 for efficiency)
   - Ensures puzzle has exactly one solution
   - Used during cell removal phase

3. **Validation**:
   ```swift
   isValidPlacement() -> Bool
   ```
   - Checks row uniqueness
   - Checks column uniqueness
   - Checks 3x3 box uniqueness

### ViewModel Layer (`ViewModels/`)
**SudokuGameViewModel.swift** - State management and business logic
- `SudokuGameViewModel` class: Connects model to views
  - Manages game timing with Timer
  - Calculates scores based on time, difficulty, and hints
  - Handles game lifecycle (start, pause, complete)
  - Provides formatted data for UI display
  - Uses Combine framework for reactive updates

#### Scoring Formula:
```
Final Score = Base (1000) 
            + Difficulty Bonus (100/300/500)
            + Time Bonus (up to 600, decreasing over 10 min)
            - Hint Penalty (50 per hint)
```

### View Layer (`Views/`)

#### ContentView.swift
Main game coordinator view
- Manages navigation between menu and game
- Displays completion alert dialog
- Hosts main game view

#### MenuView.swift
Main menu interface
- Displays app title and logo
- Shows difficulty selection buttons
- Presents game features list
- Gradient background for visual appeal

#### SudokuGridView.swift
Interactive 9x9 Sudoku grid
- Renders 81 cells in a grid layout
- Draws grid lines (thick for 3x3 boxes)
- Handles cell selection tap gestures
- Provides visual feedback:
  - Blue highlight for selected cell
  - Red highlight for invalid cells
  - Blue text for initial clues
  - Bold font for initial numbers

#### NumberInputView.swift
Number input panel
- Displays buttons 1-9 in two rows (5+4)
- Disabled when no cell is selected
- Disabled for initial cells (clues)
- Enters numbers into selected cell

#### ControlsView.swift
Game control buttons
- **Undo**: Reverts last move (disabled when no history)
- **Redo**: Restores undone move (disabled when no redo stack)
- **Hint**: Reveals correct number for random empty cell
- **Clear**: Deletes selected cell value (disabled for clues)

### Service Layer (`Services/`)

#### GameDataService.swift
Data persistence service (ready for future use)
- Structures for saving game state
- Structures for tracking statistics
- UserDefaults integration for local storage
- Singleton pattern for global access

## Data Flow

### Game Start Flow:
1. User selects difficulty in `MenuView`
2. `ViewModel` creates new `SudokuGame` instance
3. Model generates puzzle using backtracking
4. Model removes cells based on difficulty
5. ViewModel starts timer
6. Views update to show game screen

### Cell Input Flow:
1. User taps cell in `SudokuGridView`
2. ViewModel updates selected cell
3. User taps number in `NumberInputView`
4. ViewModel calls model's `setNumber()`
5. Model creates move, updates grid
6. Model validates placement
7. Views update with new state
8. Invalid cells highlighted in red

### Undo Flow:
1. User taps undo in `ControlsView`
2. ViewModel calls model's `undo()`
3. Model pops move from history
4. Model reverts grid change
5. Model pushes move to redo stack
6. Model revalidates grid
7. Views update

### Completion Flow:
1. User fills last cell
2. Model validates all cells
3. Model sets `isComplete = true`
4. ViewModel observes change
5. ViewModel stops timer
6. ViewModel calculates final score
7. ViewModel shows completion dialog
8. User can start new game or return to menu

## SwiftUI Features Used

### State Management:
- `@StateObject`: For ViewModel lifecycle in ContentView
- `@ObservedObject`: For ViewModel in child views
- `@Published`: For reactive properties in ViewModel and Model

### Combine Framework:
- `Publisher`: For observing game completion
- `sink`: For handling completion events
- `AnyCancellable`: For subscription management

### UI Components:
- `GeometryReader`: For responsive grid sizing
- `Path`: For drawing grid lines
- `ZStack`: For layering grid elements
- `Button`: For interactive controls
- `Alert`: For completion dialog
- `LinearGradient`: For menu background

### Layout:
- `VStack`/`HStack`: For arranging elements
- `Spacer`: For flexible spacing
- `padding()`: For margins
- `frame()`: For sizing
- `aspectRatio()`: For square grid

## Turkish Localization

All user-facing text is in Turkish:
- **Kolay** - Easy
- **Orta** - Medium  
- **Zor** - Hard
- **Geri Al** - Undo
- **İleri Al** - Redo
- **İpucu** - Hint
- **Temizle** - Clear
- **Tebrikler** - Congratulations

## Performance Considerations

### Puzzle Generation:
- Maximum attempts limit (1000) to prevent infinite loops
- Early termination when counting solutions (stops at 2)
- Efficient backtracking with random number shuffling

### UI Updates:
- SwiftUI automatically optimizes redraws
- Only modified cells trigger updates
- Grid lines drawn once, cells updated independently

### Memory Management:
- Timer properly invalidated in deinit
- Cancellables stored and cleaned up
- No retain cycles in closures (weak self)

## Future Extensibility

The architecture supports easy addition of:
1. **Persistence**: GameDataService ready for save/load
2. **Statistics**: Structure already defined
3. **Themes**: Color scheme easily customizable
4. **Animations**: SwiftUI transitions can be added
5. **Sound**: Audio can be added to actions
6. **Multiplayer**: Architecture supports multiple game instances
7. **Difficulty Customization**: Empty cells easily adjustable
8. **Localization**: String extraction ready for i18n

## Testing Strategy

Suggested test coverage:
1. **Unit Tests**: Model logic (validation, generation)
2. **Integration Tests**: ViewModel interactions
3. **UI Tests**: User flows and navigation
4. **Performance Tests**: Puzzle generation speed
5. **Validation Tests**: Solution uniqueness

## Best Practices Applied

- ✅ MVVM separation of concerns
- ✅ Protocol-oriented design (ready for protocols)
- ✅ Dependency injection (ViewModel accepts model)
- ✅ Single responsibility principle
- ✅ DRY (Don't Repeat Yourself)
- ✅ Clear naming conventions
- ✅ Type safety (no force unwraps except where safe)
- ✅ Memory safety (weak self in closures)
- ✅ SwiftUI best practices
- ✅ Combine for reactive programming
