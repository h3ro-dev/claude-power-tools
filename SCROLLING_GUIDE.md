# Claude Power Tools - Scrolling Guide 📜

## Quick Scrolling Reference

### 🖱️ Mouse Scrolling (Easiest!)
- **Scroll Up/Down**: Just use your mouse wheel in any pane
- **Select Text**: Click and drag to select text
- **Copy**: Select text and it auto-copies to clipboard

### ⌨️ Keyboard Shortcuts

#### Basic Scrolling
- **PageUp**: Enter scroll mode and go up one page
- **PageDown**: Scroll down (when not in scroll mode)
- **Ctrl-a Enter**: Enter copy/scroll mode manually

#### In Copy Mode (vi-style)
- **k/↑**: Scroll up line by line
- **j/↓**: Scroll down line by line
- **Ctrl-u**: Scroll up half page
- **Ctrl-d**: Scroll down half page
- **g**: Go to top
- **G**: Go to bottom
- **q**: Exit copy mode

#### Pane Navigation
- **Option+Arrow**: Switch between panes
- **Ctrl-a Arrow**: Also switches panes
- **Ctrl-a q**: Show pane numbers

### 💡 Pro Tips

1. **Long Claude Conversations**: The tmux buffer now holds 100,000 lines!
2. **Search in Scroll Mode**: Press `/` to search forward, `?` to search backward
3. **Copy to Clipboard**: Select with mouse and it auto-copies
4. **Quick Exit**: Press `q` to exit scroll mode

### 🎯 Most Common Use Cases

**Reviewing Claude's Long Response:**
1. Use mouse wheel to scroll up
2. Or press PageUp to enter scroll mode
3. Navigate with arrow keys or mouse
4. Press q when done

**Copying Code from Claude:**
1. Click and drag to select the code
2. It's automatically copied!
3. Paste with Cmd+V anywhere

**Finding Something Specific:**
1. Press Ctrl-a Enter to enter copy mode
2. Press `/` and type your search term
3. Press `n` for next match, `N` for previous
4. Press `q` to exit

### 🚨 Troubleshooting

**Can't scroll?**
- Make sure you're in the Claude pane (click on it)
- Try PageUp key or Ctrl-a Enter

**Mouse not working?**
- The config enables mouse support, but your terminal needs to support it
- Try iTerm2 or modern Terminal.app

**Lost in scroll mode?**
- Just press `q` to exit back to normal mode

Enjoy scrolling through your Claude conversations! 🚀