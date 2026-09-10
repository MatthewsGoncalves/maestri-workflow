# Escopo fechado v1.0 — Maestri Workflow

Documento de consenso (Orchestrator + arquiteto). O que o template **garante** e o que **não** promete.

## Veredito

**Ship v1.0** após Onda 3 mínima aplicada + smoke test manual em Maestro Mode.

---

## IN SCOPE v1.0

1. **5 roles** compiladas de regras versionadas, recompiláveis (`bootstrap-roles.sh`)
2. **Lifecycle:** só Orchestrator persiste; worker **chamado → age → reporta → `/clear` → dismiss**
3. **Três camadas:** kernel + overlay (`rules/project/`) + código do produto
4. **Andar = stack** com clone git isolado e branch própria
5. **55 skills** em `catalog.yaml` como fonte única (fase, roles, triggers, cost)
6. **`skillctl`:** for / ask / find / why / link / render / doctor (stdlib only)
7. **Dispatch gerado** — nunca editado à mão: `rules/_generated/`, `docs/SKILLS.md`, nota **Skills - Router**
8. **`attention-kind`** always_on no Orchestrator com o usuário
9. **8 notas** de canvas com dono e lifecycle (ver abaixo)
10. **Preview por stack sem IA:** Shell (0 tokens) + Portal via `rules/project/preview.md`
11. **Reviewer único**, sequencial, nunca edita
12. **Agent-agnostic:** preset trocável sem perder canvas / notas / regras
13. **White-label** por overlay: git, communications, paths, preview, codename do Maestro
14. **Zero subagentes internos** — só `maestri ask`
15. **Disciplina de custo:** 1–3 skills/ask, aviso em cost:heavy, `skillctl doctor` no bootstrap

---

## OUT OF SCOPE v1.0

- Ritual GitLab / GitHub específico (overlay; só exemplos)
- Role **Project Sync** (citada em regras, não criada no bootstrap)
- Agentes 24/7 ou standby
- Publicar em Slack / Teams / Discord (kernel nunca publica)
- Executar deploy ou CI
- Convenções de código do app alvo (`CLAUDE.md` do produto)
- Pin de versão dos vendors (depth-1 de main)
- Multi-repo não-monorepo (mencionado, não exercitado)
- Windows / PowerShell (`init-project` era macOS-only — corrigido na Onda 3)
- Emulador nativo como portal (janela do SO)
- Resolução de conflito entre stacks
- Substituir review humano
- Métrica / relatório de token
- Curadoria e licenciamento das 55 skills de terceiros

---

## Casos de uso v1.0

**Regra:** **VER** nunca liga agente IA; **MUDAR** liga o mínimo.

| Caso | Pedido | Orchestrator | Agentes | Skills | Teardown |
|------|--------|--------------|---------|--------|----------|
| **A** | Ver task X no front | `spawn-preview Frontend` | **Nenhum** | — | `teardown-preview Frontend --shells` |
| **B** | Print “página X assim” | spec + design-tokens; spawn stack + preview; delega Vitrine | Vitrine | design → implement + impeccable | review → land → dismiss → teardown |
| **C** | Feature cross-stack | plan → design → stacks + previews → batch → review → land | Sob demanda | por fase (`skillctl`) | dismiss all; `maestri list` zerado |
| **D** | Bug blocker | debug no worker existente; portal se browser | Quem travou | debug / browser tags | — |
| **E** | Só Swagger | `spawn-preview Backend` | Nenhum (ver) | — | teardown Backend |

Detalhe A/B: `docs/ORCHESTRATOR-MANUAL.md`

---

## Terminais por andar

| Tipo | Tokens IA | Quando | Como |
|------|-----------|--------|------|
| **Agent** | Alto se idle | Por task | `spawn-stack` / `spawn-reviewer` |
| **Shell** | Zero | Por feature | `spawn-preview` |
| **Portal** | Só no snapshot | Por feature | `spawn-preview` |
| **Emulador** | Zero (RAM/CPU alto) | Enquanto testa mobile | 2º shell no Mobile |

**Agent** é o único caro parado — caso **A** não liga ninguém.

---

## Notas canvas v1.0 (8)

| Nota | Dono | Lifecycle |
|------|------|-----------|
| `spec` | Orchestrator | RESET por feature |
| `api-contract` | Orchestrator | Durável + changelog |
| `design-tokens` | Orchestrator | Durável |
| `quality-bar` | Orchestrator | Durável 1×/projeto |
| `decisions` | Orchestrator | Append-only (ADRs) |
| `handoff` | Qualquer worker | Rolling — sobrevive `/clear` |
| `Aprendizados` | Reviewer | Curado |
| `Skills - Router` | Gerado | `sync-skills-note.sh` |

---

## Onda 3 mínima (bloqueia v1.0)

1. `{{ORCHESTRATOR_CODENAME}}` — white-label do loop report → Maestro
2. Casos A/B no manual
3. `init-project.sh` portável (Linux + macOS)
4. Este arquivo (`docs/SCOPE.md`)

## Onda 4 = v1.1 (nice-to-have)

- Dedupe `rules/universal` (~13% prompt)
- `roles/` → `ops/` + `rules/roles/`
- CI com `skillctl doctor`

---

## Riscos remanescentes

1. **ALTA** — Idempotência (`spawn-stack` / `spawn-preview`) depende de grep na saída do CLI; validar contra `maestri floor list` real
2. **MÉDIA** — Drift de vendor (main sem pin)
3. **MÉDIA** — Pouco exercitado fora de macOS
4. **BAIXA** — Qualidade das skills = repos terceiros
5. **BAIXA** — Disciplina consultiva (`skillctl` avisa, não bloqueia)

---

## Smoke test antes de importar

Em Maestro Mode, feature fictícia:

```bash
./scripts/spawn-stack.sh Frontend "UI Builder" feat/smoke Vitrine
./scripts/spawn-preview.sh Frontend
./scripts/teardown-preview.sh Frontend --shells
maestri dismiss Vitrine
```

Fecha risco #1 manualmente (~10 min).
