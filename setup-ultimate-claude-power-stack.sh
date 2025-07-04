#!/bin/bash

# Claude Code Max Ultimate Power Stack Setup
# For use with Claude Code Max ($200/month) - Opus 4 ONLY
# Created: July 4, 2025

set -e

echo "🚀 Setting up the Ultimate Claude Code Max Power Stack..."
echo "=================================================="
echo "This will install tools to make Claude Code Max incredibly powerful!"
echo ""

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew not found. Please install it first:"
    echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    exit 1
fi

# Function to check and install tools
install_if_missing() {
    local tool=$1
    local package=$2
    local install_cmd=$3
    
    if ! command -v "$tool" &> /dev/null; then
        echo "📦 Installing $tool..."
        eval "$install_cmd"
    else
        echo "✅ $tool already installed"
    fi
}

echo ""
echo "🔧 Installing Core Terminal Tools..."
echo "-----------------------------------"

# Install terminal multiplexer
install_if_missing "tmux" "tmux" "brew install tmux"

# Install file watchers
install_if_missing "entr" "entr" "brew install entr"

# Install tree for directory visualization
install_if_missing "tree" "tree" "brew install tree"

# Install watch for real-time monitoring
install_if_missing "watch" "watch" "brew install watch"

echo ""
echo "📊 Installing Git Visualization Tools..."
echo "---------------------------------------"

# Install GitUI - blazing fast terminal UI for git
install_if_missing "gitui" "gitui" "brew install gitui"

# Install Delta - beautiful git diffs
install_if_missing "delta" "git-delta" "brew install git-delta"

# Install Tig - text-mode interface for git
install_if_missing "tig" "tig" "brew install tig"

echo ""
echo "🤖 Installing AI Coding Tools..."
echo "---------------------------------"

# Install Python and pipx if not present
if ! command -v python3 &> /dev/null; then
    echo "📦 Installing Python 3..."
    brew install python@3.12
fi

# Install pipx for Python apps
if ! command -v pipx &> /dev/null; then
    echo "📦 Installing pipx..."
    brew install pipx
    pipx ensurepath
fi

# Install Aider (AI pair programming)
if ! command -v aider &> /dev/null; then
    echo "📦 Installing Aider..."
    pipx install aider-chat
else
    echo "✅ Aider already installed"
fi

# Install ShellGPT
if ! command -v sgpt &> /dev/null; then
    echo "📦 Installing ShellGPT..."
    pipx install shell-gpt
else
    echo "✅ ShellGPT already installed"
fi

# Install gptme
if ! command -v gptme &> /dev/null; then
    echo "📦 Installing gptme..."
    pipx install gptme
else
    echo "✅ gptme already installed"
fi

# Install Fabric
if ! command -v fabric &> /dev/null; then
    echo "📦 Installing Fabric..."
    pipx install fabric
    # Set up Fabric patterns
    mkdir -p ~/.config/fabric/patterns
else
    echo "✅ Fabric already installed"
fi

echo ""
echo "🛠️ Installing Code Context Tools..."
echo "------------------------------------"

# Install code2prompt
if ! command -v code2prompt &> /dev/null; then
    echo "📦 Installing code2prompt..."
    pipx install code2prompt
else
    echo "✅ code2prompt already installed"
fi

# Note about Repomix (already installed via npm)
echo "ℹ️  Repomix should already be installed via npm install -g repomix"

echo ""
echo "⚙️ Configuring Git to use Delta..."
echo "----------------------------------"

# Configure git to use delta for diffs
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.light false
git config --global delta.line-numbers true
git config --global delta.side-by-side true

echo "✅ Git configured to use Delta for beautiful diffs"

echo ""
echo "📁 Creating configuration files..."
echo "----------------------------------"

# Create tmux configuration for optimal layout
cat > ~/.tmux.claude.conf << 'EOF'
# Claude Code Max Power Layout
# Start with: tmux -f ~/.tmux.claude.conf

# Set prefix to Ctrl-a
set -g prefix C-a
unbind C-b

# Split panes with | and -
bind | split-window -h
bind - split-window -v

# Mouse support
set -g mouse on

# Status bar
set -g status-style bg=colour235,fg=colour136
set -g status-left '#[fg=colour235,bg=colour252,bold] Claude Power '
set -g status-right '#[fg=colour235,bg=colour252,bold] %H:%M '

# Pane borders
set -g pane-border-style fg=colour235
set -g pane-active-border-style fg=colour136

# Start windows and panes at 1, not 0
set -g base-index 1
setw -g pane-base-index 1
EOF

echo "✅ Created tmux configuration at ~/.tmux.claude.conf"

# Create launch script
cat > ~/claude-power-workspace.sh << 'EOF'
#!/bin/bash
# Launch Claude Code Max Power Workspace with OPUS 4 ONLY

echo "🚀 Launching Claude Code Max Power Workspace (Opus 4 + Skip Permissions)..."

# Set environment variables for skip permissions mode
export AIDER_DANGEROUSLY_SKIP_PERMISSIONS=true
export AIDER_MODEL=claude-opus-4

# Kill any existing session
tmux kill-session -t claude-power 2>/dev/null || true

