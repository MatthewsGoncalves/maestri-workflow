# Skills — bibliotecas e catálogo

Skills são instaladas em `skills/vendor/` e linkadas em `skills/installed/<id>/`.

```bash
./scripts/install-skills.sh   # clone + link
./scripts/link-skills.sh      # só relink
```

Índice machine-readable: `skills/catalog.yaml`

## Repositórios fonte

| ID vendor | Repositório | Licença |
|-----------|-------------|---------|
| `engineering` | [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) | Ver repo |
| `simplicity` | [dietrichgebert/ponytail](https://github.com/dietrichgebert/ponytail) | MIT |
| `communication` | [alexgreensh/attention-span](https://github.com/alexgreensh/attention-span) | Ver repo |
| `design-spec` | [VoltAgent/awesome-design-md](https://github.com/VoltAgent/awesome-design-md) | Ver repo |
| `ui-motion` | [emilkowalski/skills](https://github.com/emilkowalski/skills) | Ver repo |
| `polish` | [pbakaus/impeccable](https://github.com/pbakaus/impeccable) | Apache 2.0 |
| `diagrams` | [Graphify-Labs/graphify](https://github.com/Graphify-Labs/graphify) | Ver repo |

## Skills linkadas (installed)

### Plan (Orchestrator)

| ID | Uso |
|----|-----|
| `idea-refine` | Pedido vago |
| `interview-me` | Entrevistar usuário |
| `spec-driven-development` | Escrever spec |
| `planning-and-task-breakdown` | Tasks |
| `documentation-and-adrs` | ADRs |

### Design

| ID | Uso |
|----|-----|
| `api-and-interface-design` | api-contract |
| `graphify` | Mapa de codebase |
| `design-spec-vercel` | Referência visual (exemplo; troque brand) |

### Implement (stacks)

| ID | Stack |
|----|-------|
| `ponytail` | Todas (default) |
| `incremental-implementation` | Feature grande |
| `test-driven-development` | Backend, mobile |
| `frontend-ui-engineering` | Frontend |
| `impeccable` | UI polish |
| `animate` / `animate-expo` | Motion |
| `security-and-hardening` | Backend sensível |

### Review

| ID | Uso |
|----|-----|
| `code-review-and-quality` | Todo review |
| `ponytail-review` | Anti bloat |
| `review-animations` | Diff com motion |

### Comm

| ID | Uso |
|----|-----|
| `attention-kind` | **Orchestrator → user (sempre)** |
| `spartan` | Status curto |
| `rundown` | Fim de feature |
| `tldr` | Resumir documento |

### Ship

| ID | Uso |
|----|-----|
| `git-workflow-and-versioning` | Land / PR |
| `shipping-and-launch` | Release |

## Como invocar

Orchestrator na delegação:

```
Leia: skills/installed/ponytail/SKILL.md
```

**Não** mande ler vendor inteiro. **1–3 skills por ask.**

Dispatch completo: `rules/skills-dispatch.md`

## Atualizar skills

```bash
cd skills/vendor/engineering && git pull
cd ../../..
./scripts/link-skills.sh
```

Ou reclone: `./scripts/install-skills.sh`
