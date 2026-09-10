# Skills — orchestrator

<!-- GERADO por scripts/gen-dispatch.sh — não edite. Fonte: skills/catalog.yaml -->

Paths: `skills/installed/<id>/SKILL.md`

**Always-on:** `attention-kind` — já vale, não precisa ser citada.


## session_start

| Quando | Skill | Path |
|---|---|---|
| Início de sessão ou quando a qualidade das respostas cai | `context-engineering` | `skills/installed/context-engineering/SKILL.md` |
| Rede de segurança: o router e o skillctl não decidiram | `using-agent-skills` | `skills/installed/using-agent-skills/SKILL.md` |

## plan

| Quando | Skill | Path |
|---|---|---|
| Pedido bruto do usuário — precisa clarificar antes da spec | `idea-refine` | `skills/installed/idea-refine/SKILL.md` |
| Requisitos ambíguos — entrevistar o usuário uma pergunta por vez | `interview-me` | `skills/installed/interview-me/SKILL.md` |
| Feature nova sem especificação escrita | `spec-driven-development` | `skills/installed/spec-driven-development/SKILL.md` |
| Spec pronta — quebrar em tasks antes de subir stacks | `planning-and-task-breakdown` | `skills/installed/planning-and-task-breakdown/SKILL.md` |
| Uma vez por projeto — fixar o padrão de qualidade como contrato | `constraint-driven-development` | `skills/installed/constraint-driven-development/SKILL.md` |

## design

| Quando | Skill | Path |
|---|---|---|
| Definir ou revisar o contrato entre stacks | `api-and-interface-design` | `skills/installed/api-and-interface-design/SKILL.md` |
| Repo desconhecido ou fluxo complexo antes de arquitetar | `graphify` | `skills/installed/graphify/SKILL.md` |
| Validar a abordagem contra a doc oficial antes de implementar | `source-driven-development` | `skills/installed/source-driven-development/SKILL.md` |
| Decisão arquitetural que precisa ficar registrada | `documentation-and-adrs` | `skills/installed/documentation-and-adrs/SKILL.md` |
| Decisão cara ou difícil de reverter — cross-examinar antes | `doubt-driven-development` | `skills/installed/doubt-driven-development/SKILL.md` |
| Referência visual — 70+ brands disponíveis em design-md/ | `design-spec` | `skills/installed/design-spec/SKILL.md` |
| Precisa escolher biblioteca antes de codar | `pick-ui-library` | `skills/installed/pick-ui-library/SKILL.md` |
| Usuário descreve motion vagamente — traduzir para o termo exato | `animation-vocabulary` | `skills/installed/animation-vocabulary/SKILL.md` |

## review

| Quando | Skill | Path |
|---|---|---|
| Gate obrigatório antes do land | `ref-definition-of-done` | `skills/installed/ref-definition-of-done/SKILL.md` |

## ship

| Quando | Skill | Path |
|---|---|---|
| Antes do land / PR — alinhar com rules/project/git.md | `git-workflow-and-versioning` | `skills/installed/git-workflow-and-versioning/SKILL.md` |
| Release / go-live | `shipping-and-launch` | `skills/installed/shipping-and-launch/SKILL.md` |
| Configurar ou mexer em pipeline e quality gates | `ci-cd-and-automation` | `skills/installed/ci-cd-and-automation/SKILL.md` |
| Remover sistema/API ou migrar usuários e schema | `deprecation-and-migration` | `skills/installed/deprecation-and-migration/SKILL.md` |

## comm

| Quando | Skill | Path |
|---|---|---|
| Orchestrator: TODA resposta ao usuário (always_on). Outros: tom quando citado | `attention-kind` | `skills/installed/attention-kind/SKILL.md` |
| Update curto de status | `spartan` | `skills/installed/spartan/SKILL.md` |
| Handoff de fim de feature | `rundown` | `skills/installed/rundown/SKILL.md` |
| Comprimir doc, issue ou thread longa | `tldr` | `skills/installed/tldr/SKILL.md` |

## harden

| Quando | Skill | Path |
|---|---|---|
| Colher os comentários ponytail: antes que virem permanentes | `ponytail-debt` | `skills/installed/ponytail-debt/SKILL.md` |
| Antes de release | `ref-performance-checklist` | `skills/installed/ref-performance-checklist/SKILL.md` |
| Antes de release | `ref-observability-checklist` | `skills/installed/ref-observability-checklist/SKILL.md` |
| Revisar o próprio padrão de delegação do Orchestrator | `ref-orchestration-patterns` | `skills/installed/ref-orchestration-patterns/SKILL.md` |

Leia **somente** as skills citadas pelo Orchestrator + os defaults acima.
Não sabe qual? `./scripts/skillctl for --phase <fase> --role orchestrator`
