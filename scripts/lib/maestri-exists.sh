#!/usr/bin/env bash
# Lookup helpers for maestri CLI output. Source, não execute.
# Parsers derivados da saída real de `maestri floor list` e `maestri list`
# (Maestri CLI, workspace "Workflow", 2026-09-09).

maestri_cli() {
  "${MAESTRI_CLI:-maestri}" "$@"
}

# `maestri floor list` (observado):
#   Floors in "Workflow":
#     Ground — ~/Workspace/ai-workflow  ·  branch 'main'  ·  active
#     "Frontend" — branch 'feat/x'  ·  ~/Workspace/.maestri/floors/...  ·  N nodes
# Ground sem aspas; stacks com aspas. Nome termina antes do em-dash (—).
maestri_floor_exists() {
  local name="$1"
  maestri_cli floor list 2>/dev/null | awk -v n="$name" '
    NR > 1 && $0 ~ /^[[:space:]]+/ {
      line = $0
      sub(/^[[:space:]]+/, "", line)
      sub(/[[:space:]]*—.*$/, "", line)
      gsub(/^"/, "", line)
      gsub(/"$/, "", line)
      if (line == n) { found = 1; exit }
    }
    END { exit !found }
  '
}

# `maestri list` — linhas de nó (observado, indent 2 espaços):
#   You:
#     - name: "Orquestrator", maestro: true
#   Connected agents:
#     - name: "Vitrine", role: "UI Builder", floor: "Frontend"
#     - name: "Dev Server", floor: "Frontend"
#   Connected portals (use `maestri portal check`):
#     - name: "Front Preview" - url: http://localhost:3000
# Notas ficam com 4 espaços — fora das seções rastreadas abaixo.
_maestri_list_section_exists() {
  local section="$1" name="$2"
  maestri_cli list 2>/dev/null | awk -v sec="$section" -v n="$name" '
    /^You:/ { cur = "you" }
    /^Connected agents/ { cur = "agents" }
    /^Connected portals/ { cur = "portals" }
    /^Connected notes/ { cur = "" }
    cur == sec && $0 ~ /^  - name: "/ {
      s = $0
      sub(/^  - name: "/, "", s)
      sub(/".*$/, "", s)
      if (s == n) { found = 1; exit }
    }
    END { exit !found }
  '
}

# Recruit, shell, ou qualquer agente no canvas.
maestri_agent_exists() {
  _maestri_list_section_exists "agents" "$1"
}

# Portal conectado (match exato — não casa "Front Preview" em "Front Preview Mobile").
maestri_portal_exists() {
  _maestri_list_section_exists "portals" "$1"
}

# API unificada: maestri_exists <nome> <floor|agents|portals>
maestri_exists() {
  local name="${1:?nome}"
  local where="${2:?floor|agents|portals}"
  case "$where" in
    floor)   maestri_floor_exists "$name" ;;
    agents)  maestri_agent_exists "$name" ;;
    portals) maestri_portal_exists "$name" ;;
    *)
      echo "maestri_exists: escopo inválido: $where (use floor|agents|portals)" >&2
      return 2
      ;;
  esac
}
