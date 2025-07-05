#!/bin/bash
# Set up Mem0 for Claude's memory system

echo "🧠 Setting up Mem0 Memory System for Claude"
echo "=========================================="
echo ""

# Check if API key exists
if [ -n "$MEM0_API_KEY" ]; then
    echo "✅ Mem0 API key already configured"
    echo ""
    # Test the connection
    python3 << EOF
import os
try:
    from mem0 import MemoryClient
    client = MemoryClient(api_key=os.getenv("MEM0_API_KEY"))
    print("✅ Mem0 connection successful!")
    
    # Try to get memories
    memories = client.search("Claude", limit=3)
    if memories:
        print(f"\n📚 Found {len(memories)} recent memories")
    else:
        print("\n📚 No memories yet - ready to start remembering!")
except Exception as e:
    print(f"❌ Error: {e}")
    print("   Make sure 'pip3 install mem0' is run")
EOF
else
    echo "❌ Mem0 API key not found"
    echo ""
    echo "To set up Mem0:"
    echo "1. Visit https://app.mem0.ai"
    echo "2. Sign up for free account"
    echo "3. Get your API key"
    echo "4. Run: export MEM0_API_KEY='your-key-here'"
    echo "5. Add to ~/.zshrc to make permanent"
fi

echo ""
echo "Memory Commands:"
echo "  cmemory 'text' - Save to memory"
echo "  csearch 'query' - Search memories"
echo ""

# Create memory helper functions
cat > ~/claude-power-tools/memory-helpers.sh << 'EOF'
#!/bin/bash

# Save to memory
cmemory() {
    if [ -z "$1" ]; then
        echo "Usage: cmemory 'text to remember'"
        return 1
    fi
    
    python3 << PYTHON
import os
from mem0 import MemoryClient
client = MemoryClient(api_key=os.getenv("MEM0_API_KEY"))
result = client.add("$1", user_id="claude_user")
print(f"✅ Saved to memory: {result['memory']}")
PYTHON
}

# Search memory
csearch() {
    if [ -z "$1" ]; then
        echo "Usage: csearch 'search query'"
        return 1
    fi
    
    python3 << PYTHON
import os
from mem0 import MemoryClient
client = MemoryClient(api_key=os.getenv("MEM0_API_KEY"))
memories = client.search("$1", user_id="claude_user", limit=5)
if memories:
    print(f"📚 Found {len(memories)} memories:")
    for i, mem in enumerate(memories):
        print(f"{i+1}. {mem['memory']}")
else:
    print("No memories found")
PYTHON
}

# List recent memories
crecent() {
    python3 << PYTHON
import os
from mem0 import MemoryClient
client = MemoryClient(api_key=os.getenv("MEM0_API_KEY"))
memories = client.get_all(user_id="claude_user", limit=10)
if memories:
    print(f"📚 Recent memories:")
    for i, mem in enumerate(memories):
        print(f"{i+1}. {mem['memory']}")
else:
    print("No memories yet")
PYTHON
}
EOF

chmod +x ~/claude-power-tools/memory-helpers.sh
echo "✅ Created memory helper functions"