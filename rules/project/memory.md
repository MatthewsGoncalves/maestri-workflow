# Memória — {{PROJECT_NAME}}

> Política de leitura e espelho git. Conteúdo vive no canvas; `memory/` é backup
> versionado das duráveis.

## Git

```yaml
track_in_git: true   # false → não commite memory/*.md (só README); use .local.md local
```

Espelho (4 arquivos): `decisions`, `Aprendizados`, `quality-bar`, `api-contract`.

**Não espelha:** `spec` (reset/feature), `handoff` (rolling), `design-tokens`, `Skills - Router`.

## Matriz de leitura (eficiência)

| Fase | Ler | Ignorar |
|------|-----|---------|
| Plan | `spec`, trecho relevante de `api-contract` | Aprendizados inteiro, ADRs antigos |
| Implement | `spec` + contrato da área + **últimas 15 linhas** de Aprendizados | `decisions` histórico completo |
| Debug | `handoff` + gotcha da stack em Aprendizados | spec se escopo não mudou |
| Review | diff + `quality-bar` + checklist security | design-tokens se UI intacta |
| Land | gate em `handoff` + ordem merge | — |

Orchestrator: cite no `maestri ask` quais notas/seções ler — não “leia tudo”.

## Context contract (anti-stale)

Arquivo gitignored: `.maestri/context.yaml` (exemplo: `.maestri/context.yaml.example`).

| Evento | Comando |
|--------|---------|
| Editou handoff/spec | `./scripts/context-bump.sh --feature feat/x` |
| Delegar worker | `./scripts/context-ask.sh --phase implement` → colar linha CTX no ask |
| Debug c/ handoff | `context-ask.sh --phase debug --handoff yes` |
| Land | `./scripts/land-gate.sh` → stamp `.maestri/memory-sync.stamp` |

Workers leem **só** allowlist da linha CTX. `handoff:no` por default em implement.

## Limites soft (consultivos)

| Nota | Limite | Quem enforça |
|------|--------|--------------|
| Aprendizados | 40 linhas | Reviewer dedupa antes de append |
| `handoff` | Rolling por feature | Orchestrator reseta gate pós-land |
| ADR em `decisions` | Append-only | Orchestrator — supersede, não apague |

## Ritual sync

```bash
# Após land ou quando duráveis mudaram:
./scripts/sync-memory.sh --push

# Import / restore de backup:
./scripts/init-notes.sh
./scripts/sync-memory.sh --pull
```

Fichário canvas sugerido: **Memory** (duráveis) · **Workflow** (spec, handoff, Skills - Router).
