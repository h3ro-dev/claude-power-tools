#!/bin/bash
# Adaptive Claude Code Max Power Workspace with better resizing

echo "🚀 Launching Adaptive Claude Power Workspace..."

# Set environment variables
export AIDER_DANGEROUSLY_SKIP_PERMISSIONS=true
export AIDER_MODEL=claude-opus-4

# Kill any existing session
tmux kill-session -t claude-adaptive 2>/dev/null || true

# Create new tmux session with better layout options
tmux new-session -d -s claude-adaptive

# Set options for better resizing
tmux set-option -t claude-adaptive -g aggressive-resize on
tmux set-window-option -t claude-adaptive -g aggressive-resize on

# Use tmux's built-in layouts that handle resizing better
# Start with main-vertical layout
tmux select-layout -t claude-adaptive main-vertical

# Create panes
tmux split-window -h -t claude-adaptive
tmux split-window -v -t claude-adaptive.0
tmux split-window -v -t claude-adaptive.1

# Run commands
tmux send-keys -t claude-adaptive:0.0 'claude' C-m
tmux send-keys -t claude-adaptive:0.1 'gitui' C-m
tmux send-keys -t claude-adaptive:0.2 'watch -n 1 "tree -C -L 3 --dirsfirst | head -30"' C-m
tmux send-keys -t claude-adaptive:0.3 'watch -n 1 "git status --short && echo && git diff --stat"' C-m

# Apply tiled layout for even distribution
tmux select-layout -t claude-adaptive tiled

# Select Claude pane
tmux select-pane -t claude-adaptive:0.0

# Add key bindings for easy layout switching
tmux bind-key -n M-1 select-layout -t claude-adaptive main-vertical   # Alt+1: Focus on left panes
tmux bind-key -n M-2 select-layout -t claude-adaptive main-horizontal # Alt+2: Focus on top panes  
tmux bind-key -n M-3 select-layout -t claude-adaptive tiled          # Alt+3: Equal size
tmux bind-key -n M-4 select-layout -t claude-adaptive even-vertical  # Alt+4: Vertical columns
tmux bind-key -n M-5 select-layout -t claude-adaptive even-horizontal # Alt+5: Horizontal rows

# Set minimum pane sizes
tmux set-option -t claude-adaptive -g pane-base-index 0
tmux set-window-option -t claude-adaptive -g pane-min-width 20
tmux set-window-option -t claude-adaptive -g pane-min-height 5

# Attach with instructions
echo "
Layout Shortcuts:
  Alt+1: Focus on Claude (main-vertical)
  Alt+2: Focus on top panes (main-horizontal)
  Alt+3: Equal tiles
  Alt+4: Vertical columns
  Alt+5: Horizontal rows
  
Resize Panes:
  Ctrl+a then hold Alt+Arrow keys
"

sleep 2
tmux attach-session -t claude-adaptive