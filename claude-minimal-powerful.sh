#!/bin/bash
# Minimal setup that maximizes Claude's capabilities

echo "🧠 Claude Power Mode - Minimal & Powerful"
echo "========================================"

# Check critical tools
echo ""
echo "Checking Claude's power tools..."

# 1. Context generation
if command -v repomix &> /dev/null; then
    echo "✅ Repomix (full context) - Ready"
else
    echo "❌ Repomix missing - Install with: npm install -g repomix"
fi

# 2. Task management
if command -v task-master &> /dev/null; then
    echo "✅ Taskmaster (task tracking) - Ready"
else
    echo "❌ Taskmaster missing - Install with: npm install -g task-master-cli"
fi

# 3. Memory system
if [ -n "$MEM0_API_KEY" ]; then
    echo "✅ Mem0 (memory system) - Configured"
else
    echo "⚠️  Mem0 not configured - Get key from https://mem0.dev"
fi

# 4. Code prompting
if command -v code2prompt &> /dev/null; then
    echo "✅ Code2prompt (context tool) - Ready"
else
    echo "❌ Code2prompt missing - Install with: pip3 install code2prompt"
fi

echo ""
echo "Quick commands for Claude:"
echo "  ccontext  - Generate full project context"
echo "  ctask     - Start task tracking"
echo "  cmemory   - Save something to memory"
echo "  cstatus   - Show git changes"
echo ""

# Set up minimal aliases if not exists
if ! grep -q "# Claude Minimal Power" ~/.zshrc 2>/dev/null; then
    cat >> ~/.zshrc << 'EOF'

# Claude Minimal Power
alias ccontext='repomix && echo "Context ready at ./context.xml"'
alias ctask='task-master'
alias cmemory='claude "Remember this for our project: "'
alias cstatus='watch -n 1 "git status --short"'
alias cexplorer='watch -n 2 "echo \"=== Changed Files ===\" && git status --short && echo \"\" && echo \"=== Recent Commits ===\" && git log --oneline -5"'
EOF
    echo "✅ Added minimal power aliases"
fi

echo ""
echo "Starting minimal explorer view..."
echo "Press Ctrl+C to exit"
echo ""

# Simple explorer view - just show what's changing
watch -n 1 'echo "📁 File Changes:" && git status --short && echo "" && echo "📊 Stats:" && git diff --shortstat'