#!/usr/bin/env bash
# Cria andar (stack) + recruit. Uso: ./scripts/spawn-stack.sh Backend "API Specialist" feat/auth-api Forja
set -euo pipefail

STACK="${1:?Stack name (ex: Backend)}"
ROLE="${2:?Role (ex: API Specialist)}"
BRANCH="${3:?Branch (ex: feat/auth)}"
CODENAME="${4:?Recruit codename (ex: Forja)}"
PRESET="${5:-}"

CLI="${MAESTRI_CLI:-maestri}"

echo "→ Floor: $STACK (branch: $BRANCH)"
"$CLI" floor create "$STACK" --branch "$BRANCH" --copy-ground

RECRUIT_CMD=("$CLI" recruit "$CODENAME" --floor "$STACK" --role "$ROLE")
if [[ -n "$PRESET" ]]; then
  RECRUIT_CMD+=(--preset "$PRESET")
fi

echo "→ Recruit: $CODENAME ($ROLE)"
"${RECRUIT_CMD[@]}"

echo ""
"$CLI" floor list
