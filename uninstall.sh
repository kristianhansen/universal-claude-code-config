#!/usr/bin/env bash
# ABOUTME: Uninstall script for universal-claude-code-config.
# ABOUTME: Removes installed files from ~/.claude/ and restores backups if available.

set -e

CLAUDE_DIR="$HOME/.claude"
BACKUP_DIR="$CLAUDE_DIR/backups"

GREEN='\033[0;32m'
NC='\033[0m'

echo ""
echo "Uninstalling universal-claude-code-config..."
echo ""

FILES=(
  "CLAUDE.md"
  "docs/python.md"
  "docs/aws.md"
  "docs/git.md"
  "docs/ai-patterns.md"
  "commands/project-memory.md"
  "commands/accessibility.md"
)

for file in "${FILES[@]}"; do
  target="$CLAUDE_DIR/$file"
  if [ -f "$target" ]; then
    rm "$target"
    echo -e "${GREEN}✓${NC} Removed $file"
  fi
done

# Check for a backup to restore
if [ -d "$BACKUP_DIR" ]; then
  latest_backup=$(ls -1t "$BACKUP_DIR" | head -n 1)
  if [ -n "$latest_backup" ] && [ -f "$BACKUP_DIR/$latest_backup/CLAUDE.md" ]; then
    echo ""
    read -r -p "Restore previous CLAUDE.md from backup ($latest_backup)? [y/N] " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
      cp "$BACKUP_DIR/$latest_backup/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
      echo -e "${GREEN}Restored CLAUDE.md from $latest_backup${NC}"
    fi
  fi
fi

echo ""
echo -e "${GREEN}Done.${NC} Your ~/.claude/backups/ folder has been preserved."
echo ""
