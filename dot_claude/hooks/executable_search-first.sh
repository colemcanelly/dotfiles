#!/usr/bin/env bash

set -euo pipefail

INPUT=$(cat)
COMMAND=$(jq -r '.tool_input.command // ""' <<<"$INPUT")

if ! grep -Eq '(^|[;&|[:space:]])(rg|ast-grep)\b|(^|[;&|[:space:]])fd\b.*[[:space:]]-e[[:space:]]+ts\b' <<<"$COMMAND"; then
    exit 0
fi

HASH=$(printf '%s' "$COMMAND" | sha256sum | cut -d' ' -f1)
STATE="$HOME/.claude/hooks/state/$HASH"

if [[ -e "$STATE" ]]; then
    rm -f "$STATE"
    exit 0
fi

mkdir -p "$HOME/.claude/hooks/state"
touch "$STATE"

echo "Use the LSP tool first. If LSP cannot find the target, retry this command." >&2
exit 2
