# AGENTS.md — ai-workflow template (white-label)

Este repo é um **template Maestri white-label** — importe com `maestri workspace create --from "Workflow"` ou clone + `init-project.sh`. Ver **WHITELABEL.md**.

Agentes recrutados aqui seguem roles + regras abaixo.

## Leitura obrigatória

1. `rules/README.md` — mapa das regras
2. `rules/universal/` — maestri, token-economy, communication
3. Sua role em `rules/` (orchestrator, reviewer, ou `rules/stacks/`)
4. Notas no canvas: `spec`, `api-contract`, `design-tokens`

## Roles Maestri

| Role | Regras |
|------|--------|
| Orchestrator | `rules/orchestrator.md` |
| Reviewer | `rules/reviewer.md` |
| API Specialist | `rules/stacks/backend.md` |
| UI Builder | `rules/stacks/frontend.md` |
| Mobile Dev | `rules/stacks/mobile.md` |

## Projeto alvo

Preencha `rules/project/` (git, communications, paths) para **este** repo.

- **Kernel** = como agentes colaboram (Maestri, stacks, review)
- **Overlay** = GitHub vs GitLab, Slack vs Teams, paths do monorepo
- **Código** = `CLAUDE.md` / lint / testes no app

## Maestri

- `maestri list` antes de delegar
- Subagentes internos proibidos — use `maestri ask`
- Ver `README.md` para scripts de bootstrap
