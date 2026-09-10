#!/usr/bin/env bash
# Personaliza overlay white-label num projeto importado.
# Uso: ./scripts/init-project.sh "Nome do Projeto"
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
NAME="${1:?Nome do projeto (ex: Acme Shop)}"

substitute() {
  local f="$1"
  [[ -f "$f" ]] || return 0
  if grep -q '{{PROJECT_NAME}}' "$f" 2>/dev/null; then
    sed -i '' "s/{{PROJECT_NAME}}/$NAME/g" "$f"
    echo "  ✓ $f"
  fi
}

echo "→ Projeto: $NAME"
echo "→ Substituindo placeholders em rules/project/..."

substitute "$ROOT/rules/project/git.md"
substitute "$ROOT/rules/project/communications.md"
substitute "$ROOT/rules/project/paths.md"

if [[ ! -f "$ROOT/rules/project/git.example-github.md" ]]; then
  echo "  (sem example-github — ok)"
fi

echo ""
echo "Próximo:"
echo "  1. Edite rules/project/git.md, communications.md, paths.md"
echo "  2. ./scripts/bootstrap-roles.sh"
echo "  3. maestri role assign \"<seu-maestro>\" \"Orchestrator\""
echo ""
echo "Guia completo: WHITELABEL.md"
