#!/usr/bin/env bash
# Personaliza overlay white-label num projeto importado.
# Uso: ./scripts/init-project.sh "Nome do Projeto" [Codename Maestro]
# Exemplo: ./scripts/init-project.sh "Acme Shop" "Maestro"
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
NAME="${1:?Nome do projeto (ex: Acme Shop)}"
CODENAME="${2:-Orquestrator}"

sed_inplace() {
  if sed --version >/dev/null 2>&1; then
    sed -i "s|$1|$2|g" "$3"
  else
    sed -i '' "s|$1|$2|g" "$3"
  fi
}

substitute_project_name() {
  local f="$1"
  [[ -f "$f" ]] || return 0
  if grep -q '{{PROJECT_NAME}}' "$f" 2>/dev/null; then
    sed_inplace '{{PROJECT_NAME}}' "$NAME" "$f"
    echo "  ✓ $f (PROJECT_NAME)"
  fi
}

echo "→ Projeto: $NAME"
echo "→ Codename Maestro: $CODENAME"
# Só o overlay guarda o codename. Os arquivos do kernel mantêm o placeholder
# {{ORCHESTRATOR_CODENAME}} — bootstrap-roles.sh resolve na hora de compilar.
echo "$CODENAME" > "$ROOT/rules/project/orchestrator.codename"

echo "→ Substituindo placeholders..."

for f in \
  "$ROOT/rules/project/git.md" \
  "$ROOT/rules/project/communications.md" \
  "$ROOT/rules/project/paths.md" \
  "$ROOT/rules/project/preview.md"
do
  substitute_project_name "$f"
done

echo ""
echo "Próximo:"
echo "  1. Edite rules/project/* (git, communications, paths, preview)"
echo "  2. ./scripts/bootstrap-roles.sh"
echo "  3. maestri role assign \"$CODENAME\" \"Orchestrator\""
echo ""
echo "Guia: WHITELABEL.md · Escopo: docs/SCOPE.md"
