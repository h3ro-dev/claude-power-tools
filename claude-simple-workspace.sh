#!/bin/bash
# Simple Claude Code Max + GitUI side-by-side

echo "🚀 Launching Simple Claude + GitUI workspace..."

# Set environment variables
export AIDER_DANGEROUSLY_SKIP_PERMISSIONS=true
export AIDER_MODEL=claude-opus-4

# Kill any existing session
tmux kill-session -t claude-simple 2>/dev/null || true

# Create new session with two panes side by side
tmux new-session -d -s claude-simple
tmux split-window -h -p 40

# Left pane: Claude
tmux send-keys -t claude-simple:0.0 'claude' C-m

# Right pane: GitUI
tmux send-keys -t claude-simple:0.1 'gitui' C-m

# Focus on Claude
tmux select-pane -t claude-simple:0.0

# Attach
tmux attach-session -t claude-simple