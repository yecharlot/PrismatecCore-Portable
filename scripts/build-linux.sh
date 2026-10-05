#!/usr/bin/env bash
# Build Linux amd64 binaries into bin/ (also used inside TinyCore USB)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$ROOT/bin" "$ROOT/vendor/abacophy" "$ROOT/web/studio-src"
export CGO_ENABLED=0 GOOS=linux GOARCH=amd64

build() {
  local mod="$1" pkg="$2" out="$3"
  if [[ -d "$mod" ]]; then
    echo "build $pkg -> $out"
    (cd "$mod" && go build -o "$ROOT/bin/$out" "$pkg")
  else
    echo "skip missing $mod"
  fi
}

CORE="${CORE_SRC:-$ROOT/../PrismaTec-Core}"
ABA="${ABA_SRC:-$ROOT/../AbacoPhy}"
STU="${STU_SRC:-$ROOT/../Alset-LISPAI-Runtime}"

build "$CORE" "./cmd/prismatec" "prismatec-core"
build "$ABA"  "./cmd/abacophy"  "abacophy"
build "$STU"  "./cmd/alset-studio" "alset-studio"

if [[ -d "$ABA/static" ]]; then
  rm -rf "$ROOT/vendor/abacophy/static"
  cp -a "$ABA/static" "$ROOT/vendor/abacophy/static"
fi
if [[ -d "$STU/web" ]]; then
  rm -rf "$ROOT/web/studio-src"
  cp -a "$STU/web" "$ROOT/web/studio-src"
fi
echo "OK -> $ROOT/bin"
