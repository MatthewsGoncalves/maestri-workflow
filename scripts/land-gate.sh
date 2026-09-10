#!/usr/bin/env bash
# Gate pós-land: sync memory + stamp verificável.
# Uso:
#   ./scripts/land-gate.sh              # push + stamp
#   ./scripts/land-gate.sh --verify     # só verifica stamp vs context
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
# shellcheck source=lib/context.sh
source "$ROOT/scripts/lib/context.sh"

if [[ "${1:-}" == "--verify" ]]; then
  if memory_stamp_valid; then
    echo "✓ land-gate: memory-sync stamp válido (rev=$(context_get revision))"
    exit 0
  fi
  echo "✗ land-gate: stamp ausente ou revision diverge — rode $0 sem --verify" >&2
  exit 1
fi

echo "→ land-gate: sync-memory --push"
"$ROOT/scripts/sync-memory.sh" --push
memory_write_stamp
if ! "$0" --verify; then
  echo "✗ land-gate: push OK mas verify falhou" >&2
  exit 1
fi
echo "  Confirme checkbox em handoff · commit memory/*.md se track_in_git"
