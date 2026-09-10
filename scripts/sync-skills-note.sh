#!/usr/bin/env bash
# Publica a nota canvas "Skills - Router" a partir do catálogo (Maestro Mode).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CLI="${MAESTRI_CLI:-maestri}"
BODY="$("$ROOT/scripts/skillctl" render note)"

if "$CLI" note read "Skills - Router" &>/dev/null; then
  "$CLI" note write "Skills - Router" "$BODY"
  echo "↻ Nota Skills - Router atualizada"
else
  "$CLI" note create "$BODY" --name "Skills - Router" --stack "Workflow"
  echo "+ Nota Skills - Router criada"
fi
