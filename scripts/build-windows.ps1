# Build PrismatecCore-Portable binaries for Windows (run on a machine with Go 1.22+)
# Expects sibling clones:
#   ../PrismaTec-Core  ../AbacoPhy  ../Alset-LISPAI-Runtime

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
Set-Location $Root
New-Item -ItemType Directory -Force -Path bin, vendor\abacophy, web\studio-src | Out-Null

function Build-Go($Path, $Out) {
  if (-not (Test-Path $Path)) { Write-Warning "Skip missing $Path"; return }
  Write-Host "Building $Path -> $Out"
  Push-Location $Path
  $env:GOOS = "windows"; $env:GOARCH = "amd64"; $env:CGO_ENABLED = "0"
  go build -o $Out .
  Pop-Location
}

$Core = Join-Path $Root "..\PrismaTec-Core"
$Aba  = Join-Path $Root "..\AbacoPhy"
$Stu  = Join-Path $Root "..\Alset-LISPAI-Runtime"

if (Test-Path (Join-Path $Core "cmd\prismatec")) {
  Push-Location $Core
  $env:GOOS="windows"; $env:GOARCH="amd64"; $env:CGO_ENABLED="0"
  go build -o (Join-Path $Root "bin\prismatec-core.exe") ./cmd/prismatec
  Pop-Location
}

if (Test-Path (Join-Path $Aba "cmd\abacophy")) {
  Push-Location $Aba
  $env:GOOS="windows"; $env:GOARCH="amd64"; $env:CGO_ENABLED="0"
  go build -o (Join-Path $Root "bin\abacophy.exe") ./cmd/abacophy
  Pop-Location
  # static PWA twin
  $staticSrc = Join-Path $Aba "static"
  if (Test-Path $staticSrc) {
    Copy-Item -Recurse -Force $staticSrc (Join-Path $Root "vendor\abacophy\static")
  }
}

if (Test-Path (Join-Path $Stu "cmd\alset-studio")) {
  Push-Location $Stu
  $env:GOOS="windows"; $env:GOARCH="amd64"; $env:CGO_ENABLED="0"
  go build -o (Join-Path $Root "bin\alset-studio.exe") ./cmd/alset-studio
  Pop-Location
  $webSrc = Join-Path $Stu "web"
  if (Test-Path $webSrc) {
    Copy-Item -Recurse -Force $webSrc (Join-Path $Root "web\studio-src")
  }
}

Write-Host "Done. Binaries in bin\. Run start.bat from USB root."
