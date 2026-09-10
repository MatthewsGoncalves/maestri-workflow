#!/usr/bin/env bash
# Atualiza contrato de contexto (.maestri/context.yaml) ao mudar handoff/spec.
# Uso: ./scripts/context-bump.sh --feature feat/x [--revision N] [--handoff-allowed yes|no]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
# shellcheck source=lib/context.sh
source "$ROOT/scripts/lib/context.sh"

FEATURE=""
REV=""
HANDOFF="false"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --feature) FEATURE="$2"; shift 2 ;;
    --revision) REV="$2"; shift 2 ;;
    --handoff-allowed)
      [[ "$2" == "yes" ]] && HANDOFF="true" || HANDOFF="false"
      shift 2
      ;;
    *) echo "Uso: $0 --feature SLUG [--revision N] [--handoff-allowed yes|no]" >&2; exit 1 ;;
  esac
done

[[ -n "$FEATURE" ]] || { echo "→ --feature obrigatório" >&2; exit 1; }

if [[ -n "$REV" ]]; then
  context_init "$FEATURE"
  context_set feature_id "$FEATURE"
  context_set revision "$REV"
  context_set updated_at "$(date -u +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || date +%Y-%m-%dT%H:%M:%SZ)"
  context_set handoff_allowed "$HANDOFF"
  echo "→ context revision=$REV feature=$FEATURE handoff_allowed=$HANDOFF"
else
  REV="$(context_bump_revision "$FEATURE")"
  context_set handoff_allowed "$HANDOFF"
  echo "→ context bumped revision=$REV feature=$FEATURE handoff_allowed=$HANDOFF"
fi

echo "  Arquivo: $CONTEXT_FILE"
echo "  Próximo ask: ./scripts/context-ask.sh --phase implement --feature $FEATURE"
