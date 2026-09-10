#!/usr/bin/env bash
# Smoke test v1.1 — context contract + redact (offline, sem Maestri obrigatório)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
# shellcheck source=lib/context.sh
source "$ROOT/scripts/lib/context.sh"
PASS=0
FAIL=0

ok()  { echo "  ✓ $1"; PASS=$((PASS + 1)); }
bad() { echo "  ✗ $1"; FAIL=$((FAIL + 1)); }

echo "=== smoke-memory (offline) ==="

if "$ROOT/scripts/memory-redact.sh" --self-test; then ok "memory-redact"; else bad "memory-redact"; fi

export MAESTRI_CONTEXT_DIR="$ROOT/.maestri-smoke-test"
rm -rf "$MAESTRI_CONTEXT_DIR"
mkdir -p "$MAESTRI_CONTEXT_DIR"

export MAESTRI_CONTEXT_FILE="$MAESTRI_CONTEXT_DIR/context.yaml"
"$ROOT/scripts/context-bump.sh" --feature TEST-smoke >/dev/null
CTX=$("$ROOT/scripts/context-ask.sh" --phase implement)
echo "$CTX" | grep -q 'handoff:no' && ok "CTX default handoff:no" || bad "CTX handoff default"
echo "$CTX" | grep -q 'rev=' && bad "CTX must not include rev=" || ok "CTX sem rev="

"$ROOT/scripts/context-bump.sh" --feature TEST-smoke --handoff-allowed yes >/dev/null
CTX2=$("$ROOT/scripts/context-ask.sh" --phase implement)
echo "$CTX2" | grep -q 'handoff:yes' && ok "handoff_allowed vence fase" || bad "handoff_allowed"

"$ROOT/scripts/context-bump.sh" --feature TEST-smoke --handoff-allowed false >/dev/null
memory_write_stamp
"$ROOT/scripts/land-gate.sh" --verify && ok "land-gate verify" || bad "land-gate verify"

rm -rf "$MAESTRI_CONTEXT_DIR"
echo ""
echo "PASS=$PASS FAIL=$FAIL"
[[ "$FAIL" -eq 0 ]]
