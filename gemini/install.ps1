# Gemini Security Hooks — Installer
$ErrorActionPreference = "Stop"

$HooksDir = "$HOME\.gemini\hooks"
$RepoHooksDir = Join-Path $PSScriptRoot "hooks"

if (!(Test-Path $HooksDir)) { New-Item -ItemType Directory -Path $HooksDir | Out-Null }

Copy-Item "$RepoHooksDir\security-guard.ps1" -Destination $HooksDir
Copy-Item "$RepoHooksDir\read-guard.ps1" -Destination $HooksDir

Write-Host "`n[SUCCESS] Gemini Security Hooks installed to $HooksDir" -ForegroundColor Green
Write-Host "`nTo enable these hooks, add the configuration to your ~/.gemini/settings.json"
