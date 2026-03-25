# Antigravity Read Guard — blocks reading sensitive files
# Ported from claude-code-security-hooks
# Exit codes: 0 = allow, 2 = block

param(
    [Parameter(Mandatory=$true)]
    [string]$Path
)

# --- SENSITIVE PATHS ---
$BLOCKED_PATTERNS = '(\.ssh[\\/].*|\.config[\\/]gcloud[\\/].*|\.aws[\\/]credentials|\.aws[\\/]config|\.claude[\\/]settings|\.env|\.netrc|application_default_credentials|service\.account\.json|credentials\.json|secret.*\.json|\.kube[\\/]config|\.npmrc|\.yarnrc|\.gnupg[\\/]private-keys.*|\.tfstate|\.antigravity[\\/](settings|hooks))'

if ($Path -match $BLOCKED_PATTERNS) {
    Write-Host "BLOCKED: Reading sensitive file: $Path" -ForegroundColor Red
    exit 2
}

exit 0
