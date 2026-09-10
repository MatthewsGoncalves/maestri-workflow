# Memory + Security — design v1.1

Aprovado 2026-09-09. Escopo: segurança e eficiência de memória com prioridade igual (resposta C + abordagem híbrida C).

## Problema

v1.0 usa 8 notas canvas como memória, mas:

- Notas duráveis não têm backup git nem sync
- Sem política de redação de secrets
- Workers leem notas inteiros — custo de token cresce com Aprendizados/decisions
- Segurança só via skills + linhas esparsas em overlay

## Solução

Três camadas:

1. **Canvas** — fonte durante a feature (contrato v1.0 inalterado)
2. **`memory/*.md`** — espelho git das 4 duráveis, one-way via script + redação
3. **`rules/project/security.md` + `memory.md`** — overlay versionado (política, matriz de leitura)

## Componentes

| Artefato | Função |
|----------|--------|
| `rules/project/security.md` | Boundaries, proibido em notas, checklist pré-sync |
| `rules/project/memory.md` | Matriz de leitura por fase, limites soft, `track_in_git` |
| `memory/{decisions,aprendizados,quality-bar,api-contract}.md` | Espelho git |
| `memory/.local.md` | Gitignored — rascunhos locais |
| `scripts/memory-redact.sh` | Mascara padrões sensíveis (stdlib) |
| `scripts/sync-memory.sh` | `--push` canvas→git, `--pull` git→canvas |
| `scripts/init-notes.sh` | Cria notas faltantes a partir de templates |

## Lifecycle

- **Implement / debug:** workers leem canvas; seguem matriz em `memory.md`
- **Review:** Reviewer cura Aprendizados (máx 40 linhas, dedupe)
- **Land:** Orchestrator `./scripts/sync-memory.sh --push` após gate handoff
- **Import:** `init-notes.sh` + `sync-memory.sh --pull` se `memory/` existir

## Não escopo v1.1

- Métricas de token
- Sync bidirecional com merge
- Hook hard que bloqueia secrets em notas
- Espelhar design-tokens

## Referência

Guia operacional: `docs/MEMORY.md`
