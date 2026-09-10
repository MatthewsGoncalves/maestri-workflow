#!/usr/bin/env bash
# Registra roles globais: universal + regras + operação Maestri
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CLI="${MAESTRI_CLI:-maestri}"

append_project_overlay() {
  local mode="${1:-worker}"
  local overlay_files=()

  if [[ "$mode" == "orchestrator" ]]; then
    overlay_files=(
      "$ROOT/rules/project/git.md"
      "$ROOT/rules/project/communications.md"
      "$ROOT/rules/project/paths.md"
      "$ROOT/rules/project/preview.md"
      "$ROOT/rules/project/security.md"
      "$ROOT/rules/project/memory.md"
    )
  else
    overlay_files=(
      "$ROOT/rules/project/git.md"
      "$ROOT/rules/project/communications.md"
      "$ROOT/rules/project/paths.md"
      "$ROOT/rules/project/preview.md"
      "$ROOT/rules/project/security.worker.md"
      "$ROOT/rules/project/worker-context.md"
    )
  fi
  local found=0
  for f in "${overlay_files[@]}"; do
    [[ -f "$f" ]] && found=1 && break
  done
  [[ "$found" -eq 0 ]] && return 0

  echo ""
  echo "## Regras do projeto (overlay)"
  for f in "${overlay_files[@]}"; do
    [[ -f "$f" ]] || continue
    cat "$f"
    echo ""
  done
}

# Codename do terminal Maestro. Fica em rules/project/ (gitignored) para que os
# arquivos do kernel guardem o placeholder e nunca virem conflito no git pull.
CODENAME_FILE="$ROOT/rules/project/orchestrator.codename"
CODENAME="$(cat "$CODENAME_FILE" 2>/dev/null || echo "Orquestrator")"
[[ -f "$CODENAME_FILE" ]] || echo "  (sem orchestrator.codename — usando \"$CODENAME\"; rode init-project.sh)"

compile_prompt() {
  local rules_file="$1"
  local ops_file="$2"
  local skills_file="${3:-}"
  local overlay_mode="${4:-worker}"
  {
    echo "## Princípios"
    cat "$ROOT/rules/universal/principles.md"
    echo ""
    cat "$ROOT/rules/universal/agent-lifecycle.md"
    echo ""
    cat "$ROOT/rules/universal/maestri.md"
    echo ""
    cat "$ROOT/rules/universal/token-economy.md"
    echo ""
    cat "$ROOT/rules/universal/communication.md"
    echo ""
    echo "## Regras do papel"
    cat "$rules_file"
    append_project_overlay "$overlay_mode"
    if [[ -n "$skills_file" && -f "$skills_file" ]]; then
      echo ""
      cat "$skills_file"
    fi
    echo ""
    echo "## Operação Maestri"
    cat "$ops_file"
  } | sed "s|{{ORCHESTRATOR_CODENAME}}|$CODENAME|g"
}

create_role() {
  local name="$1" rules_file="$2" ops_file="$3"
  local skills_file="${4:-}"
  local overlay_mode="${5:-worker}"
  local prompt
  prompt="$(compile_prompt "$rules_file" "$ops_file" "$skills_file" "$overlay_mode")"

  local left
  left="$(printf '%s' "$prompt" | grep -o '{{[A-Z_]*}}' | sort -u | tr '\n' ' ')"
  if [[ -n "$left" ]]; then
    echo "  ⚠ $name: placeholder não resolvido → ${left% }" >&2
    echo "    rode ./scripts/init-project.sh \"<Projeto>\" \"<Codename>\" antes deste script" >&2
  fi

  if "$CLI" role list 2>/dev/null | grep -q "\"$name\""; then
    echo "↻ Atualizando role: $name"
    "$CLI" role write "$name" "$prompt"
  else
    echo "+ Criando role: $name"
    "$CLI" role create "$name" "$prompt" --scope global
  fi
}

echo "→ Gerando dispatch a partir de skills/catalog.yaml..."
"$ROOT/scripts/gen-dispatch.sh"
echo ""

G="$ROOT/rules/_generated"
create_role "Orchestrator"   "$ROOT/rules/orchestrator.md"    "$ROOT/roles/orchestrator.md"   "$G/dispatch-orchestrator.md" orchestrator
create_role "Reviewer"       "$ROOT/rules/reviewer.md"        "$ROOT/roles/reviewer.md"       "$G/dispatch-reviewer.md" worker
create_role "API Specialist" "$ROOT/rules/stacks/backend.md"  "$ROOT/roles/api-specialist.md" "$G/dispatch-backend.md" worker
create_role "UI Builder"     "$ROOT/rules/stacks/frontend.md" "$ROOT/roles/ui-builder.md"     "$G/dispatch-frontend.md" worker
create_role "Mobile Dev"     "$ROOT/rules/stacks/mobile.md"   "$ROOT/roles/mobile-dev.md"     "$G/dispatch-mobile.md" worker

echo ""
"$CLI" role list
