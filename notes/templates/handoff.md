# Handoff — {{FEATURE_NAME}}

> Nota rolling da feature. Sobrevive ao `/clear` dos workers — é aqui que o
> estado mora, não nas mensagens `maestri ask`. Qualquer worker escreve.

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

## Ordem de land

1. [ ] Backend → main
2. [ ] Frontend → main
3. [ ] Mobile → main

## Pós-land

- [ ] Smoke test integrado
- [ ] Recruits dispensados (`maestri list` → zero ociosos)
- [ ] Gotchas levados para `Aprendizados`
- [ ] `spec` resetada para a próxima feature
