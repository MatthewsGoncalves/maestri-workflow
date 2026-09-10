#!/usr/bin/env bash
# Gera rules/_generated/dispatch-*.md a partir de skills/catalog.yaml.
# Rode após editar o catálogo. bootstrap-roles.sh chama isto automaticamente.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$ROOT/rules/_generated"
CTL="$ROOT/scripts/skillctl"

"$CTL" doctor >/dev/null || { echo "✗ catálogo inválido — rode: ./scripts/skillctl doctor" >&2; exit 1; }

mkdir -p "$OUT"
cat > "$OUT/README.md" <<'MD'
# rules/_generated — NÃO EDITE

Saída de `scripts/gen-dispatch.sh`, derivada de `skills/catalog.yaml`.
Qualquer edição aqui é perdida no próximo bootstrap. Edite o catálogo.
MD

for pair in "orchestrator:orchestrator" "reviewer:reviewer" \
            "backend:api-specialist" "frontend:ui-builder" "mobile:mobile-dev"; do
  file="${pair%%:*}"; role="${pair##*:}"
  "$CTL" render dispatch --role "$role" > "$OUT/dispatch-$file.md"
  echo "  ✓ rules/_generated/dispatch-$file.md"
done

"$CTL" render docs > "$ROOT/docs/SKILLS.md"
echo "  ✓ docs/SKILLS.md"
