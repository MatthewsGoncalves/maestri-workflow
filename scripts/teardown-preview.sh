#!/usr/bin/env bash
# Encerra preview de uma stack: fecha portals e (com --shells) dispensa os shells.
# Nomes vêm de rules/project/preview.md — não hardcode aqui.
# Uso: ./scripts/teardown-preview.sh Frontend|Backend|Mobile|all [--shells]
set -euo pipefail

TARGET="${1:?Frontend | Backend | Mobile | all}"
DROP_SHELLS=0
[[ "${2:-}" == "--shells" ]] && DROP_SHELLS=1

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CLI="${MAESTRI_CLI:-maestri}"
PREVIEW="$ROOT/rules/project/preview.md"
source "$ROOT/scripts/lib/preview-fields.sh"

exists() { "$CLI" list 2>/dev/null | grep -qF "\"$1\""; }

close_portal() {
  local name="$1"
  [[ -n "$name" ]] || return 0
  if exists "$name"; then
    echo "→ Fechando portal \"$name\""
    "$CLI" portal close "$name" 2>/dev/null || echo "  (falhou — feche na UI)"
  fi
}

drop_shell() {
  local name="$1"
  [[ -n "$name" && "$DROP_SHELLS" -eq 1 ]] || return 0
  if exists "$name"; then
    echo "→ Dispensando shell \"$name\""
    "$CLI" dismiss "$name" 2>/dev/null || echo "  (falhou — dismiss na UI)"
  fi
}

teardown_stack() {
  case "$1" in
    Frontend)
      local pn; pn="$(read_field Frontend "Portal name" "Front Preview")"
      close_portal "$pn"
      close_portal "$pn Mobile"
      drop_shell "$(read_field Frontend "Shell name" "Dev Server")"
      ;;
    Backend)
      close_portal "$(read_field Backend "Portal name" "API Docs")"
      drop_shell "$(read_field Backend "Shell name" "API Server")"
      ;;
    Mobile)
      close_portal "Expo Web"
      drop_shell "$(read_field Mobile "Shell name" "Metro")"
      drop_shell "$(read_field Mobile "Shell emulator (opcional)" "")"
      ;;
    *) echo "Uso: $0 Frontend|Backend|Mobile|all [--shells]" >&2; exit 1 ;;
  esac
}

if [[ "$TARGET" == "all" ]]; then
  for s in Frontend Backend Mobile; do teardown_stack "$s"; done
else
  teardown_stack "$TARGET"
fi

echo ""
if [[ "$DROP_SHELLS" -eq 1 ]]; then
  echo "Preview encerrado (portals + shells). Confira: maestri list"
else
  echo "Portals fechados. Shells seguem rodando — use --shells para dispensá-los."
fi
