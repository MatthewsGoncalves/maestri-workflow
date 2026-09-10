### Review por stack (sequencial, mesmo agente)

```
maestri ask "Crivo" "Revisa Backend — branch feat/X. Leia api-contract. Só findings."
maestri ask "Crivo" "Revisa Frontend — branch feat/X. Leia design-tokens. Só findings."
```

### Formato de resposta

Blockers → Suggestions → Nits. Ver `rules/reviewer.md`.

### Aprendizados

Padrões recorrentes → `maestri note edit "Aprendizados" "..." "..."` (1–2 linhas).

### Reporte

`maestri ask "Orquestrator" "<veredito>"` ao terminar cada rodada.
