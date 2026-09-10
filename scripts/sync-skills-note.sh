#!/usr/bin/env bash
# Gera/atualiza nota canvas "Skills - Catalog" (Maestro Mode)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CLI="${MAESTRI_CLI:-maestri}"

BODY="$(cat <<'EOF'
# Skills — Catalog (Orchestrator)

Paths: `skills/installed/<id>/SKILL.md`

## Fluxo feature

| Ordem | Skill | Quando |
|-------|-------|--------|
| 1 | idea-refine / interview-me | pedido vago |
| 2 | spec-driven-development | escrever spec |
| 3 | planning-and-task-breakdown | tasks |
| 4 | api-and-interface-design | api-contract |
| 5 | ponytail + stack skill | delegar stacks |
| 6 | code-review-and-quality | review |
| 7 | attention-kind (sempre) + spartan / rundown | falar com user |

## Delegar (copiar)

```
Leia: skills/installed/ponytail/SKILL.md
```

## Por stack

**Orchestrator → user:** attention-kind SEMPRE (leia 1× por sessão)

**Backend:** ponytail, test-driven-development, security-and-hardening
**Frontend:** ponytail, frontend-ui-engineering, impeccable, animate
**Mobile:** ponytail, animate-expo, test-driven-development

Catálogo completo: `skills/catalog.yaml` · dispatch: `rules/skills-dispatch.md`
EOF
)"

if "$CLI" note read "Skills - Catalog" &>/dev/null; then
  "$CLI" note write "Skills - Catalog" "$BODY"
  echo "↻ Nota Skills - Catalog atualizada"
else
  "$CLI" note create "$BODY" --name "Skills - Catalog" --stack "Workflow"
  echo "+ Nota Skills - Catalog criada"
fi
