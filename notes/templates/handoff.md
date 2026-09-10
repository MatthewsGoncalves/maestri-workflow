# Handoff — {{FEATURE_NAME}}

---
feature_id: {{FEATURE_NAME}}
updated_at: YYYY-MM-DDTHH:MM:SSZ
---

> Nota rolling da feature. Sobrevive ao `/clear` dos workers.
> Frontmatter = espelho humano (opcional). Autoridade: linha **CTX** no ask + `.maestri/context.yaml`.
> **Workers:** só leiam se `handoff:yes`. Orchestrator: `context-bump.sh` após edição material.

## Status por stack

| Stack | Branch | Status | Paths | Atualizado por |
|-------|--------|--------|-------|----------------|
| Backend  | | not-started \| in-progress \| needs-review \| approved | | |
| Frontend | | | | |
| Mobile   | | | | |

## Blockers abertos

- [ ]

## Gate pré-land

Critério completo: `skills/installed/ref-definition-of-done/SKILL.md`

- [ ] Critérios de aceite da `spec` atendidos
- [ ] `api-contract` reflete o que foi implementado
- [ ] Reviewer aprovou cada stack tocada
- [ ] Testes verdes / CI verde
- [ ] Sem `ponytail:` novo sem dono (ver `ponytail-debt`)
- [ ] `./scripts/land-gate.sh` OK (stamp em `.maestri/memory-sync.stamp`)

## Ordem de land

1. [ ] Backend → main
2. [ ] Frontend → main
3. [ ] Mobile → main

## Pós-land

- [ ] `./scripts/land-gate.sh` executado (sync-memory + stamp)
- [ ] Smoke test integrado
- [ ] Recruits dispensados (`maestri list` → zero ociosos)
- [ ] Gotchas levados para `Aprendizados`
- [ ] `spec` resetada · `./scripts/context-bump.sh` nova feature
