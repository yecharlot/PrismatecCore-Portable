# Arquitectura PrismatecCore-Portable

```
Windows / TinyCore
       │
       ▼
 start.bat | start.sh
       │
       ├─ prismatec-core   :8080   nodo + /studio + /w/*.app.ans
       ├─ alset-studio     :5177   Alset Studio (LISPAI)
       ├─ abacophy         :8090   contabilidad (API + PWA)
       └─ web/desktop              lanzador local
```

- **ANS:** `apps/abacophy.app.ans/manifest.json` declara proxy al puerto 8090.
- **Datos:** todo bajo `data/` (node, tenants, mind, logs).
- **Vendor:** copias de static Studio/AbacoPhy generadas por `scripts/build-*`.
