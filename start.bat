@echo off
chcp 65001 >nul
setlocal EnableExtensions
cd /d "%~dp0"

echo ============================================
echo   Prism@.TEC Core  —  Windows portable
echo ============================================
echo.

if not exist "data\logs" mkdir "data\logs"
if not exist "data\node" mkdir "data\node"
if not exist "data\apps" mkdir "data\apps"

set PRISMA_ROOT=%cd%
set PRISMA_DATA=%cd%\data
set ABACOPHY_DATA=%cd%\data\tenants\abacophy
set ABACOPHY_STATIC=%cd%\vendor\abacophy\static\app
if not exist "%ABACOPHY_DATA%" mkdir "%ABACOPHY_DATA%"

echo [1/4] Mini-nodo PrismaTec Core  :8080
if exist "bin\prismatec-core.exe" (
  start "PrismaNode" /MIN "bin\prismatec-core.exe" node start --addr 127.0.0.1:8080 --data "%PRISMA_DATA%\node"
) else if exist "bin\prismatec.exe" (
  start "PrismaNode" /MIN "bin\prismatec.exe" node start --addr 127.0.0.1:8080 --data "%PRISMA_DATA%\node"
) else (
  echo   AVISO: falta bin\prismatec-core.exe — ejecute scripts\build-windows.ps1
)

echo [2/4] Alset Studio  :5177
if exist "bin\alset-studio.exe" (
  start "AlsetStudio" /MIN "bin\alset-studio.exe" -addr 127.0.0.1:5177 -dir "%PRISMA_ROOT%\web\studio-src"
) else (
  echo   AVISO: falta bin\alset-studio.exe
)

echo [3/4] AbacoPhy  :8090
if exist "bin\abacophy.exe" (
  set PORT=8090
  set ABACOPHY_DATA=%ABACOPHY_DATA%
  if exist "%ABACOPHY_STATIC%" set ABACOPHY_STATIC=%ABACOPHY_STATIC%
  start "AbacoPhy" /MIN "bin\abacophy.exe"
) else (
  echo   AVISO: falta bin\abacophy.exe
)

echo [4/4] Desktop shell
timeout /t 2 /nobreak >nul
start "" "web\desktop\index.html"

echo.
echo Listo. Desktop, Studio, AbacoPhy y nodo en 127.0.0.1
echo Datos: %PRISMA_DATA%
echo.
pause
