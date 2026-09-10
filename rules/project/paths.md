# Paths — {{PROJECT_NAME}}

> Onde cada stack trabalha neste monorepo (ou repos separados).

## Layout

- [ ] Monorepo único
- [ ] Repos separados (andares usam `--dir` no recruit)

## Stacks

| Stack | Andar Maestri | Path(s) | Comandos úteis |
|-------|---------------|---------|----------------|
| Backend | `Backend` | | `npm test`, … |
| Frontend | `Frontend` | | |
| Mobile | `Mobile` | | |

## Shared packages

| Package | Path | Consumido por |
|---------|------|---------------|
| | | |

## Env / secrets

Onde ficam: `.env.example`, vault, platform secrets — **nunca** commitar.

## Deploy (referência)

| Stack | Ambiente | Como |
|-------|----------|------|
| Backend | | |
| Frontend | | |
| Mobile | | |

Kernel não executa deploy; stacks seguem esta tabela se Orchestrator pedir.
