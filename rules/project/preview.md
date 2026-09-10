# Preview — Workflow

> Infra de preview por stack: **Shell** (processo, 0 tokens IA) + **Portal** (browser no canvas, quando aplicável).
> Preencha ao importar o template. Orchestrator: `./scripts/spawn-preview.sh <stack>`.

## Frontend

| Campo | Valor |
|-------|-------|
| Andar | `Frontend` |
| Shell name | `Dev Server` |
| Comando dev | `npm run dev` |
| URL base | `http://localhost:3000` |
| Portal name | `Front Preview` |
| Portal path | `/` |
| Viewport mobile (opcional) | `390x844` |

## Backend

| Campo | Valor |
|-------|-------|
| Andar | `Backend` |
| Shell name | `API Server` |
| Comando dev | `npm run start:dev` |
| URL base | `http://localhost:3001` |
| Portal name | `API Docs` |
| Portal URL | `http://localhost:3001/swagger` |
| Alternativas docs | `/api-docs`, `/scalar`, `/redoc`, `/health` |

## Mobile

| Campo | Valor |
|-------|-------|
| Andar | `Mobile` |
| Shell name | `Metro` |
| Comando dev | `npx expo start` |
| Shell emulator (opcional) | `Simulador` |
| Comando emulator | `npx expo run:ios` ou `run:android` |
| Portal (opcional, Expo web) | `http://localhost:8081` → portal `Expo Web` |

## Lifecycle

| Evento | Ação |
|--------|------|
| Início da feature | `spawn-stack` → `spawn-preview` |
| Agente IA valida UI/API | `maestri portal snapshot` (worker conectado ao portal) |
| Fim / land | `./scripts/teardown-preview.sh` + dismiss workers |

Shells de preview **podem** ficar ligados durante a feature; agentes IA **não**.
