# Comunicação — exemplo canvas-only (copie para communications.md)

> Zero integração externa — tudo no Maestri + usuário.

## Canais

| Evento | Canal | Quem posta |
|--------|-------|------------|
| Feature pronta | Nota `spec` + fala com usuário | Orchestrator |
| PR aberto | Comentário manual na issue/PR | Usuário (agente só prepara texto) |
| Release | `maestri notify` | Orchestrator |
| Blocker | `maestri ask` + notify | Qualquer stack |

## Issue tracker

- [x] GitHub Issues (link: `https://github.com/org/repo/issues`)
- Agentes **preparam** título/corpo; usuário ou Project Sync cria/atualiza.

## Regras

1. Nenhum agente posta em Slack/Teams/Discord salvo `communications.md` dizer o contrário.
2. Texto pronto para copy-paste → nota `integration-checklist` ou resposta ao Orquestrator.
