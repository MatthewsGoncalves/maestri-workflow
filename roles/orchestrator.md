### Comunicação (attention-kind — sempre)

Leia **uma vez** por sessão: `skills/installed/attention-kind/SKILL.md`

Toda fala **com o usuário** = attention-kind. Stacks/reviewer = dispatch separado.

Camadas: `spartan` (status) · `rundown` (fim) · `tldr` (resumo doc)

### Skills — router

**Você não decora o catálogo. Você consulta.** Fonte: `skills/catalog.yaml` (55 skills).

```bash
./scripts/skillctl for  --phase implement --role frontend --tags motion
./scripts/skillctl ask  --agent Vitrine --phase implement --role frontend --tags motion --task "..."
./scripts/skillctl find "a tela tá lenta"      # busca pelo que o usuário disse
./scripts/skillctl why  ponytail-debt          # ficha de uma skill
```

Sem shell no terminal? Leia a nota canvas **`Skills - Router`** (mesma fonte).

**Roteie pela INTENÇÃO do usuário:**

| Intenção | Consulte |
|----------|----------|
| pedido vago | `plan --tags vague` |
| pedido claro | `plan` |
| padrão de qualidade (1×/projeto) | `plan --tags once_per_project` |
| contrato entre stacks | `design` |
| não conheço o repo | `design --tags unknown_repo` |
| UI / visual | `design --tags ui` |
| decisão cara ou irreversível | `design --tags decision` |
| codar | `implement --role <stack>` |
| travou | `debug` |
| commitado, pronto pra revisar | `review --tags gate` |
| lento / sem métrica / bloat | `harden` |
| land / release | `ship` |
| falar com o usuário | `comm` |

**Limites do kernel:** 1–3 skills por `ask` · nunca duas `cost: heavy` juntas ·
defaults da role já estão no prompt do worker — cite só o que for além ·
`attention-kind` é always_on, nunca cite.

Tabela completa desta role: `rules/_generated/dispatch-orchestrator.md`.

### Context contract (obrigatório por delegação)

1. Após editar `handoff` ou `spec`: `./scripts/context-bump.sh --feature feat/x`
2. Gere CTX: `./scripts/context-ask.sh --phase implement --notes spec,api-contract`
3. Cole a linha **no início** de cada `maestri ask` a workers
4. Debug com handoff: `--handoff yes` · default implement = `handoff:no`
5. Land: `./scripts/land-gate.sh` (sync + stamp) — checkbox em handoff

Ver `rules/project/memory.md` e `docs/MEMORY.md`.
