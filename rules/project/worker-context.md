# Context contract — workers

> Leia **somente** o que o Orchestrator autorizar na linha **CTX** do seu `maestri ask`.
> Não leia notas por iniciativa — stale handoff piora que contexto zero.

## Linha CTX (obrigatória no ask)

```
CTX: feature=feat-x phase=implement handoff:no notes:spec,api-contract
```

| Campo | Significado |
|-------|-------------|
| `feature=` | Escopo desta mensagem — se a task citar outra feature, **blocked** |
| `phase=` | plan \| implement \| debug \| review |
| `handoff:` | `yes` = pode ler `handoff` · `no` = **proibido** ler handoff |
| `notes:` | Allowlist — só estas notas (suporta `Aprendizados:tail15`) |

## Regras

1. **Sem linha CTX** → `Status: blocked — peça CTX ao Orchestrator`
2. **`handoff:no`** → não rode `maestri note read "handoff"`
3. **`handoff:yes`** → leia handoff só para esta mensagem
4. Escreveu em nota? Só `handoff` (status) — nunca secrets (ver security.worker)

## Reporte blocked

```
Status: blocked
Motivo: handoff:no | CTX ausente | feature mismatch
Próximo: Orchestrator novo ask com CTX atualizado
```

## Orchestrator gera CTX

```bash
./scripts/context-bump.sh --feature feat/x [--handoff-allowed yes]
./scripts/context-ask.sh --phase implement --notes spec,api-contract
```
