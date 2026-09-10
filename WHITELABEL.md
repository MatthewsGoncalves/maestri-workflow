# White-label — Maestri Workflow

Template instalável: [github.com/MatthewsGoncalves/maestri-workflow](https://github.com/MatthewsGoncalves/maestri-workflow)

Este workspace é um **template white-label**: copie/importe inteiro para qualquer projeto. Nada aqui assume GitLab, stack ou agente específico.

## Importar em projeto novo

### 1. Git clone

```bash
git clone https://github.com/MatthewsGoncalves/maestri-workflow.git ~/Work/meu-app
cd ~/Work/meu-app
./scripts/init-project.sh "Meu App" "Maestro"    # codename = nome do SEU terminal Maestro
./scripts/install-skills.sh
./scripts/bootstrap-roles.sh
```

### 2. Maestri (canvas)

```bash
maestri workspace create "Meu App" \
  --dir ~/Work/meu-app \
  --from "Workflow"
```

Copia layout do canvas + retargeta paths. Depois rode bootstrap no dir do app.

### 3. Personalizar overlay

Edite `rules/project/git.md`, `communications.md`, `paths.md`, `preview.md`.

## O que você personaliza (só overlay)

| Arquivo | White-label |
|---------|-------------|
| `rules/project/git.md` | GitHub / GitLab / … |
| `rules/project/communications.md` | Slack / Teams / canvas |
| `rules/project/paths.md` | Onde fica api/web/mobile |
| `rules/project/preview.md` | Comandos dev, portas, URL do Swagger |
| `rules/project/security.md` | Secrets, redação, boundaries |
| `rules/project/memory.md` | Matriz de leitura, sync git |
| `rules/project/orchestrator.codename` | Nome do terminal Maestro (gerado, gitignored) |
| `memory/*.md` | Espelho git das notas duráveis |

**Não edite** `rules/universal/` nem `rules/stacks/` por projeto — são o kernel compartilhado.
Nenhum script escreve neles: `{{ORCHESTRATOR_CODENAME}}` fica no kernel e é resolvido
por `bootstrap-roles.sh` na hora de compilar a role, a partir do overlay. Assim
`git pull` do template nunca conflita.

## O que vem pronto (kernel)

- 5 roles globais Maestri
- Scripts bootstrap / spawn-stack / spawn-reviewer
- Skills vendor (install script)
- Notas template
- Manual: `docs/ORCHESTRATOR-MANUAL.md`

## Checklist pós-import

- [ ] `./scripts/init-project.sh "Nome" "<codename do seu Maestro>"`
- [ ] Preencher `rules/project/*` (git, communications, paths, preview, security, memory)
- [ ] `./scripts/install-skills.sh`
- [ ] `./scripts/init-notes.sh && ./scripts/sync-skills-note.sh`
- [ ] `./scripts/bootstrap-roles.sh`
- [ ] Assign role **Orchestrator** ao terminal Maestro (UI)
- [ ] `./scripts/sync-memory.sh --pull` (se importar memory/ de outro clone)
- [ ] Smoke test — ver `docs/SCOPE.md`
