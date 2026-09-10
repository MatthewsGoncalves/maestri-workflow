# Git / VCS — Workflow

> Preencha para este repo. Kernel ai-workflow não assume host nem branch model.

## Host

- [ ] GitHub
- [ ] GitLab
- [ ] Bitbucket
- [ ] Outro: ___

Remote: `origin` → ___

## Branches

| Tipo | Padrão | Exemplo |
|------|--------|---------|
| Produção | | `main` |
| Feature | | `feat/{slug}` |
| Fix | | `fix/{slug}` |

## Merge / review

- Abrir PR/MR: quem (Orchestrator | stack | agente Sync)
- Target branch: ___
- Reviewer humano obrigatório: ___ (ou n/a)
- Checks antes de merge: ___

## Tags / releases

- Quando taggear: ___
- Padrão de tag: ___ (ex. `v1.2.3`)

## CLI / automação

```bash
# GitHub
gh pr create ...

# GitLab
glab mr create ...
```

## O que agentes NÃO fazem

- [ ] Push direto em `main`
- [ ] Merge sem review humano (se aplicável)
- [ ] Chamar API do host (salvo role **Project Sync**, se existir)
