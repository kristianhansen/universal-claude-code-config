#!/usr/bin/env bash
# ABOUTME: Install script for universal-claude-code-config.
# ABOUTME: Copies CLAUDE.md, docs/, and commands/ into ~/.claude/, backing up any existing files.

set -e

REPO="https://raw.githubusercontent.com/kristianhansen/universal-claude-code-config/main"
CLAUDE_DIR="$HOME/.claude"
BACKUP_DIR="$CLAUDE_DIR/backups/claude-config-$(date +%Y%m%d%H%M%S)"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo "Installing universal-claude-code-config..."
echo ""

# Create directories
mkdir -p "$CLAUDE_DIR/docs"
mkdir -p "$CLAUDE_DIR/commands"

# Backup existing CLAUDE.md if present
if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
  mkdir -p "$BACKUP_DIR"
  cp "$CLAUDE_DIR/CLAUDE.md" "$BACKUP_DIR/CLAUDE.md"
  echo -e "${YELLOW}Backed up existing CLAUDE.md to $BACKUP_DIR${NC}"
fi

# Download CLAUDE.md
curl -fsSL "$REPO/CLAUDE.md" -o "$CLAUDE_DIR/CLAUDE.md"
echo -e "${GREEN}✓${NC} CLAUDE.md"

# Download docs
for file in python.md aws.md git.md ai-patterns.md; do
  curl -fsSL "$REPO/docs/$file" -o "$CLAUDE_DIR/docs/$file"
  echo -e "${GREEN}✓${NC} docs/$file"
done

# Download commands
for file in project-memory.md accessibility.md; do
  curl -fsSL "$REPO/commands/$file" -o "$CLAUDE_DIR/commands/$file"
  echo -e "${GREEN}✓${NC} commands/$file"
done

echo ""
echo -e "${GREEN}Done!${NC}"
echo ""
echo "Next steps:"
echo "  1. Open ~/.claude/CLAUDE.md"
echo "  2. Add your name in the Identity & Communication section"
echo "  3. Uncomment and fill in your stack in the Technology Standards section"
echo ""
