#!/usr/bin/env bash
# Cria andar (stack) + recruit — idempotente se já existir.
# Uso: ./scripts/spawn-stack.sh Backend "API Specialist" feat/auth-api Forja
set -euo pipefail

STACK="${1:?Stack name (ex: Backend)}"
ROLE="${2:?Role (ex: API Specialist)}"
BRANCH="${3:?Branch (ex: feat/auth)}"
CODENAME="${4:?Recruit codename (ex: Forja)}"
PRESET="${5:-}"

CLI="${MAESTRI_CLI:-maestri}"

floor_exists() {
  "$CLI" floor list 2>/dev/null | grep -qE "^[[:space:]]+${STACK}[[:space:]]"
}

recruit_exists() {
  "$CLI" list 2>/dev/null | grep -qE "\"${CODENAME}\""
}

if floor_exists; then
  echo "↷ Andar \"$STACK\" já existe — pulando floor create"
else
  echo "→ Floor: $STACK (branch: $BRANCH)"
  "$CLI" floor create "$STACK" --branch "$BRANCH" --copy-ground
fi

if recruit_exists; then
  echo "↷ Recruit \"$CODENAME\" já existe — pulando recruit"
else
  RECRUIT_CMD=("$CLI" recruit "$CODENAME" --floor "$STACK" --role "$ROLE")
  if [[ -n "$PRESET" ]]; then
    RECRUIT_CMD+=(--preset "$PRESET")
  fi
  echo "→ Recruit: $CODENAME ($ROLE)"
  "${RECRUIT_CMD[@]}"
fi

echo ""
echo "Stack pronta. Preview (Shell + Portal, 0 tokens IA):"
echo "  ./scripts/spawn-preview.sh $STACK"
