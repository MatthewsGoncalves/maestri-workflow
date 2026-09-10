# Arquitetura

## Três camadas

```
┌─────────────────────────────────────────┐
│  KERNEL (este repo — igual em todo projeto) │
│  rules/universal, stacks, reviewer      │
│  skills/catalog, scripts, 5 roles       │
└─────────────────────────────────────────┘
                    +
┌─────────────────────────────────────────┐
│  OVERLAY (rules/project/ — por app)     │
│  git, communications, paths             │
└─────────────────────────────────────────┘
                    +
┌─────────────────────────────────────────┐
│  CÓDIGO (repo do produto)               │
│  CLAUDE.md, lint, frameworks            │
└─────────────────────────────────────────┘
```

## Canvas Maestri

```
Ground
├── Terminal Maestro → role Orchestrator
├── Reviewer (recruit sob demanda)
└── Notas: spec, api-contract, design-tokens, Skills - Catalog, …

Andar Backend   → clone git + branch → API Specialist
Andar Frontend  → clone git + branch → UI Builder
Andar Mobile    → clone git + branch → Mobile Dev
```

**Andar = stack.** Isolamento git evita stacks pisarem uma na outra.

## Roles

| Role | Escopo | Persistência |
|------|--------|--------------|
| Orchestrator | Ground, coordena | Entre features |
| Reviewer | Review all stacks | Sob demanda |
| API Specialist | Backend andar | Por feature |
| UI Builder | Frontend andar | Por feature |
| Mobile Dev | Mobile andar | Por feature |

Prompt de cada role = universal + regras do papel + overlay project + skills dispatch + ops Maestri.

Compilado por `./scripts/bootstrap-roles.sh`.

## Fluxo de dados

```
Usuário → Orchestrator → notas (spec, api-contract)
                ↓
         maestri ask → stacks (paralelo)
                ↓
         commits → Reviewer (sequencial)
                ↓
         floor land → main
                ↓
         dismiss recruits
```

## Agent-agnostic

O workflow vive em:

- Roles Maestri (globais)
- `rules/` no git
- Notas no canvas

O **preset** (`Claude Code`, `Cursor`, …) é substituível com `maestri recruit --replace` sem perder canvas, notas ou conexões.

## Skills

Orchestrator escolhe **quando** invocar. Paths estáveis:

`skills/installed/<id>/SKILL.md`

Ver `docs/SKILLS.md`.

## Token model

| Sempre ON | Sob demanda |
|-----------|-------------|
| Orchestrator (1 terminal) | 0–3 stack agents |
| attention-kind (com user) | 0–1 Reviewer |

Princípio: agente ligado sem trabalho = contexto caro no próximo turno.
