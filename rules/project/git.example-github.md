# Git / VCS — exemplo GitHub (copie trechos para rules/project/git.md)

> Referência white-label. Não é kernel — adapte por projeto.

## Host

- [x] GitHub
- Remote: `origin` → `git@github.com:org/repo.git`

## Branches

| Tipo | Padrão | Exemplo |
|------|--------|---------|
| Produção | `main` | `main` |
| Feature | `feat/{slug}` | `feat/checkout` |
| Fix | `fix/{slug}` | `fix/login-403` |

## Merge / review

- Abrir PR: stack implementadora commita → Orchestrator ou **Project Sync** abre PR
- Target: `main` (ou `develop` se preenchido abaixo)
- Reviewer humano: CODEOWNERS / @user
- Checks: CI verde antes de merge

```bash
gh pr create --base main --head feat/checkout --title "feat: checkout" --body "..."
gh pr view --web
gh pr merge --squash   # só após aprovação humana
```

## Tags / releases

- Tag após merge em `main`: `v{semver}`
- Release notes: corpo do PR ou `gh release create`

## O que agentes NÃO fazem

- [x] Push direto em `main`
- [x] Merge PR sem review humano
- [x] `gh api` / GitHub API — salvo role **Project Sync**
