# PrismatecCore-Portable

**Prism@.TEC Core** — paquete portable (USB) para desarrollar, probar y servir apps Alset en local.

| Modo | Uso |
|------|-----|
| **Windows portable** | Copiar al USB → `start.bat` → Desktop + Studio + ÁbacoPhy + mini-nodo |
| **Boot MBR + UEFI** | Ventoy + TinyCore / AlsetOS — ver [docs/BOOT_MBR_UEFI.md](docs/BOOT_MBR_UEFI.md) |

## Qué incluye (0.1)

- Layout USB versionado (`bin/`, `data/`, `apps/`, `web/`)
- App por defecto **ÁbacoPhy** (`abacophy.app.ans`)
- Lanzador **Desktop** (`web/desktop`)
- Scripts de **build** desde repos hermanos (PrismaTec-Core, AbacoPhy, Alset-LISPAI-Runtime)
- Documentación de arranque dual firmware

## Arranque rápido (Windows)

```text
1. Clonar este repo en el USB (o copiar la carpeta)
2. Tener Go 1.22+ en una PC de build
3. Clonar al lado: PrismaTec-Core, AbacoPhy, Alset-LISPAI-Runtime
4. powershell -File scripts\build-windows.ps1
5. start.bat
```

## Puertos

| Servicio | Puerto |
|----------|--------|
| Mini-nodo / ANS / Control Studio | 8080 |
| Alset Studio | 5177 |
| ÁbacoPhy | 8090 |
| Desktop shell | archivo local / opcional 7420 |

## Repos de origen

- https://github.com/yecharlot/PrismaTec-Core
- https://github.com/yecharlot/AbacoPhy
- https://github.com/yecharlot/Alset-LISPAI-Runtime
- https://github.com/yecharlot/AlsetOS (boot TinyCore)
- https://github.com/yecharlot/Alset-JS-Runtime (runtime UI)

## Versión

`0.1.0-portable` — scaffold de producto. Binarios se generan con los scripts de build; no se versionan en git (ver `.gitignore`).
