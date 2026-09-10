# Preview por stack — Shell + Portal

Infraestrutura **sem agente IA** para ver front, Swagger e mobile durante uma feature.

## Modelo (consenso Orchestrator + arquiteto)

| Stack | Shell (preset `Shell`) | Portal Maestri |
|-------|------------------------|----------------|
| **Frontend** | `Dev Server` → `npm run dev` | `Front Preview` → localhost |
| **Backend** | `API Server` → API rodando | `API Docs` → Swagger/OpenAPI |
| **Mobile** | `Metro` → `expo start` | Opcional: `Expo Web`; emulador em 2º shell |

- **Shell** = processo only, **0 tokens** de LLM
- **Portal** = browser no canvas; agente usa `maestri portal snapshot` ao validar
- **Emulador iOS/Android** = segundo shell `Simulador` (pesado — só durante feature)

## Setup

1. Preencha `rules/project/preview.md` (comandos, portas, URL Swagger)
2. Suba andar + preview:

```bash
./scripts/spawn-stack.sh Frontend "UI Builder" feat/x Vitrine
./scripts/spawn-preview.sh Frontend

./scripts/spawn-stack.sh Backend "API Specialist" feat/x Forja
./scripts/spawn-preview.sh Backend
```

3. Conecte portal ao worker (opcional):

```bash
maestri connect "Front Preview" "Vitrine"
maestri connect "API Docs" "Forja"
```

4. Worker valida:

```bash
maestri portal snapshot "Front Preview"
```

## Quem roda o quê

| Ação | Quem |
|------|------|
| `spawn-preview.sh` | Orchestrator (Maestro Mode) |
| Dev server / API / Metro | Terminal **Shell** no andar |
| Snapshot / click | UI Builder ou API Specialist (quando citado na task) |
| Você | Olha o portal no canvas |

## Lifecycle

```
feature start → spawn-stack + spawn-preview
              → workers IA sob demanda (validam via portal)
feature end   → teardown-preview.sh
              → maestri dismiss workers
              → maestri dismiss shells (Dev Server, etc.)
```

Não deixe emulador 24/7 — consome RAM/CPU; mesmo princípio dos agentes IA.

## Backend: qual URL no portal?

Preencha em `rules/project/preview.md`:

- NestJS: `/swagger` ou `/api`
- FastAPI: `/docs`
- Scalar/Redoc: path do projeto

## Mobile

- **Expo:** `Metro` shell + opcional `Simulador` com `expo run:ios`
- Portal web do Expo é fallback; emulador nativo não vira portal — é janela do SO

## Encerrar

```bash
./scripts/teardown-preview.sh all
maestri dismiss "Dev Server"
maestri dismiss "API Server"
```
