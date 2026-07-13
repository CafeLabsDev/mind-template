#!/usr/bin/env bash
# Varre os repositórios git conhecidos na raiz de projetos e mostra, pra cada
# um, se tem mudança não commitada e/ou commit não empurrado — pra não
# precisar entrar em cada pasta e checar `git status` na mão. Sob demanda, não
# é um daemon: rodar quando quiser saber "o que falta commitar/dar push".
set -uo pipefail

PROJECTS_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Preencha com os nomes das pastas (dentro de PROJECTS_ROOT) que você quer
# monitorar — geralmente o próprio vault do Mind e os repos de projeto ativos.
REPOS=(
  # mind
  # meu-projeto
)

for name in "${REPOS[@]}"; do
  dir="$PROJECTS_ROOT/$name"
  [ -d "$dir/.git" ] || continue

  dirty=""
  if [ -n "$(git -C "$dir" status --porcelain 2>/dev/null)" ]; then
    dirty="mudanças não commitadas"
  fi

  ahead=""
  branch="$(git -C "$dir" symbolic-ref --short HEAD 2>/dev/null)"
  if [ -n "$branch" ] && git -C "$dir" rev-parse --abbrev-ref "@{upstream}" >/dev/null 2>&1; then
    count="$(git -C "$dir" rev-list --count '@{upstream}..HEAD' 2>/dev/null)"
    [ "${count:-0}" -gt 0 ] && ahead="$count commit(s) não empurrado(s)"
  elif [ -n "$branch" ]; then
    ahead="sem upstream configurado"
  fi

  if [ -n "$dirty" ] || [ -n "$ahead" ]; then
    printf '%-24s %s\n' "$name" "$(printf '%s | %s' "${dirty:--}" "${ahead:--}")"
  fi
done
