#!/usr/bin/env bash
# Installs agents globally by symlinking to ~/.claude/agents/
# Run from the repo root: ./scripts/install.sh

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
AGENTS_SRC="$REPO_ROOT/.claude/agents"
AGENTS_DEST="$HOME/.claude/agents"

echo "Installing agents from: $AGENTS_SRC"
echo "Installing agents to:   $AGENTS_DEST"
echo ""

mkdir -p "$AGENTS_DEST"

for agent_file in "$AGENTS_SRC"/*.md; do
  agent_name="$(basename "$agent_file")"
  dest_path="$AGENTS_DEST/$agent_name"

  if [ -L "$dest_path" ]; then
    echo "  Updating symlink: $agent_name"
    rm "$dest_path"
  elif [ -f "$dest_path" ]; then
    echo "  WARNING: $dest_path exists and is not a symlink — skipping"
    continue
  else
    echo "  Installing: $agent_name"
  fi

  ln -s "$agent_file" "$dest_path"
done

echo ""
echo "Done. Restart Claude Code or run /agents to reload."
