# Antigravity Security Hooks Installer
# Ported from claude-code-security-hooks

$ErrorActionPreference = "Stop"

$HooksDir = Join-Path $HOME ".antigravity\hooks"
$RepoHooksDir = Join-Path $PSScriptRoot "hooks"
$CanaryFile = Join-Path $PSScriptRoot "..\canary\canary.txt"

Write-Host "--- Antigravity Security Hooks Installer ---" -ForegroundColor Cyan

# 1. Create hooks directory
if (-not (Test-Path $HooksDir)) {
    Write-Host "[+] Creating hooks directory: $HooksDir"
    New-Item -ItemType Directory -Path $HooksDir -Force | Out-Null
}

# 2. Copy hook scripts
Write-Host "[+] Copying security hooks..."
Copy-Item (Join-Path $RepoHooksDir "security-guard.ps1") $HooksDir -Force
Copy-Item (Join-Path $RepoHooksDir "read-guard.ps1") $HooksDir -Force

# 3. Place Canary files
$SensitiveDirs = @(
    (Join-Path $HOME ".ssh"),
    (Join-Path $HOME ".aws"),
    (Join-Path $HOME ".config\gcloud")
)

foreach ($dir in $SensitiveDirs) {
    if (Test-Path $dir) {
        Write-Host "[+] Placing canary in $dir..."
        Copy-Item $CanaryFile (Join-Path $dir "SECURITY_ALERT.txt") -Force
    }
}

# 4. Success message and instructions
Write-Host "`n[SUCCESS] Antigravity Security Hooks installed to $HooksDir" -ForegroundColor Green
Write-Host "`nTo enable these hooks, add the following to your Antigravity configuration (e.g. user_settings.pb or similar):"
Write-Host "1. PRE_TOOL_USE hook for 'run_command' -> powershell.exe -File '$($HooksDir)\security-guard.ps1'"
Write-Host "2. PRE_TOOL_USE hook for 'view_file' -> powershell.exe -File '$($HooksDir)\read-guard.ps1'"

Write-Host "`nReview your permissions and always check commands before allowing execution." -ForegroundColor Yellow
