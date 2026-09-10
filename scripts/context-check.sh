#!/usr/bin/env bash
# Verifica revisão do contrato de contexto (anti-stale).
# Uso: ./scripts/context-check.sh --expect-rev N [--feature feat/x]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
# shellcheck source=lib/context.sh
source "$ROOT/scripts/lib/context.sh"

EXPECT=""
FEATURE=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --expect-rev) EXPECT="$2"; shift 2 ;;
    --feature) FEATURE="$2"; shift 2 ;;
    *) echo "Uso: $0 --expect-rev N [--feature SLUG]" >&2; exit 1 ;;
  esac
done

[[ -n "$EXPECT" ]] || { echo "→ --expect-rev obrigatório" >&2; exit 1; }
[[ -f "$CONTEXT_FILE" ]] || { echo "✗ sem $CONTEXT_FILE — rode context-bump.sh" >&2; exit 1; }

ACTUAL="$(context_get revision)"
FEAT="$(context_get feature_id)"

if [[ "$ACTUAL" != "$EXPECT" ]]; then
  echo "✗ stale: revision=$ACTUAL (esperado $EXPECT) feature=$FEAT" >&2
  exit 1
fi

if [[ -n "$FEATURE" && "$FEAT" != "$FEATURE" ]]; then
  echo "✗ feature mismatch: $FEAT (esperado $FEATURE)" >&2
  exit 1
fi

echo "✓ context OK rev=$ACTUAL feature=$FEAT"
