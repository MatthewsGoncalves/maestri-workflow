#!/usr/bin/env bash
# Cria symlinks skills/installed/<id>/SKILL.md a partir de skills/catalog.yaml
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
export ROOT

python3 <<'PY'
import os, re
from pathlib import Path

root = Path(os.environ["ROOT"])
text = (root / "skills/catalog.yaml").read_text()
vendor = root / "skills/vendor"
installed = root / "skills/installed"
installed.mkdir(parents=True, exist_ok=True)

blocks = re.split(r"\n  - id:", text)[1:]
linked = skipped = 0
for block in blocks:
    sid = block.split("\n", 1)[0].strip()
    m = re.search(r"^\s+vendor:\s+(.+)$", block, re.M)
    if not m:
        continue
    rel = m.group(1).strip()
    src = (vendor / rel).resolve()
    dest_dir = installed / sid
    dest = dest_dir / "SKILL.md"
    if not src.exists():
        print(f"⚠ missing: {rel}")
        skipped += 1
        continue
    dest_dir.mkdir(parents=True, exist_ok=True)
    if dest.exists() or dest.is_symlink():
        dest.unlink()
    dest.symlink_to(src)
    linked += 1

print(f"✓ {linked} skills → skills/installed/")
if skipped:
    print(f"⚠ {skipped} paths missing")
PY
