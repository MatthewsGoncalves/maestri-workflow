# Regras universais — Economia de token

**Modelo:** agentes **só agem quando chamados** (`maestri ask`). Ao terminar: report → `/clear` → dismiss. Ver `agent-lifecycle.md`.

Observações de operação real — não teórico.

1. **Não reenvie** mensagem parada no terminal de outro agente sem confirmar com o usuário. Cada reenvio paga turno inteiro.
2. **Não faça polling via agente** de coisas que dependem de humano (MR review). Use `gh`/`git` direto ou espere sinal real.
3. **Agrupe instruções** numa mensagem — evite "verifica" → "ok faz X" → "verifica de novo".
4. **Ao concluir:** reporte ao Orchestrator → `/clear` → Orchestrator faz `maestri dismiss`.
5. **Saia do loop ativo** quando terminar — não reacionar "só pra confirmar".
6. **Intervenha rápido** se agente travar >10min sem resposta.
7. **Perguntas estreitas** — escopo mínimo na pergunta.
8. **Zero workers 24/7** — terminal ocioso = dismiss, não "standby".
9. **Reviewer único** — sequencial; dismiss após rodada de reviews.
10. Orchestrator: `maestri list` no fim da feature — nenhum recruit ocioso deve restar.

Orchestrator permanece entre features; todo worker limpa e sai ao encerrar.
