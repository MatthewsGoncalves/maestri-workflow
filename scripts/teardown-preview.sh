#!/usr/bin/env bash
# Encerra previews de uma stack (portals; shells ficam — dismiss manual se quiser).
# Uso: ./scripts/teardown-preview.sh Frontend|Backend|Mobile|all
set -euo pipefail

TARGET="${1:?Frontend | Backend | Mobile | all}"
CLI="${MAESTRI_CLI:-maestri}"

close_portal() {
  local name="$1"
  if "$CLI" list 2>/dev/null | grep -q "\"$name\""; then
    echo "→ Fechando portal $name"
    "$CLI" portal close "$name" 2>/dev/null || true
  fi
}

case "$TARGET" in
  Frontend)
    close_portal "Front Preview"
    close_portal "Front Preview Mobile"
    ;;
  Backend)
    close_portal "API Docs"
    ;;
  Mobile)
    close_portal "Expo Web"
    ;;
  all)
    for n in "Front Preview" "Front Preview Mobile" "API Docs" "Expo Web"; do
      close_portal "$n"
    done
    ;;
  *)
    echo "Uso: $0 Frontend|Backend|Mobile|all" >&2
    exit 1
    ;;
esac

echo "Portals fechados. Shells (Dev Server, API Server, Metro): maestri dismiss se necessário."
