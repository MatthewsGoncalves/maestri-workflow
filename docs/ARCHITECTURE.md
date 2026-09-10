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
└── Notas: spec, api-contract, design-tokens, handoff, quality-bar,
            decisions, Aprendizados, Skills - Router

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

`skills/catalog.yaml` é a **fonte única**: 55 skills com fase, roles, triggers,
custo e nota de destino. Tudo o mais é derivado por `scripts/skillctl`:

```
skills/catalog.yaml
   ├── skillctl link      → skills/installed/<id>/SKILL.md   (paths estáveis)
   ├── gen-dispatch.sh    → rules/_generated/dispatch-*.md   (prompts das roles)
   ├── skillctl render docs → docs/SKILLS.md
   └── sync-skills-note.sh  → nota canvas "Skills - Router"
```

**Fases:** `plan → design → implement → review → ship` (lineares), `comm`
(transversal), `debug` e `harden` (interrupts), `session_start` (1×/sessão).

O Orchestrator não memoriza o catálogo — consulta
`./scripts/skillctl for --phase <fase> --role <role>`. Ver `docs/SKILLS.md`.

## Token model

| Sempre ON | Sob demanda |
|-----------|-------------|
| Orchestrator (1 terminal) | 0–3 stack agents |
| attention-kind (com user) | 0–1 Reviewer |

Princípio: agente ligado sem trabalho = contexto caro no próximo turno.
