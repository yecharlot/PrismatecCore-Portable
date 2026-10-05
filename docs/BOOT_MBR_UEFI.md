# Boot USB — MBR y UEFI (Prism@.TEC Core)

El mismo stick puede usarse de dos formas:

## A) Windows portable (sin boot)

1. Copiar la carpeta `PrismatecCore-Portable` al USB.
2. En el PC Windows: ejecutar `start.bat`.
3. No requiere UEFI/BIOS ni formateo especial.

## B) Arranque nativo (AlsetDesktop / TinyCore)

Objetivo: PCs con **UEFI** y PCs antiguos con **BIOS/MBR**.

### Opción recomendada: Ventoy

1. Instalar [Ventoy](https://www.ventoy.net/) en el USB (soporta UEFI + Legacy BIOS).
2. Copiar al USB:
   - ISO TinyCore (o la imagen Alset que generéis).
   - Carpeta `PrismatecCore-Portable/` completa (datos + bin Linux).
3. Arrancar desde USB → elegir la ISO.
4. Montar la partición de datos Ventoy y ejecutar:

```sh
sudo mkdir -p /opt/prismatec
sudo cp -a /mnt/Ventoy/PrismatecCore-Portable /opt/prismatec/
/opt/prismatec/PrismatecCore-Portable/start.sh
```

### Imagen hybrid (avanzado)

- Generar ISO **híbrida** (xorriso/`isohybrid`) para arranque USB en MBR y UEFI.
- Incluir `boot/tinycore/` y el tarball `alset-desktop-*-linux-amd64.tgz` de AlsetOS.
- Persistencia: `tce=/mnt/<disco>/tce` como en `AlsetOS/docs/HARDWARE_BOOT.es.md`.

### Checklist hardware

| Firmware | Método |
|----------|--------|
| UEFI | Ventoy UEFI o ISO con `/EFI/BOOT/BOOTX64.EFI` |
| BIOS/MBR | Ventoy legacy o ISO hybrid con syslinux/isolinux |
| Secure Boot | Desactivar o firmar shim (no incluido en 0.1) |

### Persistencia de negocio

Siempre escribir tenants y apps bajo `data/` en la partición **persistente** del USB, no en tmpfs.
