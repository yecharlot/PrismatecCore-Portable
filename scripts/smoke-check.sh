#!/usr/bin/env bash
# Smoke: ports and ANS manifest present
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ok=0
fail=0
check() { if "$@"; then echo "OK  $*"; ok=$((ok+1)); else echo "FAIL $*"; fail=$((fail+1)); fi; }
check test -f "$ROOT/config/core.json"
check test -f "$ROOT/apps/abacophy.app.ans/manifest.json"
check test -f "$ROOT/web/desktop/index.html"
check test -f "$ROOT/start.bat"
check test -f "$ROOT/docs/BOOT_MBR_UEFI.md"
echo "result ok=$ok fail=$fail"
exit "$fail"
