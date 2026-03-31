# universal-claude-code-config

A global [Claude Code](https://claude.ai/code) configuration that installs into `~/.claude/` and applies sensible engineering defaults across every project you work on.

Covers: code standards, security, testing, accessibility, git, Docker, AI/LLM work, and workflow conventions — plus two slash commands (`/project-memory` and `/accessibility`) that auto-discover context and run audits.

---

## Install

### curl (recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/kristianhansen/universal-claude-code-config/main/install.sh | bash
```

### Homebrew

```bash
brew tap kristianhansen/universal-claude-code-config
brew install claude-config
```

### Manual

Clone the repo and copy files yourself:

```bash
git clone https://github.com/kristianhansen/universal-claude-code-config.git
cd universal-claude-code-config

mkdir -p ~/.claude/docs ~/.claude/commands
cp CLAUDE.md ~/.claude/CLAUDE.md
cp docs/* ~/.claude/docs/
cp commands/* ~/.claude/commands/
```

---

## After installing

1. Open `~/.claude/CLAUDE.md`
2. Add your name in the **Identity & Communication** section
3. Uncomment and fill in your stack under **Technology Standards**

---

## What's included

```
~/.claude/
├── CLAUDE.md                    # Global instructions, auto-loaded every session
├── docs/
│   ├── python.md                # uv, pytest, ruff, FastAPI, Pydantic conventions
│   ├── aws.md                   # EC2/Docker, IAM, secrets, region conventions
│   ├── git.md                   # Branch naming, commit style, PR format
│   └── ai-patterns.md           # Prompt structure, Ollama, agent/tool patterns
└── commands/
    ├── project-memory.md        # /project-memory — maintains decisions, issues, progress logs
    └── accessibility.md         # /accessibility — runs audits for web, mobile, CLI, API
```

### Slash commands

| Command | What it does |
|---------|-------------|
| `/project-memory` | Creates or reads `project_notes/` in the current project — tracks decisions, known issues, and progress across sessions |
| `/accessibility` | Detects project type and runs the appropriate accessibility audit (Lighthouse for web, label checks for mobile, contrast for CLI, etc.) |

---

## Customizing

The `docs/` files are referenced from `CLAUDE.md` under **Technology Standards**. You can:

- Edit them to match your stack
- Add new ones (e.g. `~/.claude/docs/react.md`, `~/.claude/docs/postgres.md`)
- Remove references to ones you don't use

For project-specific rules, add a `CLAUDE.md` to your project root — Claude Code merges it with the global one.

---

## Contributing

PRs welcome. Keep rules general enough to apply across teams — project-specific conventions belong in the project's own `CLAUDE.md`.
