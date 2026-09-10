# Skills — white-label

```
skills/
├── catalog.yaml      # FONTE ÚNICA: skills + fases + bundles + defaults + triggers
├── installed/        # symlinks → vendor (gerado por skillctl link)
├── vendor/           # clones (gitignore)
└── manifest.yaml     # repos fonte
```

Tudo que fala de skill é derivado de `catalog.yaml`:
`rules/_generated/`, `docs/SKILLS.md` e a nota canvas `Skills - Router`.
Editou o catálogo? Rode `./scripts/gen-dispatch.sh`.

## Setup

```bash
./scripts/install-skills.sh   # clone vendor + link
./scripts/link-skills.sh      # só relink
./scripts/skillctl doctor     # valida paths, bundles, defaults, órfãs
```

## Uso

Orchestrator inclui na delegação:

```
Leia: skills/installed/ponytail/SKILL.md
```

Consulta: **`./scripts/skillctl for --phase <fase> --role <role>`**
Dispatch por role (gerado): **`rules/_generated/dispatch-<role>.md`**

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
