# Antigravity Security Guard — blocks credential exfiltration attempts
# Ported from claude-code-security-hooks
# Exit codes: 0 = allow, 2 = block

param(
    [string]$JsonInput
)

# If no param is provided, check if anything was piped in
if (-not $JsonInput -and $MyInvocation.ExpectingInput) {
    $JsonInput = $input | Out-String
}

# If still no input, check $args (for raw string testing)
if (-not $JsonInput -and $args.Count -gt 0) {
    $JsonInput = $args -join " "
}

try {
    $InputObj = $JsonInput | ConvertFrom-Json
    $CMD = $InputObj.tool_input.command
} catch {
    # If not JSON, assume raw command string for testing
    $CMD = $JsonInput
}

if ([string]::IsNullOrWhiteSpace($CMD)) {
    exit 0
}

# --- SENSITIVE PATHS ---
$CRED_PATTERNS = '(\.config[\\/]gcloud|\.ssh[\\/]id_|\.ssh[\\/]known_hosts|\.aws[\\/]credentials|\.aws[\\/]config|\.antigravity[\\/]settings|\.env|\.netrc|application_default_credentials|service\.account\.json|credentials\.json|secret.*\.json|\.kube[\\/]config|\.azure[\\/]|\.oci[\\/]|\.docker[\\/]config\.json|\.config[\\/]gh[\\/]|\.git-credentials|\.vault-token|\.pulumi[\\/]|\.terraform\.d[\\/]|\.config[\\/]doctl[\\/])'

# --- EXFIL TOOLS ---
$EXFIL_TOOLS = '\b(curl|wget|nc|ncat|netcat|scp|rsync|ftp|sftp|telnet|Invoke-WebRequest|Invoke-RestMethod|iwr|irm)\b'

# --- ENCODING TOOLS ---
$ENCODE_TOOLS = '\b(base64|xxd|od|openssl|gzip|tar|certutil|Format-Hex)\b'

# Rule 1: Block reading credential files AND piping/sending them
if ($CMD -match $CRED_PATTERNS -and $CMD -match $EXFIL_TOOLS) {
    Write-Host "BLOCKED: Command combines credential file access with network tool. Potential exfiltration attempt."
    exit 2
}

# Rule 2: Block encoding of credential paths
if ($CMD -match $CRED_PATTERNS -and $CMD -match $ENCODE_TOOLS) {
    Write-Host "BLOCKED: Command encodes credential files. Potential obfuscated exfiltration."
    exit 2
}

# Rule 3: Block web requests posting to non-whitelisted domains
if ($CMD -match '\b(curl|wget|Invoke-WebRequest|Invoke-RestMethod|iwr|irm)\b' -and ($CMD -match '(-Method\s+Post|-X\s+POST|--data|--upload|-d\s|--body)')) {
    if ($CMD -notmatch '(api\.anthropic\.com|github\.com|registry\.npmjs\.org|localhost|127\.0\.0\.1|100\.(6[4-9]|[7-9][0-9]|1[0-2][0-7])\.)') {
        Write-Host "BLOCKED: POST/upload to non-whitelisted domain. Add to whitelist in security-guard.ps1 if legitimate."
        exit 2
    }
}

# Rule 4: Block piping sensitive file contents to network commands
if ($CMD -match '\b(Get-Content|type|cat)\b.*(\.ssh|\.config[\\/]gcloud|\.aws|\.env|credentials|secret).*\|') {
    Write-Host "BLOCKED: Piping sensitive file contents. Potential exfiltration."
    exit 2
}

# Rule 5: Block python/node/powershell one-liners that use network libs with credential paths
if (($CMD -match '\b(python|node|pwsh|powershell)\b') -and ($CMD -match '\b(urllib|requests|http|fetch|socket|net\.|WebClient|HttpClient)\b') -and ($CMD -match $CRED_PATTERNS)) {
    Write-Host "BLOCKED: Script combining network library with credential access."
    exit 2
}

# Rule 6: Block direct reads of GCP ADC (most dangerous single file)
if ($CMD -match '\b(Get-Content|type|cat)\b.*application_default_credentials\.json') {
    Write-Host "BLOCKED: Direct read of GCP Application Default Credentials."
    exit 2
}

# Rule 7: Block attempts to modify this hook or settings
if ($CMD -match '\b(Set-Content|Add-Content|Out-File|sed|awk|perl|tee)\b.*\.(antigravity[\\/](settings|hooks))') {
    Write-Host "BLOCKED: Attempt to modify security hooks or settings."
    exit 2
}

exit 0
