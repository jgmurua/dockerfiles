#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  ./scripts/install.sh --global
  ./scripts/install.sh --project /path/to/project
  ./scripts/install.sh --home-agent

Options:
  --global       Install into ~/.config/opencode/skills/platform-engineer
  --project DIR  Install into DIR/.opencode/skills/platform-engineer
  --home-agent   Install into ~/.agents/skills/platform-engineer
EOF
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET=""

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

case "${1:-}" in
  --global)
    TARGET="$HOME/.config/opencode/skills/platform-engineer"
    ;;
  --project)
    if [[ $# -lt 2 ]]; then
      echo "ERROR: --project requires a directory" >&2
      exit 1
    fi
    TARGET="$2/.opencode/skills/platform-engineer"
    ;;
  --home-agent)
    TARGET="$HOME/.agents/skills/platform-engineer"
    ;;
  -h|--help)
    usage
    exit 0
    ;;
  *)
    usage
    exit 1
    ;;
esac

mkdir -p "$(dirname "$TARGET")"
rm -rf "$TARGET"
cp -R "$SKILL_DIR" "$TARGET"

echo "Installed platform-engineer skill at: $TARGET"
echo "Verify: test -f '$TARGET/SKILL.md' && echo OK"
