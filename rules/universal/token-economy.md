# Regras universais — Economia de token

Observações de operação real — não teórico.

1. **Não reenvie** mensagem parada no terminal de outro agente sem confirmar com o usuário. Cada reenvio paga turno inteiro.
2. **Não faça polling via agente** de coisas que dependem de humano (MR review). Use `git`/`gh`/`glab` direto ou espere sinal real.
3. **Agrupe instruções** numa mensagem — evite "verifica" → "ok faz X" → "verifica de novo".
4. **Compacte sessão** quando sua etapa fechar (`/clear` ou equivalente).
5. **Saia do loop ativo** quando terminar — não reacionar "só pra confirmar".
6. **Intervenha rápido** se agente travar >10min sem resposta.
7. **Perguntas estreitas** — "qual o status code deste endpoint?" > "investiga o bug".
8. **Stacks sob demanda** — recruit só durante a feature; dismiss quando ocioso.
9. **Reviewer único** — um agente revisa todas as stacks em sequência; não duplicar reviewer.
10. **Antes do clear** — 1–2 linhas do que foi caro (opcional, útil para calibrar próximas features).

Orchestrator permanece entre features; workers limpam sessão ao encerrar.