# Create new tmux session
tmux new-session -d -s claude-power

# Create the layout: 2x2 grid
# Top-left: Claude (larger)
# Top-right: GitUI
# Bottom-left: File tree
# Bottom-right: Git status

# Start in the main window
tmux send-keys -t claude-power:0 'export AIDER_DANGEROUSLY_SKIP_PERMISSIONS=true' C-m
tmux send-keys -t claude-power:0 'export AIDER_MODEL=claude-opus-4' C-m
tmux send-keys -t claude-power:0 'clear' C-m

# Split horizontally (top/bottom)
tmux split-window -t claude-power:0 -v -p 30

# Select top pane and split vertically (left/right)
tmux select-pane -t claude-power:0.0
tmux split-window -t claude-power:0 -h -p 40

# Select bottom pane and split vertically (left/right)
tmux select-pane -t claude-power:0.2
tmux split-window -t claude-power:0 -h -p 40

# Now we have 4 panes:
# 0 = top-left (Claude)
# 1 = top-right (GitUI)
# 2 = bottom-left (Tree)
# 3 = bottom-right (Git status)

# Run commands in each pane
tmux send-keys -t claude-power:0.0 'claude' C-m
tmux send-keys -t claude-power:0.1 'gitui' C-m
tmux send-keys -t claude-power:0.2 'watch -n 1 "tree -C -L 3 --dirsfirst | head -30"' C-m
tmux send-keys -t claude-power:0.3 'watch -n 1 "git status --short && echo && git diff --stat"' C-m

# Select Claude pane
tmux select-pane -t claude-power:0.0

# Attach to session
tmux attach-session -t claude-power

EOF

chmod +x ~/claude-power-workspace.sh

echo "✅ Created launch script at ~/claude-power-workspace.sh"

echo ""
echo "🎯 Setting up VSCode extensions..."
echo "----------------------------------"

# Install VSCode extensions if code command exists
if command -v code &> /dev/null; then
    echo "Installing recommended VSCode extensions..."
    
    # Core extensions for Claude Code Max
    code --install-extension anthropic.claude-code || true
    
    # Additional power extensions
    code --install-extension continue.continue || true
    code --install-extension eamodio.gitlens || true
    code --install-extension streetsidesoftware.code-spell-checker || true
    code --install-extension usernamehw.errorlens || true
    code --install-extension aaron-bond.better-comments || true
    code --install-extension wayou.vscode-todo-highlight || true
    
    echo "✅ VSCode extensions installed"
else
    echo "⚠️  VSCode command not found. Install extensions manually."
fi

echo ""
echo "📝 Creating helper aliases..."
echo "-----------------------------"

# Add aliases to shell config
SHELL_CONFIG=""
if [ -f ~/.zshrc ]; then
    SHELL_CONFIG=~/.zshrc
elif [ -f ~/.bashrc ]; then
    SHELL_CONFIG=~/.bashrc
fi

if [ -n "$SHELL_CONFIG" ]; then
    # Check if aliases already exist
    if ! grep -q "# Claude Code Max Power Aliases" "$SHELL_CONFIG"; then
        cat >> "$SHELL_CONFIG" << 'EOF'

# Claude Code Max Power Aliases
alias cpower='~/claude-power-workspace.sh'
alias cgit='gitui'
alias cwatch='watch -n 1 "git status --short && echo \"---\" && git diff --stat"'
alias ctree='watch -n 1 "tree -C -L 3 --dirsfirst | head -40"'
alias ccontext='repomix && echo "Context file generated!"'
alias cprompt='code2prompt . | pbcopy && echo "Codebase copied to clipboard!"'

# Aider with Opus 4 and skip permissions by default
alias caider='aider --dangerously-skip-permissions --model claude-opus-4'

# Function to feed file changes to Claude
cfeed() {
    git diff | pbcopy
    echo "Git diff copied to clipboard - paste into Claude!"
}

# Function to extract wisdom from Claude's output
cextract() {
    pbpaste | fabric --pattern extract_wisdom
}
EOF
        echo "✅ Added power aliases to $SHELL_CONFIG"
        echo "   Run 'source $SHELL_CONFIG' to activate them"
    else
        echo "✅ Power aliases already configured"
    fi
fi

echo ""
echo "🎉 Installation Complete!"
echo "========================"
echo ""
echo "🚀 Quick Start:"
echo "   1. Run 'cpower' to launch the full power workspace"
echo "   2. Or run 'claude' in terminal with VSCode open"
echo ""
echo "⚡ Power Commands:"
echo "   cpower   - Launch 4-pane tmux workspace"
echo "   cgit     - Launch GitUI"
echo "   cwatch   - Watch git status/diff"
echo "   ctree    - Watch file tree"
echo "   ccontext - Generate context with Repomix"
echo "   cprompt  - Copy codebase to clipboard"
echo "   cfeed    - Copy git diff to clipboard"
echo ""
echo "💡 Pro Tips:"
echo "   - In tmux: Ctrl-a + arrow keys to switch panes"
echo "   - Git diffs now use Delta automatically"
echo "   - VSCode + Claude Code extension for best experience"
echo ""
echo "🎯 Remember: We're using Claude Code Max with Opus 4 ONLY!"