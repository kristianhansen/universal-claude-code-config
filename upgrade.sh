#!/usr/bin/env bash
# ABOUTME: Upgrade script for universal-claude-code-config.
# ABOUTME: Checks the installed version against the latest release, shows what changed, and upgrades on confirmation.

set -e

REPO="https://raw.githubusercontent.com/kristianhansen/universal-claude-code-config/main"
API="https://api.github.com/repos/kristianhansen/universal-claude-code-config"
CLAUDE_DIR="$HOME/.claude"
VERSION_FILE="$CLAUDE_DIR/.claude-config-version"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo ""
echo "Checking for updates..."
echo ""

# Get installed version
if [ -f "$VERSION_FILE" ]; then
  INSTALLED=$(cat "$VERSION_FILE")
else
  INSTALLED="unknown"
fi

# Get latest release from GitHub
LATEST=$(curl -fsSL "$API/releases/latest" 2>/dev/null | grep '"tag_name"' | sed 's/.*"tag_name": "\(.*\)".*/\1/')

if [ -z "$LATEST" ]; then
  echo "Could not reach GitHub API. Check your connection and try again."
  exit 1
fi

echo -e "Installed : ${CYAN}$INSTALLED${NC}"
echo -e "Latest    : ${CYAN}$LATEST${NC}"
echo ""

if [ "$INSTALLED" = "$LATEST" ]; then
  echo -e "${GREEN}Already up to date.${NC}"
  echo ""
  exit 0
fi

# Show release notes for the latest version
echo "What's new in $LATEST:"
echo "---"
curl -fsSL "$API/releases/latest" 2>/dev/null \
  | grep '"body"' \
  | sed 's/.*"body": "\(.*\)".*/\1/' \
  | sed 's/\\n/\n/g' \
  | sed 's/\\r//g'
echo "---"
echo ""

read -r -p "Upgrade from $INSTALLED to $LATEST? [y/N] " response
if [[ ! "$response" =~ ^[Yy]$ ]]; then
  echo "Upgrade cancelled."
  echo ""
  exit 0
fi

echo ""
echo "Upgrading..."
echo ""

# Backup existing CLAUDE.md
BACKUP_DIR="$CLAUDE_DIR/backups/claude-config-$(date +%Y%m%d%H%M%S)"
if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
  mkdir -p "$BACKUP_DIR"
  cp "$CLAUDE_DIR/CLAUDE.md" "$BACKUP_DIR/CLAUDE.md"
  echo -e "${YELLOW}Backed up existing CLAUDE.md to $BACKUP_DIR${NC}"
fi

# Download updated files
curl -fsSL "$REPO/CLAUDE.md" -o "$CLAUDE_DIR/CLAUDE.md"
echo -e "${GREEN}✓${NC} CLAUDE.md"

for file in python.md aws.md git.md ai-patterns.md; do
  curl -fsSL "$REPO/docs/$file" -o "$CLAUDE_DIR/docs/$file"
  echo -e "${GREEN}✓${NC} docs/$file"
done

for file in project-memory.md accessibility.md; do
  curl -fsSL "$REPO/commands/$file" -o "$CLAUDE_DIR/commands/$file"
  echo -e "${GREEN}✓${NC} commands/$file"
done

# Update version file
echo "$LATEST" > "$VERSION_FILE"

echo ""
echo -e "${GREEN}Upgraded to $LATEST.${NC}"
echo ""
