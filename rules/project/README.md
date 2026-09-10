# Overlay do projeto

O **kernel** (`rules/universal/`, stacks, reviewer) não sabe se você usa GitHub, GitLab, Linear ou Slack.

Tudo específico de **um repo** fica aqui — copie os templates ao iniciar um projeto novo e preencha.

```
rules/project/
├── README.md           ← este arquivo
├── git.md              ← VCS: GitHub / GitLab / Bitbucket / local
├── communications.md   ← como falar com humanos (Slack, Teams, issue tracker…)
└── paths.md            ← monorepo: onde fica api / web / mobile
```

## Ao clonar o template para um app

```bash
maestri workspace create "Meu App" --dir ~/Work/meu-app --from "Workflow"
cd ~/Work/meu-app
# Edite rules/project/* para ESTE repo
./scripts/bootstrap-roles.sh   # recompila roles (kernel + project se referenciado)
```

## Opcional: agente de sync

Se o projeto precisar de um terminal que fala com GitHub/GitLab/issues:

- Recruit sob demanda com role **Project Sync** (crie em `rules/project/sync-agent.md`)
- **Ninguém** mais chama API do host — padrão opt-in por projeto

Kernel não define esse papel; o projeto define se precisa.
