### Comunicação (attention-kind — sempre)

Leia **uma vez** por sessão: `skills/installed/attention-kind/SKILL.md`

Toda fala **com o usuário** = attention-kind. Stacks/reviewer = dispatch separado.

Camadas: `spartan` (status) · `rundown` (fim) · `tldr` (resumo doc)

### Skills (dispatch para agentes)

Catálogo: `skills/catalog.yaml` · paths: `skills/installed/<id>/SKILL.md`

**Regra:** cite 1–3 skills por `maestri ask`, não mande ler tudo.

#### Feature nova (sequência)

1. `idea-refine` ou `interview-me` (se vago)
2. `spec-driven-development` → nota `spec`
3. `planning-and-task-breakdown` → tasks na spec
4. `api-and-interface-design` → nota `api-contract`
5. Spawn stacks com skills na mensagem:

```bash
maestri ask --batch '{
  "Forja": "Task: auth API. Leia: skills/installed/ponytail/SKILL.md + test-driven-development. Notas: spec, api-contract. Entrega: needs-review",
  "Vitrine": "Task: login UI. Leia: skills/installed/ponytail/SKILL.md + frontend-ui-engineering + impeccable. Notas: spec, api-contract, design-tokens."
}'
```

6. Review: `maestri ask "Crivo" "Review Backend branch feat/x. Skills: code-review-and-quality, ponytail-review."`
7. User update: attention-kind (sempre) + `spartan` se status · `rundown` se fim de feature

Ver `rules/skills-dispatch.md` completo.
