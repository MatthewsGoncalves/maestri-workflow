#!/usr/bin/env bash
# Sincroniza notas duráveis canvas ↔ memory/*.md (one-way por flag).
# Uso:
#   ./scripts/sync-memory.sh --push    canvas → memory/ (redact)
#   ./scripts/sync-memory.sh --pull    memory/ → canvas
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CLI="${MAESTRI_CLI:-maestri}"
REDACT="$ROOT/scripts/memory-redact.sh"
MEM="$ROOT/memory"

# note_name:file_name
PAIRS=(
  "decisions:decisions.md"
  "Aprendizados:aprendizados.md"
  "quality-bar:quality-bar.md"
  "api-contract:api-contract.md"
)

usage() {
  echo "Uso: $0 --push | --pull" >&2
  exit 1
}

note_exists() {
  "$CLI" note read "$1" &>/dev/null
}

push_one() {
  local note="$1" file="$2" body dest
  dest="$MEM/$file"
  if ! note_exists "$note"; then
    echo "  ⚠ nota \"$note\" não existe — rode init-notes.sh" >&2
    return 0
  fi
  body="$("$CLI" note read "$note")"
  mkdir -p "$MEM"
  printf '%s\n' "$body" | "$REDACT" > "$dest"
  echo "  ✓ $note → memory/$file"
}

pull_one() {
  local note="$1" file="$2" body src
  src="$MEM/$file"
  [[ -f "$src" ]] || { echo "  ⚠ memory/$file ausente — pulando" >&2; return 0; }
  body="$(cat "$src")"
  if note_exists "$note"; then
    "$CLI" note write "$note" "$body"
    echo "  ↻ $note ← memory/$file"
  else
    "$CLI" note create "$body" --name "$note" --stack "Memory"
    echo "  + $note ← memory/$file (fichário Memory)"
  fi
}

MODE="${1:-}"
[[ "$MODE" == "--push" || "$MODE" == "--pull" ]] || usage

echo "→ sync-memory $MODE"
for pair in "${PAIRS[@]}"; do
  note="${pair%%:*}"
  file="${pair#*:}"
  if [[ "$MODE" == "--push" ]]; then
    push_one "$note" "$file"
  else
    pull_one "$note" "$file"
  fi
done
echo "Done."

if [[ "$MODE" == "--push" ]]; then
  # shellcheck source=lib/context.sh
  source "$ROOT/scripts/lib/context.sh"
  memory_write_stamp 2>/dev/null || echo "  (stamp skipped — context.yaml ausente; rode context-bump.sh)" >&2
fi
