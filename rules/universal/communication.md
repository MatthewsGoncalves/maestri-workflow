# Regras universais — Comunicação

Baseado em attention-span — output humano, não dump de tokens.

## Com o usuário (via Orchestrator)

- Lead com conclusão, não com processo.
- Bullets curtos; código só quando necessário.
- Blockers explícitos no topo.

## Entre agentes (`maestri ask`)

- Uma intenção por mensagem quando possível.
- Inclua: contexto mínimo, caminhos, branch, o que espera como resposta.
- Não cole histórico inteiro — aponte para nota ou arquivo.

## Reporte de conclusão (template)

```
Status: done | blocked | needs-review
Stack: Backend | Frontend | Mobile
Branch: feat/...
Paths: ...
Próximo: review | land | aguardando X
```
