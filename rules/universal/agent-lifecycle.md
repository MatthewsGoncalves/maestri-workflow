# Ciclo de vida dos agentes — chamado, age, limpa

**Regra central:** workers **não rodam 24/7**. Só existem enquanto há trabalho. Ao terminar, **limpam sessão** e saem.

## Quem fica entre features

| Agente | Entre features |
|--------|----------------|
| **Orchestrator** (Maestro) | Permanece — único terminal persistente |
| Stacks (Backend, Frontend, Mobile) | **Não** — recruit → task → dismiss |
| Reviewer | **Não** — recruit → review → dismiss |

Terminal ocioso ligado = histórico caro no próximo turno.

## Ciclo de um worker (stack ou reviewer)

```
1. CHAMADO   Orchestrator: spawn-stack / spawn-reviewer + maestri ask
2. AGE       Executa só o escopo da mensagem
3. REPORTA   maestri ask "{{ORCHESTRATOR_CODENAME}}" "Status: done | needs-review | blocked ..."
4. LIMPA     /clear (ou equivalente no agente) — histórico zerado
5. DISPENSA  Orchestrator: maestri dismiss "Nome" — terminal sai do canvas
```

**Ordem obrigatória ao concluir:** reportar → `/clear` → dismiss (Orchestrator faz o dismiss).

Worker **não** fica esperando próxima task. Próxima feature = **novo recruit** se precisar.

## Orchestrator

- **Chama** workers — nunca deixa stack/reviewer ligado "por precaução"
- **Dispensa** assim que a parte deles na feature terminou (ou após land)
- Entre features: `maestri list` — se sobrou recruit ocioso, dismiss
- Pode `/clear` próprio histórico entre features grandes (opcional); role permanece

## Proibido

- Manter 3+ stacks ligados sem task ativa
- Reacionar worker "só pra confirmar"
- Worker iniciar nova task sem novo `maestri ask` do Orchestrator
- Pular `/clear` antes de dismiss

## Exceção

Usuário pede explicitamente manter um agente ligado para sequência imediata de tasks **na mesma feature** — mesmo assim `/clear` entre tasks grandes.
