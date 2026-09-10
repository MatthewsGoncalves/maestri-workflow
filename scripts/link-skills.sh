#!/usr/bin/env bash
# Symlinks skills/installed/<id>/SKILL.md a partir de skills/catalog.yaml.
# Wrapper fino sobre skillctl — falha (exit 1) se algum vendor path sumir.
set -euo pipefail
exec "$(cd "$(dirname "$0")" && pwd)/skillctl" link
