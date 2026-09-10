# Skills — catálogo e dispatch

Paths estáveis para agentes: **`skills/installed/<id>/SKILL.md`**

Gerar links: `./scripts/link-skills.sh` (roda após `install-skills.sh`)

## Como o Orchestrator usa skills

**attention-kind:** sempre ativo nas respostas ao usuário (leia a skill uma vez por sessão). Não cite no `maestri ask`.

**Demais skills:** sob demanda — indique **1–3 skills por mensagem** no `maestri ask` para stacks/reviewer.

### Template de delegação

```
maestri ask "Forja" "Task: <o quê>
Leia antes: skills/installed/ponytail/SKILL.md
Escopo: nota spec + api-contract
Entrega: commit + Status needs-review"
```

### Fluxo por fase

| Fase | Quem | Skills típicas |
|------|------|----------------|
| **Plan** | Orchestrator | `idea-refine` → `spec-driven-development` → `planning-and-task-breakdown` |
| **Design** | Orchestrator | `api-and-interface-design`, `graphify` (opcional), `design-spec-vercel` (ref) |
| **Implement** | Stack | `ponytail` + skill da stack (ver catálogo) |
| **Review** | Reviewer | `code-review-and-quality` + `ponytail-review` |
| **Debug** | Stack bloqueada | `debugging-and-error-recovery` |
| **Ship** | Orchestrator | `git-workflow-and-versioning`, `shipping-and-launch` |
| **Comm** | Orchestrator | `spartan` (status), `rundown` (fim), `tldr` (resumo doc) |

## Por role (default)

### Orchestrator
| Quando | Skill |
|--------|-------|
| Pedido vago | `idea-refine`, `interview-me` |
| Escrever spec | `spec-driven-development` |
| Quebrar work | `planning-and-task-breakdown` |
| Mapear repo | `graphify` |
| Contrato API | `api-and-interface-design` |
| Falar com user | **`attention-kind` (sempre)** + `spartan` / `rundown` / `tldr` quando couber |
| Land / release | `git-workflow-and-versioning`, `shipping-and-launch` |

### API Specialist
| Quando | Skill |
|--------|-------|
| Sempre implementando | `ponytail` |
| Feature grande | `incremental-implementation` |
| Lógica crítica | `test-driven-development` |
| Auth/dados | `security-and-hardening` |
| Bug | `debugging-and-error-recovery` |

### UI Builder
| Quando | Skill |
|--------|-------|
| Sempre | `ponytail`, `frontend-ui-engineering` |
| UI nova / polish | `impeccable` |
| Motion web | `animate` |
| Motion Expo/RN | `animate-expo` |
| Referência visual | `design-spec-vercel` (ou outro brand em vendor) |

### Mobile Dev
| Quando | Skill |
|--------|-------|
| Sempre | `ponytail` |
| Lógica | `test-driven-development` |
| Motion | `animate-expo` |

### Reviewer
| Quando | Skill |
|--------|-------|
| Todo review | `code-review-and-quality` |
| Diff gordo | `ponytail-review` |
| Touchou animation | `review-animations` |
| Feedback user | `tldr`, `attention-kind` |

## Catálogo completo

Ver `skills/catalog.yaml` (machine) ou nota canvas `Skills - Catalog`.

## Anti-patterns

- ❌ "Leia todas as skills em vendor/"
- ❌ Skill de implementação no Orchestrator durante codificação
- ❌ Reviewer implementando (impeccable é só leitura de critérios, não editar)
- ✅ Orchestrator **nomeia** o path `skills/installed/<id>/SKILL.md` na mensagem
