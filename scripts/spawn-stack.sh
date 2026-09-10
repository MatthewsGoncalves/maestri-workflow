#!/usr/bin/env bash
# Cria andar (stack) + recruit — idempotente se já existir.
# Uso: ./scripts/spawn-stack.sh Backend "API Specialist" feat/auth-api Forja
set -euo pipefail

STACK="${1:?Stack name (ex: Backend)}"
ROLE="${2:?Role (ex: API Specialist)}"
BRANCH="${3:?Branch (ex: feat/auth)}"
CODENAME="${4:?Recruit codename (ex: Forja)}"
PRESET="${5:-}"

source "$(dirname "$0")/lib/maestri-exists.sh"

if maestri_exists "$STACK" floor; then
  echo "↷ Andar \"$STACK\" já existe — pulando floor create"
else
  echo "→ Floor: $STACK (branch: $BRANCH)"
  maestri_cli floor create "$STACK" --branch "$BRANCH" --copy-ground
fi

if maestri_exists "$CODENAME" agents; then
  echo "↷ Recruit \"$CODENAME\" já existe — pulando recruit"
else
  RECRUIT_CMD=(maestri_cli recruit "$CODENAME" --floor "$STACK" --role "$ROLE")
  if [[ -n "$PRESET" ]]; then
    RECRUIT_CMD+=(--preset "$PRESET")
  fi
  echo "→ Recruit: $CODENAME ($ROLE)"
  "${RECRUIT_CMD[@]}"
fi

echo ""
echo "Stack pronta. Preview (Shell + Portal, 0 tokens IA):"
echo "  ./scripts/spawn-preview.sh $STACK"
