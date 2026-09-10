# Skills — white-label

```
skills/
├── catalog.yaml      # índice + gatilhos + orchestrator_says
├── installed/        # symlinks → vendor (gerado)
├── vendor/           # clones (gitignore)
└── manifest.yaml     # repos fonte
```

## Setup

```bash
./scripts/install-skills.sh   # clone vendor
./scripts/link-skills.sh      # skills/installed/<id>/SKILL.md
```

## Uso

Orchestrator inclui na delegação:

```
Leia: skills/installed/ponytail/SKILL.md
```

Dispatch completo: **`rules/skills-dispatch.md`**

## Fontes (vendor)

| Pacote | Repo |
|--------|------|
| engineering | addyosmani/agent-skills |
| simplicity | dietrichgebert/ponytail |
| communication | alexgreensh/attention-span |
| design-spec | VoltAgent/awesome-design-md |
| ui-motion | emilkowalski/skills |
| polish | pbakaus/impeccable |
| diagrams | Graphify-Labs/graphify |
