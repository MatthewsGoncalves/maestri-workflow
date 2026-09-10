# Instalação

Guia completo para instalar o **Maestri Workflow** como template white-label.

## Requisitos

| Item | Obrigatório |
|------|-------------|
| [Maestri](https://maestri.app) | Sim |
| Terminal com **Maestro Mode** | Sim (toggle no canvas) |
| `git` | Sim |
| `python3` | Sim (script link-skills) |
| Conta GitHub/GitLab do projeto | Para overlay (opcional no template puro) |

## Caminho A — Novo workspace Maestri (recomendado)

1. Clone ou importe este repo para o diretório do projeto:

```bash
git clone https://github.com/MatthewsGoncalves/maestri-workflow.git ~/Work/meu-app
cd ~/Work/meu-app
```

2. Se já usa Maestri com workspace template nomeado `Workflow`:

```bash
maestri workspace create "Meu App" --dir ~/Work/meu-app --from "Workflow"
```

3. Bootstrap:

```bash
chmod +x scripts/*.sh
./scripts/init-project.sh "Meu App" "Orquestrator"
./scripts/install-skills.sh
./scripts/init-notes.sh
./scripts/sync-skills-note.sh
./scripts/bootstrap-roles.sh
./scripts/sync-memory.sh --pull    # opcional: seed canvas from memory/
```

4. No canvas Maestri:
   - Assign role **Orchestrator** ao terminal Maestro (UI)
   - Notas criadas por `init-notes.sh` (fichários Workflow + Memory)

## Caminho B — Só git (sem `--from`)

Mesmo que Caminho A, passo 1 + bootstrap. Configure o workspace Maestri manualmente apontando `--dir` para o clone.

## Personalizar overlay do projeto

Edite (não commite secrets):

```
rules/project/git.md              # GitHub, GitLab, branches, PR
rules/project/communications.md   # Slack, Teams, ou só canvas
rules/project/paths.md            # apps/api, apps/web, apps/mobile
rules/project/security.md         # secrets, redação
rules/project/memory.md           # matriz de leitura, sync git
memory/                           # espelho das duráveis (ver docs/MEMORY.md)
```

Exemplos prontos:

- `rules/project/git.example-github.md`
- `rules/project/communications.example-canvas.md`

Depois:

```bash
./scripts/bootstrap-roles.sh
```

## Verificar instalação

```bash
maestri role list          # 5 roles globais
ls skills/installed/       # symlinks das skills
maestri note read "Skills - Router"
./scripts/skillctl doctor  # 55 entradas, 0 erros
```

## Atualizar template

```bash
git pull
./scripts/install-skills.sh
./scripts/bootstrap-roles.sh
```

Overlay em `rules/project/` permanece seu.

## Troubleshooting

| Problema | Solução |
|----------|---------|
| `This terminal is not the Maestro` | Ative Maestro Mode no terminal |
| Roles não aparecem | Rode `./scripts/bootstrap-roles.sh` em Maestro Mode |
| Skills missing | `./scripts/install-skills.sh` |
| Agentes gastando token | Dismiss stacks ociosos; só Orchestrator 24/7 |
