#!/usr/bin/env bash
# Leitor/gravador de .maestri/context.yaml (formato key: value simples). Source only.

CONTEXT_DIR="${MAESTRI_CONTEXT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)/.maestri}"
CONTEXT_FILE="${MAESTRI_CONTEXT_FILE:-$CONTEXT_DIR/context.yaml}"

context_ensure_dir() {
  mkdir -p "$CONTEXT_DIR"
}

context_get() {
  local key="$1"
  [[ -f "$CONTEXT_FILE" ]] || return 1
  grep -E "^${key}:" "$CONTEXT_FILE" 2>/dev/null | tail -1 | sed -E 's/^[^:]*:[[:space:]]*//' | tr -d '"' | tr -d "'"
}

context_set() {
  local key="$1" val="$2" tmp
  context_ensure_dir
  tmp="$(mktemp)"
  if [[ -f "$CONTEXT_FILE" ]]; then
    grep -v -E "^${key}:" "$CONTEXT_FILE" > "$tmp" || true
  fi
  printf '%s: %s\n' "$key" "$val" >> "$tmp"
  mv "$tmp" "$CONTEXT_FILE"
}

context_init() {
  local feature="${1:-feature-unset}"
  context_ensure_dir
  if [[ ! -f "$CONTEXT_FILE" ]]; then
    cat > "$CONTEXT_FILE" <<EOF
feature_id: $feature
revision: 0
updated_at: $(date -u +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || date -u +%Y-%m-%dT%H:%M:%SZ)
handoff_allowed: false
last_memory_push_at:
last_memory_push_revision:
EOF
  fi
}

context_bump_revision() {
  local feature="${1:-}"
  local rev=1
  context_init "${feature:-feature-unset}"
  if [[ -n "$feature" ]]; then
    context_set feature_id "$feature"
  fi
  rev="$(context_get revision 2>/dev/null || echo 0)"
  rev=$((rev + 1))
  context_set revision "$rev"
  context_set updated_at "$(date -u +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || date +%Y-%m-%dT%H:%M:%SZ)"
  context_set handoff_allowed "false"
  printf '%s' "$rev"
}

memory_stamp_file() {
  printf '%s/memory-sync.stamp' "$CONTEXT_DIR"
}

memory_write_stamp() {
  local feature rev
  feature="$(context_get feature_id 2>/dev/null || echo unknown)"
  rev="$(context_get revision 2>/dev/null || echo 0)"
  cat > "$(memory_stamp_file)" <<EOF
feature_id=$feature
revision=$rev
pushed_at=$(date -u +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || date +%Y-%m-%dT%H:%M:%SZ)
redact_ran=true
EOF
  context_set last_memory_push_at "$(grep pushed_at "$(memory_stamp_file)" | cut -d= -f2-)"
  context_set last_memory_push_revision "$rev"
}

memory_stamp_valid() {
  local stamp feature rev ctx_rev
  stamp="$(memory_stamp_file)"
  [[ -f "$stamp" && -f "$CONTEXT_FILE" ]] || return 1
  feature="$(grep '^feature_id=' "$stamp" | cut -d= -f2-)"
  rev="$(grep '^revision=' "$stamp" | cut -d= -f2-)"
  ctx_rev="$(context_get revision)"
  [[ "$rev" == "$ctx_rev" ]] && [[ -n "$feature" ]]
}

default_notes_for_phase() {
  case "$1" in
    plan)     echo "spec,api-contract" ;;
    implement) echo "spec,api-contract,Aprendizados:tail15" ;;
    debug)    echo "handoff,Aprendizados:tail15" ;;
    review)   echo "quality-bar" ;;
    land)     echo "handoff" ;;
    *)        echo "spec" ;;
  esac
}

default_handoff_for_phase() {
  case "$1" in
    debug|land) echo "yes" ;;
    *)          echo "no" ;;
  esac
}
