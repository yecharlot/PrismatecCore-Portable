#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"
mkdir -p data/{logs,node,apps,tenants/abacophy,mind}

export PRISMA_ROOT="$ROOT"
export PRISMA_DATA="$ROOT/data"
export ABACOPHY_DATA="$ROOT/data/tenants/abacophy"
export ABACOPHY_STATIC="$ROOT/vendor/abacophy/static/app"
export PORT=8090

echo "=== Prism@.TEC Core (portable) ==="

if [[ -x bin/prismatec-core ]]; then
  bin/prismatec-core node start --addr 127.0.0.1:8080 --data "$PRISMA_DATA/node" >>data/logs/node.log 2>&1 &
  echo "nodo :8080 pid $!"
elif [[ -x bin/prismatec ]]; then
  bin/prismatec node start --addr 127.0.0.1:8080 --data "$PRISMA_DATA/node" >>data/logs/node.log 2>&1 &
  echo "nodo :8080 pid $!"
else
  echo "AVISO: falta bin/prismatec-core"
fi

if [[ -x bin/alset-studio ]]; then
  bin/alset-studio -addr 127.0.0.1:5177 -dir "$ROOT/web/studio-src" >>data/logs/studio.log 2>&1 &
  echo "studio :5177 pid $!"
fi

if [[ -x bin/abacophy ]]; then
  PORT=8090 ABACOPHY_DATA="$ABACOPHY_DATA" ABACOPHY_STATIC="$ABACOPHY_STATIC" \
    bin/abacophy >>data/logs/abacophy.log 2>&1 &
  echo "abacophy :8090 pid $!"
fi

sleep 1
echo "Desktop: file://$ROOT/web/desktop/index.html"
echo "AbacoPhy: http://127.0.0.1:8090/"
echo "Studio:   http://127.0.0.1:5177/"
echo "Nodo:     http://127.0.0.1:8080/studio/"
