# Skills — reviewer

<!-- GERADO por scripts/gen-dispatch.sh — não edite. Fonte: skills/catalog.yaml -->

Paths: `skills/installed/<id>/SKILL.md`

**Defaults desta role:** `code-review-and-quality`, `ponytail-review` — leia sem esperar ordem.


## review

| Quando | Skill | Path |
|---|---|---|
| Default de todo review de stack | `code-review-and-quality` **(default)** | `skills/installed/code-review-and-quality/SKILL.md` |
| Default de todo review — camada anti over-engineering | `ponytail-review` **(default)** | `skills/installed/ponytail-review/SKILL.md` |
| Diff tocou motion ou CSS animation | `review-animations` | `skills/installed/review-animations/SKILL.md` |
| UI estática onde motion agregaria — read-only, propõe valores | `find-animation-opportunities` | `skills/installed/find-animation-opportunities/SKILL.md` |
| Funciona mas está mais difícil de ler do que precisa | `code-simplification` | `skills/installed/code-simplification/SKILL.md` |
| Gate obrigatório antes do land | `ref-definition-of-done` | `skills/installed/ref-definition-of-done/SKILL.md` |
| Diff tocou input, auth ou integração externa | `ref-security-checklist` | `skills/installed/ref-security-checklist/SKILL.md` |
| Diff tocou UI | `ref-accessibility-checklist` | `skills/installed/ref-accessibility-checklist/SKILL.md` |
| Avaliar qualidade e cobertura dos testes do diff | `ref-testing-patterns` | `skills/installed/ref-testing-patterns/SKILL.md` |

## comm

| Quando | Skill | Path |
|---|---|---|
| Orchestrator: TODA resposta ao usuário (always_on). Outros: tom quando citado | `attention-kind` | `skills/installed/attention-kind/SKILL.md` |
| Comprimir doc, issue ou thread longa | `tldr` | `skills/installed/tldr/SKILL.md` |

## harden

| Quando | Skill | Path |
|---|---|---|
| Audit de over-engineering repo-wide (não é diff) | `ponytail-audit` | `skills/installed/ponytail-audit/SKILL.md` |
| Colher os comentários ponytail: antes que virem permanentes | `ponytail-debt` | `skills/installed/ponytail-debt/SKILL.md` |
| Audit de motion do repo — gera plano para a stack executar | `improve-animations` | `skills/installed/improve-animations/SKILL.md` |
| Antes de release | `ref-performance-checklist` | `skills/installed/ref-performance-checklist/SKILL.md` |
| Antes de release | `ref-observability-checklist` | `skills/installed/ref-observability-checklist/SKILL.md` |

Leia **somente** as skills citadas pelo Orchestrator + os defaults acima.
Não sabe qual? `./scripts/skillctl for --phase <fase> --role reviewer`
