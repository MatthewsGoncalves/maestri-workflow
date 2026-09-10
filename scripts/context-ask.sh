#!/usr/bin/env bash
# Emite linha CTX para colar no maestri ask.
# Uso: ./scripts/context-ask.sh --phase implement [--feature feat/x] [--handoff yes|no] [--notes a,b]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
# shellcheck source=lib/context.sh
source "$ROOT/scripts/lib/context.sh"

PHASE=""
FEATURE=""
HANDOFF=""
NOTES=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --phase) PHASE="$2"; shift 2 ;;
    --feature) FEATURE="$2"; shift 2 ;;
    --handoff) HANDOFF="$2"; shift 2 ;;
    --notes) NOTES="$2"; shift 2 ;;
    *) echo "Uso: $0 --phase plan|implement|debug|review|land [--feature SLUG] [--handoff yes|no] [--notes a,b]" >&2; exit 1 ;;
  esac
done

[[ -n "$PHASE" ]] || { echo "→ --phase obrigatório" >&2; exit 1; }

context_init "${FEATURE:-feature-unset}"
[[ -n "$FEATURE" ]] && context_set feature_id "$FEATURE"

FEAT="$(context_get feature_id)"
ALLOWED="$(context_get handoff_allowed 2>/dev/null || echo false)"
[[ -z "$HANDOFF" ]] && HANDOFF="$(default_handoff_for_phase "$PHASE")"
# handoff_allowed=true no yaml vence o default de fase (A)
if [[ "$ALLOWED" == "true" && "$HANDOFF" == "no" ]]; then
  HANDOFF="yes"
elif [[ "$ALLOWED" == "false" && "$HANDOFF" == "yes" ]]; then
  HANDOFF="no"
fi
[[ -z "$NOTES" ]] && NOTES="$(default_notes_for_phase "$PHASE")"

printf 'CTX: feature=%s phase=%s handoff:%s notes:%s\n' "$FEAT" "$PHASE" "$HANDOFF" "$NOTES"
