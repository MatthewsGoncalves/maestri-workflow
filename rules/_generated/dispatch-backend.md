# Skills — api-specialist

<!-- GERADO por scripts/gen-dispatch.sh — não edite. Fonte: skills/catalog.yaml -->

Paths: `skills/installed/<id>/SKILL.md`

**Defaults desta role:** `ponytail` — leia sem esperar ordem.


## design

| Quando | Skill | Path |
|---|---|---|
| Definir ou revisar o contrato entre stacks | `api-and-interface-design` | `skills/installed/api-and-interface-design/SKILL.md` |
| Validar a abordagem contra a doc oficial antes de implementar | `source-driven-development` | `skills/installed/source-driven-development/SKILL.md` |

## implement

| Quando | Skill | Path |
|---|---|---|
| Default de toda implementação — lazy senior | `ponytail` **(default)** | `skills/installed/ponytail/SKILL.md` |
| Task toca mais de um arquivo | `incremental-implementation` | `skills/installed/incremental-implementation/SKILL.md` |
| Lógica crítica, correção de bug ou mudança de comportamento | `test-driven-development` | `skills/installed/test-driven-development/SKILL.md` |
| Auth, dados sensíveis ou endpoint público | `security-and-hardening` | `skills/installed/security-and-hardening/SKILL.md` |
| Feature que vai rodar em produção | `observability-and-instrumentation` | `skills/installed/observability-and-instrumentation/SKILL.md` |

## review

| Quando | Skill | Path |
|---|---|---|
| Funciona mas está mais difícil de ler do que precisa | `code-simplification` | `skills/installed/code-simplification/SKILL.md` |

## ship

| Quando | Skill | Path |
|---|---|---|
| Configurar ou mexer em pipeline e quality gates | `ci-cd-and-automation` | `skills/installed/ci-cd-and-automation/SKILL.md` |
| Remover sistema/API ou migrar usuários e schema | `deprecation-and-migration` | `skills/installed/deprecation-and-migration/SKILL.md` |

## comm

| Quando | Skill | Path |
|---|---|---|
| Orchestrator: TODA resposta ao usuário (always_on). Outros: tom quando citado | `attention-kind` | `skills/installed/attention-kind/SKILL.md` |

## debug

| Quando | Skill | Path |
|---|---|---|
| Stack bloqueada em bug | `debugging-and-error-recovery` | `skills/installed/debugging-and-error-recovery/SKILL.md` |

## harden

| Quando | Skill | Path |
|---|---|---|
| Regressão de performance ou requisito explícito | `performance-optimization` | `skills/installed/performance-optimization/SKILL.md` |

Leia **somente** as skills citadas pelo Orchestrator + os defaults acima.
Não sabe qual? `./scripts/skillctl for --phase <fase> --role api-specialist`
