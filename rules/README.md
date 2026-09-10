# Regras — workflow Maestri (ai-workflow)

Fonte oficial versionada em git. Se o canvas for resetado ou um recruit recriado, reconstrua a partir daqui.

## Estrutura

```
rules/
├── universal/          # vale para TODOS os papéis
│   ├── principles.md
│   ├── agent-lifecycle.md
│   ├── token-economy.md
│   ├── maestri.md
│   └── communication.md
├── orchestrator.md
├── reviewer.md
├── stacks/{backend,frontend,mobile}.md
├── _generated/         # dispatch de skills — NÃO EDITE (gen-dispatch.sh)
└── project/            # overlay por projeto
```

## Formato de cada arquivo

- **Papel** — quem é
- **Objetivo** — o que entrega
- **Escopo** — o que faz
- **Limites** — o que NÃO faz
- **Handoff** — pra quem reporta e quando

## Sincronizar com Maestri

Após editar regras:

```bash
./scripts/bootstrap-roles.sh   # recompõe prompts das roles globais
```

Roles = `rules/universal/*` + regra do papel + `roles/*.md` (comandos Maestri).

## Overlay por projeto (`rules/project/`)

Kernel **não** inclui GitLab, GitHub, Slack nem Teams. Cada app preenche:

- `git.md` — host, branches, PR/MR
- `communications.md` — canais humanos
- `paths.md` — monorepo / stacks

## Agent-agnostic

| Agente | Onde lê |
|--------|---------|
| Maestri (qualquer preset) | Role assign → prompt compilado |
| Claude Code | `CLAUDE.md` + role |
| Cursor | `.cursor/rules/` ou `AGENTS.md` |
| Antigravity / Codex | `AGENTS.md` |

Convenções de **código** do app: `CLAUDE.md`, `.cursor/rules/` no repo do produto.

## Notas no canvas

| Nota | Dono | Função |
|------|------|--------|
| `spec` | Orchestrator | Escopo da feature |
| `api-contract` | Orchestrator | Contrato entre stacks |
| `design-tokens` | Orchestrator | UI compartilhada |
| `handoff` | Qualquer worker | Estado rolling da feature + gate pré-land |
| `quality-bar` | Orchestrator | Padrão de qualidade do projeto (durável) |
| `decisions` | Orchestrator | Log append-only de ADRs |
| `Aprendizados` | Reviewer + stacks | Gotchas curados (não log) |
