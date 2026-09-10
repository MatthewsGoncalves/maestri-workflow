# Manual do Orquestrador

Para quem opera o terminal **Maestro** — coordena features, delega stacks, controla tokens.

**North star:** **rápido** (paralelo, sob demanda) · **otimizado** (tokens, skills focadas) · **certeiro** (spec, contrato, ask explícito). Ver `rules/universal/principles.md`.

## Seu papel

Você **não implementa código**. Você:

1. Entende o pedido do usuário
2. Mantém notas de contrato (`spec`, `api-contract`, …)
3. Sobe stacks **só quando necessário**
4. Delega com mensagens claras + skills citadas
5. Coordena review e land
6. Dispensa agentes ociosos

## Antes de qualquer feature

```bash
maestri list                    # time e notas
maestri note read "spec"
maestri note read "handoff"
```

**Comunicação com o usuário:** `attention-kind` está **sempre ativo**. Leia uma vez por sessão:

`skills/installed/attention-kind/SKILL.md`

## Fluxo de uma feature

### 1. Plan

| Situação | Skill | Ação |
|----------|-------|------|
| Pedido vago | `idea-refine` ou `interview-me` | Clarificar com usuário |
| Escrever escopo | `spec-driven-development` | Preencher nota `spec` |
| Quebrar trabalho | `planning-and-task-breakdown` | Tasks na spec |
| Contrato API | `api-and-interface-design` | Nota `api-contract` |
| UI tokens | design-md de referência | Nota `design-tokens` |

### 2. Spawn stacks (sob demanda)

Só as stacks envolvidas na spec:

```bash
./scripts/spawn-stack.sh Backend  "API Specialist" feat/minha-feature Forja
./scripts/spawn-stack.sh Frontend "UI Builder"     feat/minha-feature Vitrine
./scripts/spawn-stack.sh Mobile   "Mobile Dev"     feat/minha-feature Sinal
```

Preset opcional (5º arg): `Claude Code`, `Cursor`, etc.

### 3. Delegar

**Regra:** cite 1–3 skills por agente no `maestri ask`. Path fixo:

`skills/installed/<id>/SKILL.md`

Exemplo paralelo:

```bash
maestri ask --batch '{
  "Forja": "Task: auth API. Leia: skills/installed/ponytail/SKILL.md. Notas: spec, api-contract. Entrega: needs-review",
  "Vitrine": "Task: login UI. Leia: skills/installed/ponytail/SKILL.md + frontend-ui-engineering. Notas: spec, design-tokens."
}'
```

### 4. Review (reviewer sob demanda)

```bash
./scripts/spawn-reviewer.sh Crivo
maestri ask "Crivo" "Review Backend branch feat/x. Skills: code-review-and-quality, ponytail-review."
# depois Frontend, mesmo Crivo, sequencial
```

Reviewer **nunca edita** — só findings.

### 5. Land

Do **ground**, ordem típica:

```bash
maestri floor land "Backend" --into main
maestri floor land "Frontend" --into main
maestri floor land "Mobile" --into main
```

Consulte `rules/project/git.md` do projeto antes de merge.

### 6. Encerrar (chamado → age → limpa)

Por **cada** worker (stack ou reviewer):

```bash
# Worker reporta done → roda /clear → você dismiss:
maestri dismiss "Forja"
maestri dismiss "Vitrine"
maestri dismiss "Crivo"
```

- Feche o gate na nota `handoff`
- `maestri list` — confirme **zero** recruits ociosos
- Status final ao user: `rundown` (+ attention-kind)

Próxima feature = **novo recruit**, não reutilizar terminal parado.

## Economia de token (obrigatório)

**Workers não ficam 24/7.** Ciclo: **chamado → age → reporta → `/clear` → dismiss.**

1. **Recruit** só quando for delegar (`spawn-stack.sh` / `spawn-reviewer.sh`)
2. **Dismiss** assim que a stack/reviewer terminou a parte dela (ou após land)
3. **`maestri list`** no fim da feature — zero recruits ociosos
4. **Não** polling de MR/review via agente — use `gh`/`git` ou espere o usuário
5. **Não** reenvie mensagem parada em outro terminal sem confirmar

Detalhe: `rules/universal/agent-lifecycle.md`

Só **você** (Orchestrator) permanece entre features.

## Comunicação com o usuário

| Momento | Formato |
|---------|---------|
| Sempre | attention-kind |
| Status rápido | + `spartan` |
| Fim de feature | + `rundown` |
| Resumir doc/issue | + `tldr` |

## Comunicação com stacks

Template de reporte que workers devem usar:

```
Status: done | blocked | needs-review
Stack: Backend | Frontend | Mobile
Branch: feat/...
Paths: ...
Próximo: review | land | aguardando X
```

## Notas do canvas

| Nota | Você mantém |
|------|-------------|
| `spec` | Escopo e critérios |
| `api-contract` | Contrato entre stacks |
| `design-tokens` | UI compartilhada |
| `handoff` | Estado rolling da feature + gate pré-land |
| `quality-bar` | Padrão de qualidade do projeto |
| `decisions` | Log de ADRs |
| `Aprendizados` | Gotchas curados |
| `Skills - Router` | Router de skills (gerado) |

Templates em `notes/templates/`.

## Trocar agente sem mudar processo

```bash
maestri recruit "Forja" --replace "Forja" --preset "Cursor"
```

Roles e regras permanecem.

## Checklist diário

- [ ] `maestri list` — quem está ligado sem necessidade?
- [ ] Notas atualizadas antes de delegar?
- [ ] Skills citadas nos asks?
- [ ] Reviewer dispensado após reviews?
- [ ] Stacks dispensadas após land?

## Referências

- Router de skills: `./scripts/skillctl` · dispatch gerado: `rules/_generated/`
- Catálogo completo: `skills/catalog.yaml`
- Arquitetura: `docs/ARCHITECTURE.md`
