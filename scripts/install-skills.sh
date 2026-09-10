#!/usr/bin/env bash
# Clona skills externas listadas em skills/manifest.yaml
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
VENDOR="$ROOT/skills/vendor"
mkdir -p "$VENDOR"

clone_if_missing() {
  local name="$1" repo="$2" ref="${3:-main}"
  local dest="$VENDOR/$name"
  if [[ -d "$dest/.git" ]]; then
    echo "✓ $name (já existe)"
    return
  fi
  echo "→ Clonando $name..."
  git clone --depth 1 --branch "$ref" "https://github.com/$repo.git" "$dest" 2>/dev/null \
    || git clone --depth 1 "https://github.com/$repo.git" "$dest"
}

clone_if_missing engineering   addyosmani/agent-skills
clone_if_missing simplicity    dietrichgebert/ponytail
clone_if_missing communication alexgreensh/attention-span
clone_if_missing design-spec   VoltAgent/awesome-design-md
clone_if_missing ui-motion     emilkowalski/skills
clone_if_missing polish        pbakaus/impeccable
clone_if_missing diagrams      Graphify-Labs/graphify

echo ""
echo "Skills em: $VENDOR"
echo "→ Linkando catálogo..."
"$ROOT/scripts/link-skills.sh"
