# Segurança — {{PROJECT_NAME}}

> Kernel nunca publica externamente. Workers compilados recebem versão curta em
> `security.worker.md`; este arquivo é a referência completa para o Orchestrator.

## Secrets e credenciais

| Onde | Permitido |
|------|-----------|
| Vault / platform secrets / `.env` local | Sim (ver `paths.md`) |
| Notas canvas (`spec`, `handoff`, …) | **Nunca** |
| `memory/*.md` (após sync) | **Nunca** — redação obrigatória |
| `memory/.local.md` | Rascunho local only — **gitignored** |
| Commits git | **Nunca** — `.env`, keys, tokens |

## Proibido escrever em notas ou handoff

- API keys (`sk-`, `ghp_`, `AKIA…`, etc.)
- JWT / Bearer tokens
- Senhas, connection strings com credencial
- PII não necessária ao escopo (CPF, cartão, …)
- URLs com token em query string

Se um worker precisar referenciar um secret: use **nome da variável** (`process.env.STRIPE_SECRET`) ou path do vault — nunca o valor.

## Workers

1. Suspeita de secret no pedido → reporte Orchestrator **blocked**, não copie para `handoff`
2. `handoff` descreve paths e status — não payloads sensíveis
3. Reviewer: diff com auth/input/externo → skill `ref-security-checklist` + linha Segurança em `quality-bar`

## Sync para git (`memory/`)

Antes de `./scripts/sync-memory.sh --push`:

- [ ] Nenhum valor literal de secret nas notas duráveis
- [ ] Script `memory-redact.sh` rodou (automático no sync)
- [ ] Review humano se a feature tocou auth/pagamento/dados pessoais

## Publicação externa

Segue `communications.md`. Agentes **preparam texto**; humano ou integração configurada publica.
