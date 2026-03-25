# Antigravity Security Hooks

**Multi-platform defense against prompt injection for AI coding agents.**

This project provides 7 layers of defense to prevent AI agents (like Claude Code or Antigravity) from exfiltrating your secrets (SSH keys, cloud credentials, etc.) when they encounter malicious instructions.

This is a standalone port and expansion of the original [claude-code-security-hooks](https://github.com/slavaspitsyn/claude-code-security-hooks) project, optimized for Antigravity and multi-environment support.

## Supported Environments

Each environment has specialized hooks and installers:

*   **[Windows](./windows/)**: PowerShell-based hooks for native Windows environments.
*   **[Linux / WSL](./linux/)**: Bash-based hooks for Linux distributions and Windows Subsystem for Linux.
*   **[macOS](./mac/)**: Bash-based hooks optimized for macOS.

## Quick Start

1.  Clone this repository.
2.  Navigate to the directory for your operating system.
3.  Run the appropriate installer:

### Windows
```powershell
cd windows
.\install.ps1
```

### Linux / WSL / macOS
```bash
cd linux  # or mac
chmod +x install.sh
./install.sh
```

## How it Works

The hooks intercept tool calls (`run_command`, `view_file`) and block actions that combine sensitive file access with network operations or encoding. It also includes "Canary" files that trigger a security alert if the AI reads them.

---

### Credits
Based on the original architecture by [slavaspitsyn](https://github.com/slavaspitsyn/claude-code-security-hooks).
Modified and expanded for Antigravity systems.
