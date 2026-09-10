# Regras universais — Maestri

Valem para **todos** os papéis deste workflow.

## Um terminal = um papel

- Todo trabalho de outro papel acontece em **outro terminal Maestri**, via `maestri ask "Nome" "..."`.
- **Nunca** use subagentes internos do agente (Claude `Agent`/Task, Cursor subagents, etc.).
- Se "precisar de ajuda", isso é outro papel — acione via Maestri.

## Antes de agir

1. `maestri list` — veja time, notas e conexões.
2. Leia notas relevantes (`spec`, `api-contract`, …) **uma vez** por handoff.
3. Confirme escopo com Orchestrator se algo não estiver em `spec`.

## Comunicação entre papéis

- Reporte ao **Orchestrator** salvo instrução explícita em contrário.
- Perguntas cross-stack (factual, pontual) → Orchestrator coordena; não invente peers.
- Ao terminar: mensagem curta com branch, paths alterados e status.

## Agent-agnostic

- Não assuma ferramentas de um agente específico; use o que estiver disponível no terminal.
- Limpar sessão: `/clear` (Claude), novo chat, ou equivalente — quando Orchestrator encerrar sua parte.
- Regras de código do repo alvo vivem em `AGENTS.md` / `CLAUDE.md` / `.cursor/rules/` **do projeto**, não neste template.

## Scripts > agentes

Cálculos, lint, testes, deploy — rode scripts/CLI direto. Não gaste turno de LLM no que é determinístico.
