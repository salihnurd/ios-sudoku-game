# Quick Start Guide 🚀

## Prerequisites
- macOS 10.15.4 or later
- Xcode 12.0 or later
- iOS 14.0+ device or simulator

## Setup Instructions

### Option 1: Using Swift Package Manager (SPM)

This project is structured as a SwiftUI app and can be integrated into an Xcode project.

1. **Create a new Xcode project:**
   ```
   File → New → Project → iOS → App
   ```
   - Product Name: SudokuGame
   - Interface: SwiftUI
   - Language: Swift
   - Minimum iOS: 14.0

2. **Copy the files:**
   - Replace the generated `SudokuGameApp.swift` with the one from this repository
   - Copy all folders (`Models/`, `ViewModels/`, `Views/`, `Services/`) into your project
   - Ensure "Copy items if needed" is checked
   - Add to targets: Check your app target

3. **Build and Run:**
   ```
   Product → Run (⌘R)
   ```

### Option 2: Manual Xcode Project Creation

1. **Clone this repository:**
   ```bash
   git clone https://github.com/salihnurd/ios-sudoku-game.git
   cd ios-sudoku-game
   ```

2. **Create Xcode project:**
   ```bash
   # Open Xcode
   # File → New → Project
   # Choose iOS → App
   # Navigate to the cloned directory
   # Use "SudokuGame" as Product Name
   # Ensure the directory contains all Swift files
   ```

3. **Organize files in Xcode:**
   - Drag folders into the navigator
   - Create groups matching the folder structure
   - Ensure all files are in the target

### Option 3: Quick Start Script

Create a new Xcode project and use this terminal script:

```bash
#!/bin/bash

# Navigate to your new Xcode project directory
cd /path/to/your/SudokuGame/project

# Clone this repo to a temp location
git clone https://github.com/salihnurd/ios-sudoku-game.git /tmp/sudoku-src

# Copy the source files
cp -r /tmp/sudoku-src/Models ./
cp -r /tmp/sudoku-src/ViewModels ./
cp -r /tmp/sudoku-src/Views ./
cp -r /tmp/sudoku-src/Services ./
cp /tmp/sudoku-src/SudokuGameApp.swift ./

# Clean up
rm -rf /tmp/sudoku-src

echo "✅ Files copied! Open your Xcode project and add the folders to your target."
```

## First Run

1. **Select a target device:**
   - Choose iPhone 12 or later simulator
   - Or connect a physical device

2. **Build the project:**
   - Press ⌘B or Product → Build
   - Wait for compilation to complete

3. **Run the app:**
   - Press ⌘R or Product → Run
   - App will launch in simulator/device

## Troubleshooting

### Build Errors

**Error: "Cannot find 'ContentView' in scope"**
- Solution: Ensure ContentView.swift is in the project
- Check that it's added to your app target

**Error: "No such module 'SwiftUI'"**
- Solution: Set deployment target to iOS 14.0+
- Check in Project → Targets → General → Deployment Info

**Error: Files not found**
- Solution: Add files to project
- Drag folders into Xcode project navigator
- Ensure "Add to targets" is checked

### Runtime Issues

**App crashes on launch**
- Check Console for error messages
- Ensure all @ObservedObject/@StateObject are correctly used
- Verify all views are properly imported

**Grid not displaying**
- Check device orientation (portrait recommended)
- Verify GeometryReader constraints
- Try different simulator devices

**Numbers not appearing**
- Check that puzzle generation completed
- View console for generation errors
- Ensure grid array is properly initialized

## Testing the App

### Test Game Flow:
1. ✅ Launch app → See menu
2. ✅ Tap "Kolay" → Game starts
3. ✅ Tap empty cell → Cell highlights blue
4. ✅ Tap number button → Number appears
5. ✅ Invalid move → Cell highlights red
6. ✅ Tap "İpucu" → Hint fills a cell
7. ✅ Tap "Geri Al" → Last move undone
8. ✅ Complete puzzle → Congratulations dialog

### Test UI Elements:
1. ✅ Header shows timer counting up
2. ✅ Header shows hint count
3. ✅ Grid has thick borders every 3 cells
4. ✅ Initial cells are blue and bold
5. ✅ Control buttons enable/disable correctly

### Test Dark Mode:
1. Settings → Developer → Dark Appearance
2. App should adapt automatically
3. All text should remain readable

## Performance Tips

### For Best Performance:
- Use iPhone 11 or later simulator
- Close other apps while developing
- Use Release configuration for testing

### Build Settings:
```
Debug:
- Optimization Level: None [-Onone]
- Swift Compilation Mode: Incremental

Release:
- Optimization Level: Optimize for Speed [-O]
- Swift Compilation Mode: Whole Module
```

## Common Customizations

### Change Difficulty:
Edit `Models/SudokuGame.swift`:
```swift
var emptyCells: Int {
    switch self {
    case .easy: return 35      // Was 40
    case .medium: return 45    // Was 50
    case .hard: return 55      // Was 60
    }
}
```

### Change Colors:
Edit cell background in `Views/SudokuGridView.swift`:
```swift
private var backgroundColor: Color {
    if isInvalid {
        return Color.orange.opacity(0.3)  // Changed from red
    }
    // ... rest of the code
}
```

### Change Timer Format:
Edit `ViewModels/SudokuGameViewModel.swift`:
```swift
func formattedTime() -> String {
    let seconds = elapsedTime % 60
    return String(format: "%02d", seconds)  // Show only seconds
}
```

## Next Steps

1. ✅ Run the app and play a game
2. 📖 Read ARCHITECTURE.md for code details
3. 🎨 Customize colors and themes
4. 🔊 Add sound effects
5. 💾 Implement game persistence
6. 📊 Add statistics tracking
7. 🏆 Create leaderboards
8. 🌐 Add more languages

## Support

For issues or questions:
1. Check existing GitHub issues
2. Create a new issue with:
   - Xcode version
   - iOS version
   - Steps to reproduce
   - Error messages

## Resources

- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [Sudoku Rules](https://en.wikipedia.org/wiki/Sudoku)
- [iOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios)

Happy coding! 🎉
