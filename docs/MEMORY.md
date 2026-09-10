# Memória e segurança (v1.1)

Como o template persiste conhecimento entre features **sem** agentes 24/7 e **sem** vazar secrets.

## Três camadas

| Camada | Onde | Quando usar |
|--------|------|-------------|
| Canvas | Notas Maestri | Durante a feature (fonte viva) |
| Git | `memory/*.md` | Backup, diff, import de projeto |
| Overlay | `rules/project/security.md`, `memory.md` | Política compilada nas roles |

## Notas canvas (8 — v1.0)

| Nota | Fichário | Dono | Espelho git |
|------|----------|------|-------------|
| `spec` | Workflow | Orchestrator | — |
| `handoff` | Workflow | Workers | — |
| `design-tokens` | Workflow | Orchestrator | — |
| `api-contract` | Memory | Orchestrator | ✓ |
| `quality-bar` | Memory | Orchestrator | ✓ |
| `decisions` | Memory | Orchestrator | ✓ |
| `Aprendizados` | Memory | Reviewer | ✓ |
| `Skills - Router` | Workflow | gerado | — |

## Bootstrap de notas

```bash
./scripts/init-notes.sh          # cria notas faltantes a partir de templates
./scripts/sync-skills-note.sh    # Skills - Router
./scripts/sync-memory.sh --pull  # memory/ → canvas (import)
```

## Sync pós-feature (land)

```bash
./scripts/context-bump.sh --feature feat/x    # após editar handoff
./scripts/land-gate.sh                        # sync + stamp (não só documentação)
```

## Context contract (anti-stale)

Todo `maestri ask` a worker começa com linha CTX:

```bash
./scripts/context-ask.sh --phase implement
# CTX: feature=feat/x phase=implement handoff:no notes:spec,api-contract,Aprendizados:tail15
```

- **`handoff:no`** default em implement — evita handoff stale
- Workers compilados com `worker-context.md` + `security.worker.md`
- Estado machine-readable: `.maestri/context.yaml` (gitignored)

## Redação

`memory-redact.sh` mascara antes de gravar em `memory/`:

- OpenAI `sk-…`, GitHub `ghp_…`, AWS `AKIA…`, Slack `xox…`
- JWT, `Bearer …`, linhas `password=` / `api_key=`

**Não substitui** revisão humana — ver checklist em `rules/project/security.md`.

## Eficiência (matriz de leitura)

Compilada em `rules/project/memory.md`. Resumo:

- **Implement:** spec + contrato da área + últimas 15 linhas de Aprendizados
- **Debug:** handoff + gotcha relevante
- **Review:** diff + quality-bar + security checklist

Orchestrator cita seções no `maestri ask` — evite “leia todas as notas”.

## Limites soft

- Aprendizados: ~40 linhas — Reviewer dedupa
- `decisions`: append-only ADRs

## Git policy

`rules/project/memory.md`:

```yaml
track_in_git: true
```

Se `false`, não commite `memory/*.md` (mantenha só local). `memory/.local.md` é sempre gitignored.

## Design

Spec aprovada: `docs/superpowers/specs/2026-09-09-memory-security-design.md`
