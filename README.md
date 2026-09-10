# Maestri Workflow

Template **white-label** para orquestrar projetos no [Maestri](https://maestri.app) — monolitos com backend, frontend e mobile, **qualquer agente** (Claude, Cursor, Codex, Antigravity…).

**North star:** rápido · otimizado · certeiro — ver [`rules/universal/principles.md`](rules/universal/principles.md).

## O que é

Um pacote instalável com:

- **5 roles** Maestri (Orchestrator, Reviewer, 3 stacks)
- **Regras** versionadas em git (`rules/`)
- **Skills** curadas de repos open source (`skills/`)
- **Scripts** de bootstrap, andares e delegação
- **Escopo fechado v1.0** → [`docs/SCOPE.md`](docs/SCOPE.md)
- **Memória + segurança v1.1** → [`docs/MEMORY.md`](docs/MEMORY.md)
- **Manual do Orquestrador** → [`docs/ORCHESTRATOR-MANUAL.md`](docs/ORCHESTRATOR-MANUAL.md)

## Instalação rápida

Requisitos: [Maestri](https://maestri.app) + terminal em **Maestro Mode** + `git`

```bash
git clone https://github.com/MatthewsGoncalves/maestri-workflow.git ~/Work/meu-app
cd ~/Work/meu-app
chmod +x scripts/*.sh
./scripts/init-project.sh "Meu App" "Orquestrator"
./scripts/install-skills.sh
./scripts/init-notes.sh
./scripts/bootstrap-roles.sh
```

No Maestri: assign role **Orchestrator** ao terminal Maestro na UI.

→ Instalação completa: [`docs/INSTALL.md`](docs/INSTALL.md)

## Como funciona (30 segundos)

```
Ground (Maestro)
  Orchestrator  — coordena, fala com você (attention-kind sempre ativo)
  Reviewer      — sob demanda, revisa todas as stacks
  notas: spec, api-contract, design-tokens, …

Andares = stacks (sob demanda, dismiss quando acabar)
  Backend  → API Specialist
  Frontend → UI Builder
  Mobile   → Mobile Dev
```

**Agentes 24/7 gastam tokens** — só Orchestrator persistente; workers: chamado → age → `/clear` → dismiss.

## Documentação

| Doc | Conteúdo |
|-----|----------|
| [INSTALL.md](docs/INSTALL.md) | Instalação passo a passo |
| [ORCHESTRATOR-MANUAL.md](docs/ORCHESTRATOR-MANUAL.md) | Manual para quem opera o Maestro |
| [ARCHITECTURE.md](docs/ARCHITECTURE.md) | Kernel, overlay, andares, fluxo |
| [SKILLS.md](docs/SKILLS.md) | Bibliotecas de skills e quando usar |
| [WHITELABEL.md](WHITELABEL.md) | Importar em outro dir / workspace |

## Skills incluídas (fontes)

| Pacote | Repositório |
|--------|-------------|
| Engineering | [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) |
| Simplicity | [dietrichgebert/ponytail](https://github.com/dietrichgebert/ponytail) |
| Communication | [alexgreensh/attention-span](https://github.com/alexgreensh/attention-span) |
| Design spec | [VoltAgent/awesome-design-md](https://github.com/VoltAgent/awesome-design-md) |
| UI / motion | [emilkowalski/skills](https://github.com/emilkowalski/skills) |
| Polish | [pbakaus/impeccable](https://github.com/pbakaus/impeccable) |
| Diagrams | [Graphify-Labs/graphify](https://github.com/Graphify-Labs/graphify) |

## Licença

MIT — ver [LICENSE](LICENSE). Skills externas têm licenças próprias nos repos de origem.
