#!/usr/bin/env bash
# Leitor compartilhado de rules/project/preview.md. Source, não execute.
# Requer $PREVIEW apontando para o arquivo.

# Lê "| <chave> | <valor> |" da seção "## <secao>" de rules/project/preview.md.
# Devolve o valor sem crases nem espaços de borda; cai no default se vazio.
read_field() {
  local section="$1" key="$2" default="${3:-}" val
  [[ -f "$PREVIEW" ]] || { printf '%s' "$default"; return; }
  val="$(awk -F'|' -v sec="$section" -v k="$key" '
    $0 ~ "^## " sec { insec = 1; next }
    /^## / { if (insec) exit }
    insec && NF >= 3 {
      key = $2; val = $3
      gsub(/^[ \t]+/, "", key); gsub(/[ \t]+$/, "", key)
      gsub(/^[ \t]+/, "", val); gsub(/[ \t]+$/, "", val)
      gsub(/`/, "", val)
      if (key == k) { print val; exit }
    }
  ' "$PREVIEW")"
  printf '%s' "${val:-$default}"
}
