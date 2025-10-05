# Contributing to iOS Sudoku Game

Thank you for your interest in contributing to this project! 🎉

## How to Contribute

### Reporting Bugs 🐛

Before creating a bug report, please check existing issues to avoid duplicates.

**Good bug reports include:**
- Clear, descriptive title
- Detailed steps to reproduce
- Expected vs actual behavior
- Screenshots if applicable
- Environment details (iOS version, device, Xcode version)

Example:
```
Title: Grid lines not visible in dark mode on iPad

Steps to reproduce:
1. Open app on iPad Pro 12.9"
2. Enable dark mode in Settings
3. Start a new game

Expected: Grid lines should be visible
Actual: Grid lines are too faint to see

Environment:
- iOS 15.0
- iPad Pro 12.9" (5th gen)
- Xcode 13.0
```

### Suggesting Features 💡

Feature suggestions are welcome! Please:
- Check if it's already suggested
- Explain the use case
- Describe the expected behavior
- Consider implementation complexity

### Code Contributions 👨‍💻

#### Getting Started

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes
4. Test thoroughly
5. Commit with clear messages: `git commit -m 'Add amazing feature'`
6. Push to your fork: `git push origin feature/amazing-feature`
7. Open a Pull Request

#### Code Style

**Swift Style Guide:**
- Follow [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- Use meaningful variable names
- Add comments for complex logic
- Keep functions focused and small
- Use extensions for organization

**Example:**
```swift
// Good ✅
func calculateScore(time: Int, hints: Int, difficulty: Difficulty) -> Int {
    var score = baseScore
    score += difficulty.bonus
    score -= hints * hintPenalty
    return max(score, 0)
}

// Not ideal ❌
func calc(t: Int, h: Int, d: Difficulty) -> Int {
    return baseScore + d.bonus - h * hintPenalty
}
```

**SwiftUI Best Practices:**
- Break down large views into smaller components
- Use `@StateObject` for view model ownership
- Use `@ObservedObject` for passed view models
- Prefer computed properties over `@State` when possible
- Extract subviews for readability

#### Project Structure

When adding new features:
- **Models**: Add to `Models/` folder
- **Views**: Add to `Views/` folder
- **ViewModels**: Add to `ViewModels/` folder
- **Services**: Add to `Services/` folder

#### Testing

Before submitting:
- ✅ Build succeeds without warnings
- ✅ App runs on simulator
- ✅ Test on both iPhone and iPad
- ✅ Test in light and dark mode
- ✅ Verify accessibility
- ✅ No crashes or memory leaks

#### Commit Messages

Use clear, descriptive commit messages:

```
Good ✅:
- Add hint animation when cell is revealed
- Fix timer not stopping on game completion
- Refactor grid validation logic for performance

Not ideal ❌:
- Update
- Fix bug
- Changes
```

### Areas for Contribution

**High Priority:**
- [ ] Unit tests for game logic
- [ ] UI tests for user flows
- [ ] Accessibility improvements
- [ ] Performance optimizations
- [ ] iPad layout enhancements

**Medium Priority:**
- [ ] Game state persistence
- [ ] Statistics tracking
- [ ] Custom themes
- [ ] Sound effects
- [ ] Animations

**Nice to Have:**
- [ ] Daily challenges
- [ ] Multiplayer mode
- [ ] Apple Pencil support
- [ ] Widget support
- [ ] Game Center integration

## Pull Request Process

1. **Update Documentation**: If you change functionality, update README.md
2. **Add Tests**: Include tests for new features
3. **Update ARCHITECTURE.md**: For architectural changes
4. **Follow Style Guide**: Match existing code style
5. **Single Purpose**: One feature/fix per PR
6. **Descriptive Title**: Clear PR title and description

### PR Template

```markdown
## Description
[Describe what this PR does]

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Tested on iPhone simulator
- [ ] Tested on iPad simulator
- [ ] Tested in light mode
- [ ] Tested in dark mode
- [ ] No crashes or warnings

## Screenshots
[If applicable, add screenshots]

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Comments added for complex code
- [ ] Documentation updated
- [ ] No new warnings
```

## Development Setup

### Prerequisites
- macOS 10.15.4+
- Xcode 12.0+
- Git

### Setup Steps
```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/ios-sudoku-game.git
cd ios-sudoku-game

# Add upstream remote
git remote add upstream https://github.com/salihnurd/ios-sudoku-game.git

# Create feature branch
git checkout -b feature/your-feature-name

# Make changes, commit, and push
git add .
git commit -m "Your descriptive message"
git push origin feature/your-feature-name
```

### Keeping Your Fork Updated
```bash
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

## Code Review Process

PRs will be reviewed for:
- Code quality and style
- Functionality and correctness
- Performance impact
- Test coverage
- Documentation completeness

Reviewers may request changes. Please:
- Respond to all comments
- Make requested changes
- Mark conversations as resolved
- Re-request review when ready

## Recognition

Contributors will be:
- Listed in the project README
- Mentioned in release notes
- Credited in commit history

## Questions?

Feel free to:
- Open an issue for discussion
- Ask questions in PR comments
- Reach out to maintainers

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

Thank you for making this project better! 🙏
