#!/usr/bin/env bash
# Sobe Shell de dev + Portal (Front/Backend) por stack. Zero tokens de IA.
# Uso: ./scripts/spawn-preview.sh Frontend|Backend|Mobile
set -euo pipefail

STACK="${1:?Frontend | Backend | Mobile}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CLI="${MAESTRI_CLI:-maestri}"
PREVIEW="$ROOT/rules/project/preview.md"

read_field() {
  local section="$1" key="$2" default="${3:-}"
  [[ -f "$PREVIEW" ]] || { echo "$default"; return; }
  awk -v sec="$section" -v k="$key" '
    $0 ~ "^## " sec { insec=1; next }
    /^## / { if (insec) exit }
    insec && $0 ~ "^\\| " k " \\|" { gsub(/^\\|[^|]*\\|[[:space:]]*/, ""); gsub(/[[:space:]]*\\|$/, ""); print; exit }
  ' "$PREVIEW" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | grep -v '^\`$' || echo "$default"
}

case "$STACK" in
  Frontend)
    FLOOR="Frontend"
    SHELL_NAME="$(read_field Frontend "Shell name" "Dev Server")"
    DEV_CMD="$(read_field Frontend "Comando dev" "npm run dev")"
    BASE_URL="$(read_field Frontend "URL base" "http://localhost:3000")"
    PORTAL_NAME="$(read_field Frontend "Portal name" "Front Preview")"
    PORTAL_PATH="$(read_field Frontend "Portal path" "/")"
    MOBILE_VP="$(read_field Frontend "Viewport mobile (opcional)" "")"
    ;;
  Backend)
    FLOOR="Backend"
    SHELL_NAME="$(read_field Backend "Shell name" "API Server")"
    DEV_CMD="$(read_field Backend "Comando dev" "npm run start:dev")"
    PORTAL_URL="$(read_field Backend "Portal URL" "http://localhost:3001/swagger")"
    PORTAL_NAME="$(read_field Backend "Portal name" "API Docs")"
    ;;
  Mobile)
    FLOOR="Mobile"
    SHELL_NAME="$(read_field Mobile "Shell name" "Metro")"
    DEV_CMD="$(read_field Mobile "Comando dev" "npx expo start")"
    EMU_SHELL="$(read_field Mobile "Shell emulator (opcional)" "Simulador")"
    EMU_CMD="$(read_field Mobile "Comando emulator" "")"
    EXPO_WEB="$(read_field Mobile "Portal (opcional, Expo web)" "")"
    ;;
  *)
    echo "Stack inválida: $STACK (use Frontend, Backend ou Mobile)" >&2
    exit 1
    ;;
esac

recruit_exists() {
  "$CLI" list 2>/dev/null | grep -qE "\"${1}\""
}

spawn_shell() {
  local name="$1" floor="$2" cmd="$3"
  if recruit_exists "$name"; then
    echo "↷ Shell \"$name\" já existe"
    return
  fi
  echo "→ Shell \"$name\" on $floor: $cmd"
  "$CLI" recruit "$name" --preset "Shell" --floor "$floor" --command "$cmd"
}

portal_exists() {
  "$CLI" list 2>/dev/null | grep -i "$1" >/dev/null 2>&1 || return 1
}

spawn_portal() {
  local url="$1" name="$2" size="${3:-}"
  if portal_exists "$name"; then
    echo "↷ Portal \"$name\" já existe — edit URL"
    "$CLI" portal edit "$name" --url "$url" 2>/dev/null || echo "  (conecte portal manualmente se orphan)"
    return
  fi
  echo "→ Portal \"$name\" → $url"
  if [[ -n "$size" ]]; then
    "$CLI" portal create "$url" "$name" --size "$size"
  else
    "$CLI" portal create "$url" "$name"
  fi
}

case "$STACK" in
  Frontend)
    spawn_shell "$SHELL_NAME" "$FLOOR" "$DEV_CMD"
    spawn_portal "${BASE_URL%/}${PORTAL_PATH}" "$PORTAL_NAME"
    if [[ -n "$MOBILE_VP" && "$MOBILE_VP" == *x* ]]; then
      W="${MOBILE_VP%x*}" H="${MOBILE_VP#*x}"
      spawn_portal "${BASE_URL%/}${PORTAL_PATH}" "${PORTAL_NAME} Mobile" "${W}x${H}"
    fi
    ;;
  Backend)
    spawn_shell "$SHELL_NAME" "$FLOOR" "$DEV_CMD"
    spawn_portal "$PORTAL_URL" "$PORTAL_NAME"
    ;;
  Mobile)
    spawn_shell "$SHELL_NAME" "$FLOOR" "$DEV_CMD"
    if [[ -n "$EMU_CMD" ]]; then
      spawn_shell "$EMU_SHELL" "$FLOOR" "$EMU_CMD"
    fi
    if [[ -n "$EXPO_WEB" ]]; then
      spawn_portal "$EXPO_WEB" "Expo Web"
    fi
    ;;
esac

echo ""
echo "Preview $STACK pronto. Shells não gastam tokens; conecte portal ao worker para snapshot."
