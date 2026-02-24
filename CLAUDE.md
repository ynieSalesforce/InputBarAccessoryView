# InputBarAccessoryView

A customizable input bar accessory view for iOS chat applications, written in Swift.

## Project Overview

- **Type**: Swift Package (iOS library)
- **Minimum iOS**: 17.0
- **Swift**: 6.0 (strict concurrency)
- **Dependency**: [SnapKit](https://github.com/SnapKit/SnapKit) (AutoLayout DSL)

## Project Structure

```
Sources/
  InputBarAccessoryView.swift   # Main input bar view
  Controls/                     # UIControl subclasses
  Extensions/                   # Swift/UIKit extensions
  KeyboardManager/              # Keyboard tracking and layout
  Models/                       # Data models
  Plugins/                      # AutocompleteManager, AttachmentManager
  Protocols/                    # Delegate/datasource protocols
  ViewControllers/              # View controller helpers
  Views/                        # InputTextView, InputStackView, etc.
  Supporting/                   # Assets and resources

Example/                        # Example Xcode project (separate from SPM)
```

## Key Components

- **InputBarAccessoryView** — Main bar with 4 `InputStackView` toolbars + `InputTextView`
- **InputTextView** — Self-sizing UITextView with image paste support
- **InputStackView** — Toolbar stack views (top/bottom/left/right of text view)
- **InputBarButtonItem** — Button with reactive hooks for text/keyboard events
- **AutocompleteManager** — Handles @mention/#hashtag autocomplete with a table view
- **AttachmentManager** — Drop-in attachment (image/file) display above the text view
- **KeyboardManager** — Tracks keyboard frame changes and manages layout

## Development Notes

- Swift 6 strict concurrency — all UI work must be on main actor
- The left/right `InputStackView`s are width-constrained; text view fills remaining space
- `InputBarButtonItem` uses reactive closure hooks (`onTextViewDidChangeAction`, etc.)
- The example app is an `.xcodeproj` inside `Example/`, not part of the SPM package

## Build / Test

Open `InputBarAccessoryView.xcworkspace` to build the full workspace including the Example project.

To build just the Swift package:
```
swift build
```
