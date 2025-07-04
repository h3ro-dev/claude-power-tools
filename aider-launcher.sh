#!/bin/bash
# Aider launcher with clear options

echo "🤖 Aider Launcher for Claude Opus 4"
echo "===================================="
echo ""
echo "Choose your mode:"
echo ""
echo "1) Full Auto Mode (skip all permissions)"
echo "   - No file edit confirmations"
echo "   - No git operation confirmations"
echo "   - Fastest workflow"
echo ""
echo "2) Safe Mode (ask for permissions)"
echo "   - Confirms before file edits"
echo "   - Confirms before git operations"
echo "   - More control"
echo ""
echo "3) Custom (specify your own flags)"
echo ""
read -p "Enter choice (1-3): " choice

case $choice in
    1)
        echo "Launching Aider with Opus 4 + Skip Permissions..."
        aider --model claude-opus-4 --dangerously-skip-permissions
        ;;
    2)
        echo "Launching Aider with Opus 4 (Safe Mode)..."
        aider --model claude-opus-4
        ;;
    3)
        echo "Enter your custom aider command:"
        read -p "> aider " custom_flags
        aider $custom_flags
        ;;
    *)
        echo "Invalid choice. Exiting."
        ;;
esac