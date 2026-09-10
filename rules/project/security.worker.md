# Segurança (workers) — {{PROJECT_NAME}}

> Versão curta para stacks e reviewer. Orchestrator vê `security.md` completo.

## Nunca em notas canvas ou handoff

- API keys, tokens, JWT, senhas, connection strings com credencial
- PII desnecessária
- Valores de `.env` — cite só **nome da variável**

## Se o usuário colar secret no chat

- **Não** replique em nota, handoff, `memory/`, nem em arquivos do repo
- Reporte Orchestrator; credencial local só em path permitido em `paths.md`

## Ao concluir

Handoff descreve **paths e status** — não payloads sensíveis.
