#!/usr/bin/env bash
# Cria notas canvas a partir de notes/templates/ se ainda não existirem.
# Uso: ./scripts/init-notes.sh
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CLI="${MAESTRI_CLI:-maestri}"
TPL="$ROOT/notes/templates"

note_exists() {
  "$CLI" note read "$1" &>/dev/null
}

create_note() {
  local name="$1" template="$2" stack="${3:-Workflow}"
  local body
  [[ -f "$template" ]] || { echo "  ⚠ template $template ausente" >&2; return 0; }
  if note_exists "$name"; then
    echo "  ↷ $name"
    return 0
  fi
  body="$(cat "$template")"
  "$CLI" note create "$body" --name "$name" --stack "$stack"
  echo "  + $name (fichário $stack)"
}

echo "→ init-notes"

# Ops / feature (fichário Workflow)
create_note "spec" "$TPL/spec.md" "Workflow"
create_note "handoff" "$TPL/handoff.md" "Workflow"
create_note "design-tokens" "$TPL/design-tokens.md" "Workflow"

# Duráveis (fichário Memory)
create_note "api-contract" "$TPL/api-contract.md" "Memory"
create_note "quality-bar" "$TPL/quality-bar.md" "Memory"
create_note "decisions" "$TPL/decisions.md" "Memory"
create_note "Aprendizados" "$TPL/aprendizados.md" "Memory"

echo ""
echo "Skills - Router: ./scripts/sync-skills-note.sh"
echo "Espelho git: ./scripts/sync-memory.sh --pull  (se memory/ preenchido)"
