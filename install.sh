#!/usr/bin/env bash
# Put add-sdd on $PATH by symlinking it into ~/.local/bin.
# The symlink points back to this repo, so edits to skills/agents here are picked up automatically.

set -euo pipefail

SDD_HOME="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
BIN_DIR="${BIN_DIR:-$HOME/.local/bin}"

chmod +x "$SDD_HOME/add-sdd"
mkdir -p "$BIN_DIR"
ln -sf "$SDD_HOME/add-sdd" "$BIN_DIR/add-sdd"
echo "Linked $BIN_DIR/add-sdd -> $SDD_HOME/add-sdd"

case ":$PATH:" in
  *":$BIN_DIR:"*) echo "Ready: run 'add-sdd' from any project." ;;
  *)
    rc="$HOME/.bashrc"
    [[ "${SHELL:-}" == */zsh ]] && rc="$HOME/.zshrc"
    line="export PATH=\"$BIN_DIR:\$PATH\""
    grep -qxF "$line" "$rc" 2>/dev/null || echo "$line" >> "$rc"
    echo "Added $BIN_DIR to PATH in $rc. Run 'source $rc' or open a new shell."
    ;;
esac
