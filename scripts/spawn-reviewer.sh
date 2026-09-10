#!/usr/bin/env bash
# Reviewer sob demanda no ground. Uso: ./scripts/spawn-reviewer.sh Crivo
set -euo pipefail

CODENAME="${1:-Crivo}"
PRESET="${2:-}"
CLI="${MAESTRI_CLI:-maestri}"

RECRUIT_CMD=("$CLI" recruit "$CODENAME" --role "Reviewer")
if [[ -n "$PRESET" ]]; then
  RECRUIT_CMD+=(--preset "$PRESET")
fi

"${RECRUIT_CMD[@]}"
echo "Reviewer $CODENAME pronto no ground."
