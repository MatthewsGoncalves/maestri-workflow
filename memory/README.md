# memory/ — espelho git das notas duráveis

Fonte **durante a feature:** notas no canvas Maestri.  
Esta pasta é backup versionado — **one-way** via `./scripts/sync-memory.sh`.

| Arquivo | Nota canvas | Dono |
|---------|-------------|------|
| `decisions.md` | `decisions` | Orchestrator |
| `aprendizados.md` | `Aprendizados` | Reviewer |
| `quality-bar.md` | `quality-bar` | Orchestrator |
| `api-contract.md` | `api-contract` | Orchestrator |

## Comandos

```bash
./scripts/sync-memory.sh --push   # canvas → memory/ (com redação)
./scripts/sync-memory.sh --pull   # memory/ → canvas (import/restore)
```

## Segurança

- Todo `--push` passa por `memory-redact.sh`
- Nunca commite secrets — ver `rules/project/security.md`
- Rascunhos locais sensíveis: `memory/.local.md` (gitignored)

## Git

Política em `rules/project/memory.md` (`track_in_git`). Template default: **track true**.
