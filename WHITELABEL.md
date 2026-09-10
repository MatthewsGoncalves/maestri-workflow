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

Edite `rules/project/git.md`, `communications.md`, `paths.md`.

## O que você personaliza (só overlay)

| Arquivo | White-label |
|---------|-------------|
| `rules/project/git.md` | GitHub / GitLab / … |
| `rules/project/communications.md` | Slack / Teams / canvas |
| `rules/project/paths.md` | Onde fica api/web/mobile |

**Não edite** `rules/universal/` nem `rules/stacks/` por projeto — são o kernel compartilhado.

## O que vem pronto (kernel)

- 5 roles globais Maestri
- Scripts bootstrap / spawn-stack / spawn-reviewer
- Skills vendor (install script)
- Notas template
- Manual: `docs/ORCHESTRATOR-MANUAL.md`

## Checklist pós-import

- [ ] `./scripts/init-project.sh "Nome"`
- [ ] Preencher `rules/project/*`
- [ ] `./scripts/bootstrap-roles.sh`
- [ ] Assign role **Orchestrator** no terminal Maestro (UI)
- [ ] Conectar notas ao Orquestrator
- [ ] `./scripts/install-skills.sh`
