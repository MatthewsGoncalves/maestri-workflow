# Skills — catálogo

<!-- GERADO por scripts/skillctl render docs — não edite. -->

Instalação: `./scripts/install-skills.sh` · relink: `./scripts/skillctl link`
Consulta: `./scripts/skillctl for --phase <fase> [--role <role>] [--tags a,b]`


## session_start

| Skill | Roles | Custo | Quando |
|---|---|---|---|
| `context-engineering` | orchestrator | light | Início de sessão ou quando a qualidade das respostas cai |
| `using-agent-skills` | orchestrator | light | Rede de segurança: o router e o skillctl não decidiram |

## plan

| Skill | Roles | Custo | Quando |
|---|---|---|---|
| `idea-refine` | orchestrator | medium | Pedido bruto do usuário — precisa clarificar antes da spec |
| `interview-me` | orchestrator | medium | Requisitos ambíguos — entrevistar o usuário uma pergunta por vez |
| `spec-driven-development` | orchestrator | medium | Feature nova sem especificação escrita |
| `planning-and-task-breakdown` | orchestrator | light | Spec pronta — quebrar em tasks antes de subir stacks |
| `constraint-driven-development` | orchestrator | medium | Uma vez por projeto — fixar o padrão de qualidade como contrato |

## design

| Skill | Roles | Custo | Quando |
|---|---|---|---|
| `api-and-interface-design` | orchestrator, api-specialist | medium | Definir ou revisar o contrato entre stacks |
| `graphify` | orchestrator | heavy | Repo desconhecido ou fluxo complexo antes de arquitetar |
| `source-driven-development` | orchestrator, api-specialist, ui-builder, mobile-dev | medium | Validar a abordagem contra a doc oficial antes de implementar |
| `documentation-and-adrs` | orchestrator | light | Decisão arquitetural que precisa ficar registrada |
| `doubt-driven-development` | orchestrator | heavy | Decisão cara ou difícil de reverter — cross-examinar antes |
| `design-spec` | orchestrator, ui-builder | light | Referência visual — 70+ brands disponíveis em design-md/ |
| `pick-ui-library` | orchestrator, ui-builder | light | Precisa escolher biblioteca antes de codar |
| `apple-design` | ui-builder, mobile-dev | medium | UI dirigida por gesto, spring ou sheet |
| `animation-vocabulary` | orchestrator, ui-builder | light | Usuário descreve motion vagamente — traduzir para o termo exato |
| `prototype` | ui-builder | heavy | Usuário indeciso entre direções visuais |

## implement

| Skill | Roles | Custo | Quando |
|---|---|---|---|
| `ponytail` | api-specialist, ui-builder, mobile-dev | light | Default de toda implementação — lazy senior |
| `incremental-implementation` | api-specialist, ui-builder, mobile-dev | light | Task toca mais de um arquivo |
| `test-driven-development` | api-specialist, mobile-dev | medium | Lógica crítica, correção de bug ou mudança de comportamento |
| `security-and-hardening` | api-specialist | medium | Auth, dados sensíveis ou endpoint público |
| `observability-and-instrumentation` | api-specialist | medium | Feature que vai rodar em produção |
| `frontend-ui-engineering` | ui-builder | medium | Default de UI web — componentes, estado, acessibilidade |
| `impeccable` | ui-builder | heavy | UI nova ou redesign — polish de produto |
| `emil-design-eng` | ui-builder | medium | Craft de componente — os detalhes invisíveis |
| `animate` | ui-builder | medium | Animação web do zero |
| `animate-expo` | ui-builder, mobile-dev | medium | Animação em React Native / Expo |
| `ask-sonner` | ui-builder | light | Toasts com Sonner |
| `write-swift` | mobile-dev | medium | Swift / iOS nativo |

## review

| Skill | Roles | Custo | Quando |
|---|---|---|---|
| `code-review-and-quality` | reviewer | medium | Default de todo review de stack |
| `ponytail-review` | reviewer | light | Default de todo review — camada anti over-engineering |
| `review-animations` | reviewer | medium | Diff tocou motion ou CSS animation |
| `find-animation-opportunities` | reviewer, ui-builder | medium | UI estática onde motion agregaria — read-only, propõe valores |
| `code-simplification` | reviewer, api-specialist, ui-builder, mobile-dev | medium | Funciona mas está mais difícil de ler do que precisa |
| `ref-definition-of-done` | orchestrator, reviewer | light | Gate obrigatório antes do land |
| `ref-security-checklist` | reviewer | light | Diff tocou input, auth ou integração externa |
| `ref-accessibility-checklist` | reviewer | light | Diff tocou UI |
| `ref-testing-patterns` | reviewer | light | Avaliar qualidade e cobertura dos testes do diff |

## ship

| Skill | Roles | Custo | Quando |
|---|---|---|---|
| `git-workflow-and-versioning` | orchestrator | light | Antes do land / PR — alinhar com rules/project/git.md |
| `shipping-and-launch` | orchestrator | medium | Release / go-live |
| `ci-cd-and-automation` | orchestrator, api-specialist | medium | Configurar ou mexer em pipeline e quality gates |
| `deprecation-and-migration` | orchestrator, api-specialist | heavy | Remover sistema/API ou migrar usuários e schema |

## comm

| Skill | Roles | Custo | Quando |
|---|---|---|---|
| `attention-kind` | orchestrator, reviewer, api-specialist, ui-builder, mobile-dev | light | Orchestrator: TODA resposta ao usuário (always_on). Outros: tom quando citado |
| `spartan` | orchestrator | light | Update curto de status |
| `rundown` | orchestrator | light | Handoff de fim de feature |
| `tldr` | orchestrator, reviewer | light | Comprimir doc, issue ou thread longa |

## debug

| Skill | Roles | Custo | Quando |
|---|---|---|---|
| `debugging-and-error-recovery` | api-specialist, ui-builder, mobile-dev | medium | Stack bloqueada em bug |
| `browser-testing-with-devtools` | ui-builder | medium | Bug que só reproduz no navegador |

## harden

| Skill | Roles | Custo | Quando |
|---|---|---|---|
| `performance-optimization` | api-specialist, ui-builder, mobile-dev | heavy | Regressão de performance ou requisito explícito |
| `ponytail-audit` | reviewer | heavy | Audit de over-engineering repo-wide (não é diff) |
| `ponytail-debt` | orchestrator, reviewer | light | Colher os comentários ponytail: antes que virem permanentes |
| `improve-animations` | reviewer | heavy | Audit de motion do repo — gera plano para a stack executar |
| `ref-performance-checklist` | orchestrator, reviewer | light | Antes de release |
| `ref-observability-checklist` | orchestrator, reviewer | light | Antes de release |
| `ref-orchestration-patterns` | orchestrator | light | Revisar o próprio padrão de delegação do Orchestrator |
