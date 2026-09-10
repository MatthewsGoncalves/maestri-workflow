# Context + land gate addendum (2026-09-10)

Resposta ao feedback do teste parcial (handoff stale, sync nunca executado, overlay não injetado).

## Problema raiz

Dois patches isolados (freshness + checkbox sync) tratam sintomas. A causa é **ausência de contrato machine-readable** entre Orchestrator efêmero e workers que leem notas por iniciativa.

## Solução unificada: Context Contract

| Peça | Função |
|------|--------|
| `.maestri/context.yaml` | Revisão, feature_id, stamp sync (gitignored) |
| Linha **CTX** no ask | Allowlist de notas + `handoff:yes\|no` + `rev=` |
| `worker-context.md` | Overlay slim compilado em workers |
| `security.worker.md` | Secrets only (~15 linhas) |
| `land-gate.sh` | `sync-memory --push` + stamp verificável |

## Debate resolvido

| Opção A (só freshness no handoff) | Rejeitada — chicken-and-egg: worker abre handoff para ver freshness |
| Opção B (só checkbox sync) | Rejeitada — honor system; teste provou que ninguém rodou |
| **Opção C unificada** | Adotada — CTX deny-by-default + stamp artifact |

## v1.1.1 defer

- `context-check` enforced em spawn-stack
- Wrap `maestri floor land` inside land-gate
- AGENTS.md export for Codex/OpenPix outside Maestri roles

## Próximo teste

`./scripts/smoke-memory.sh` offline + ciclo Maestri com CTX em todo ask.
