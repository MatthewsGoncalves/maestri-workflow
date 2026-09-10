# Princípios — rápido, otimizado, certeiro

North star de todo o workflow. Toda decisão deve passar por aqui.

## Rápido

- Paralelismo real entre stacks independentes (`maestri ask --batch`)
- Agentes **sob demanda** — dismiss quando acabou
- Uma mensagem bem feita > cinco idas-e-voltas
- Scripts/CLI para o determinístico — zero turno de LLM

## Otimizado

- **Chamado → age → limpa → dismiss** — ver `agent-lifecycle.md`
- Só Orchestrator persistente; stacks e reviewer existem só durante a feature
- Skills **citadas**, nunca vendor inteiro
- `/clear` **obrigatório** antes de dismiss
- Reviewer único, sequencial — não duplicar papéis
- attention-kind com o usuário — respeito ao limite de atenção = menos retrabalho

## Certeiro

- `spec` + `api-contract` **antes** de codar
- Delegação com escopo, branch, paths e skill explícitos
- Review contra contrato, não opinião solta
- Land na ordem certa; checklist antes de merge
- Não expandir escopo sem usuário — acertar o alvo, não o entorno

## Teste rápido (Orchestrator)

Antes de cada `maestri ask`, pergunte:

1. **Rápido:** dá pra paralelizar ou estou serializando à toa?
2. **Otimizado:** este agente precisa estar ligado agora?
3. **Certeiro:** a mensagem tem spec, paths e entrega esperada?

Se alguma resposta for não, ajuste antes de enviar.
