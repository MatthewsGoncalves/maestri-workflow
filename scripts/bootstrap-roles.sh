#!/usr/bin/env bash
# Registra roles globais: universal + regras + operação Maestri
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CLI="${MAESTRI_CLI:-maestri}"

append_project_overlay() {
  local overlay_files=(
    "$ROOT/rules/project/git.md"
    "$ROOT/rules/project/communications.md"
    "$ROOT/rules/project/paths.md"
  )
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

compile_prompt() {
  local rules_file="$1"
  local ops_file="$2"
  local skills_file="${3:-}"
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
    append_project_overlay
    if [[ -n "$skills_file" && -f "$skills_file" ]]; then
      echo ""
      cat "$skills_file"
    fi
    echo ""
    echo "## Operação Maestri"
    cat "$ops_file"
  }
}

create_role() {
  local name="$1" rules_file="$2" ops_file="$3"
  local skills_file="${4:-}"
  local prompt
  prompt="$(compile_prompt "$rules_file" "$ops_file" "$skills_file")"

  if "$CLI" role list 2>/dev/null | grep -q "\"$name\""; then
    echo "↻ Atualizando role: $name"
    "$CLI" role write "$name" "$prompt"
  else
    echo "+ Criando role: $name"
    "$CLI" role create "$name" "$prompt" --scope global
  fi
}

create_role "Orchestrator"   "$ROOT/rules/orchestrator.md"   "$ROOT/roles/orchestrator.md"   "$ROOT/rules/skills-dispatch.md"
create_role "Reviewer"       "$ROOT/rules/reviewer.md"       "$ROOT/roles/reviewer.md"       "$ROOT/rules/skills-dispatch-reviewer.md"
create_role "API Specialist" "$ROOT/rules/stacks/backend.md" "$ROOT/roles/api-specialist.md" "$ROOT/rules/skills-dispatch-stack-backend.md"
create_role "UI Builder"     "$ROOT/rules/stacks/frontend.md" "$ROOT/roles/ui-builder.md"    "$ROOT/rules/skills-dispatch-stack-frontend.md"
create_role "Mobile Dev"     "$ROOT/rules/stacks/mobile.md"  "$ROOT/roles/mobile-dev.md"    "$ROOT/rules/skills-dispatch-stack-mobile.md"

echo ""
"$CLI" role list
