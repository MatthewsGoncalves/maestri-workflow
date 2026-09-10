#!/usr/bin/env bash
# Redação de padrões sensíveis antes de gravar memory/*.md
# Uso: ./scripts/memory-redact.sh [arquivo]   (stdin se omitido)
#      ./scripts/memory-redact.sh --self-test
set -euo pipefail

redact_stream() {
  sed -E \
    -e 's/sk-[a-zA-Z0-9]{10,}/sk-[REDACTED]/g' \
    -e 's/sgp_[a-zA-Z0-9]{10,}/sgp_[REDACTED]/g' \
    -e 's/ghp_[a-zA-Z0-9]{20,}/ghp_[REDACTED]/g' \
    -e 's/gho_[a-zA-Z0-9]{20,}/gho_[REDACTED]/g' \
    -e 's/github_pat_[a-zA-Z0-9_]{20,}/github_pat_[REDACTED]/g' \
    -e 's/AKIA[0-9A-Z]{16}/AKIA[REDACTED]/g' \
    -e 's/ASIA[0-9A-Z]{16}/ASIA[REDACTED]/g' \
    -e 's/xox[baprs]-[a-zA-Z0-9-]{10,}/xox[REDACTED]/g' \
    -e 's/Bearer[[:space:]]+[a-zA-Z0-9._~+\/-]{8,}/Bearer [REDACTED]/g' \
    -e 's/eyJ[a-zA-Z0-9_-]{10,}\.[a-zA-Z0-9._-]+\.[a-zA-Z0-9._-]+/eyJ[JWT-REDACTED]/g' \
    -e 's/(password|passwd|secret|api[_-]?key|private[_-]?key)[[:space:]]*[:=][[:space:]]*[^[:space:]#]+/\1=[REDACTED]/gi'
}

self_test() {
  local out fail=0
  out="$(printf 'sk-abc123456789012345678901234567890\napi_key=leak\n' | redact_stream)"
  echo "$out" | grep -q 'sk-\[REDACTED\]' || fail=1
  echo "$out" | grep -q 'api_key=\[REDACTED\]' || fail=1
  echo "$out" | grep -q 'leak' && fail=1
  [[ "$fail" -eq 0 ]] && echo "memory-redact self-test OK" && return 0
  echo "memory-redact self-test FAIL" >&2
  return 1
}

if [[ "${1:-}" == "--self-test" ]]; then
  self_test
  exit $?
fi

if [[ $# -ge 1 ]]; then
  redact_stream < "$1"
else
  redact_stream
fi
