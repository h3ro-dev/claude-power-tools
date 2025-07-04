# Claude Code Max Power Stack - Quick Reference

## 🚀 Launch Commands

### Full Power Workspace
```bash
cpower  # Launches 4-pane tmux setup with Opus 4 + skip permissions enabled
```

### Individual Tools
```bash
claude                # Claude Code Max in terminal
gitui                 # Visual git interface
tig                   # Alternative git viewer
caider                # Aider with Opus 4 + skip permissions (alias)
aider --dangerously-skip-permissions  # Manual Aider with no prompts
sgpt "question"       # Quick AI queries
gptme                 # Terminal AI agent
```

## 📊 Tmux Controls (After launching cpower)

- **Switch panes**: `Ctrl-a` + arrow keys
- **Resize pane**: `Ctrl-a` + hold arrow key
- **Zoom pane**: `Ctrl-a` + `z`
- **Create new window**: `Ctrl-a` + `c`
- **Switch windows**: `Ctrl-a` + number

## 🎯 Power Workflows

### 1. Feed Entire Codebase to Claude
```bash
# Option 1: Using Repomix
repomix
# Then in Claude: @context.xml

# Option 2: Using code2prompt
code2prompt . | pbcopy
# Then paste in Claude

# Option 3: Using RepoPrompt (if installed)
repoprompt_cli
```

### 2. Watch File Changes While Working
```bash
# In separate terminal or tmux pane:
ls *.py | entr -c pytest  # Auto-run tests on file change
ls *.js | entr -c npm test  # For JavaScript projects
```

### 3. Beautiful Git Diffs
```bash
git diff              # Now uses Delta automatically
git log -p            # Also beautified with Delta
git show HEAD         # Shows last commit with syntax highlighting
```

### 4. Extract Insights from Claude's Output
```bash
# Copy Claude's response, then:
pbpaste | fabric --pattern extract_wisdom
pbpaste | fabric --pattern summarize
```

### 5. Multi-Agent Workflows
```bash
# If you have Claude Squad installed:
claude-squad init
claude-squad add-task "Refactor authentication"
claude-squad run
```

## 💡 VSCode + Claude Code Max Integration

1. Open VSCode in your project
2. Open terminal in VSCode (`Ctrl+``)
3. Run `claude` in the terminal
4. Claude Code extension auto-connects
5. See inline diffs directly in editor!

## 🔧 Configuration Files

- **Aider**: `~/.aider.conf.yml` (configured for Opus 4)
- **Tmux**: `~/.tmux.claude.conf`
- **Git**: Already configured to use Delta
- **ShellGPT**: `~/.config/shell_gpt/.sgptrc`

## 🌍 Environment Variables (Set by cpower)

```bash
AIDER_DANGEROUSLY_SKIP_PERMISSIONS=true  # No permission prompts
AIDER_MODEL=claude-opus-4                 # Always use Opus 4
```

## ⚡ Quick Aliases

```bash
cpower    # Launch full workspace
cgit      # Launch GitUI
cwatch    # Watch git status/diff
ctree     # Watch file tree
ccontext  # Generate Repomix context
cprompt   # Copy codebase to clipboard
cfeed     # Copy git diff to feed to Claude
caider    # Aider with Opus 4 + skip permissions
```

## 🎨 Advanced Tips

### See What Claude is Changing
```bash
# Terminal 1: Claude Code
claude

# Terminal 2: Watch specific files
watch -n 1 'cat app.py | head -50'

# Terminal 3: GitUI (press Enter on files to see diffs)
gitui
```

### Context Window Management
```bash
# Check token count before sending to Claude
code2prompt . --tokens

# Generate lighter context
repomix --include="*.py" --exclude="tests/*"
```

### Parallel AI Assistance
```bash
# Use Aider for complex refactoring (with skip permissions)
caider --file src/main.py
# Or manually:
aider --dangerously-skip-permissions --model claude-opus-4 --file src/main.py

# Use gptme for quick scripts
gptme "write a script to backup my database"

# Use ShellGPT for command help
sgpt "how to find large files in current directory"
```

## 🚨 Important Notes

1. **We use Opus 4 ONLY** - No Sonnet, no Haiku
2. **Claude Code Max**: Your $200/month subscription
3. **Terminal + VSCode**: Best of both worlds
4. **Git Integration**: Everything is tracked

## 🆘 Troubleshooting

### Claude Code not connecting to VSCode?
```bash
# In VSCode terminal:
claude --version
# Then try: /ide command in Claude
```

### Tmux session lost?
```bash
tmux ls                    # List sessions
tmux attach -t claude-power  # Reattach
```

### Need to update tools?
```bash
brew update && brew upgrade
pip3 install --upgrade aider-chat shell-gpt gptme fabric code2prompt
```

---

Remember: This setup makes Claude Code Max incredibly powerful. You have visual feedback, context generation, beautiful diffs, and parallel AI assistance all at your fingertips!