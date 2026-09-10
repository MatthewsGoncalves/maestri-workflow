### Review por stack (sequencial, mesmo agente)

Peça CTX com `phase=review` e notas allowlist. Exemplo:

```
CTX: feature=feat/x phase=review handoff:no notes:quality-bar
Revisa Backend — branch feat/X. Só findings.
```

### Formato de resposta

Blockers → Suggestions → Nits. Ver `rules/reviewer.md`.

### Aprendizados

Padrões recorrentes → `maestri note edit "Aprendizados" "..." "..."` (1–2 linhas).

### Reporte

`maestri ask "{{ORCHESTRATOR_CODENAME}}" "<veredito>"` → **`/clear`** → aguarde dismiss.
