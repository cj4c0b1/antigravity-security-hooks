---
description: Deploy Antigravity Security Hooks for the current environment
---

This workflow automatically detects your operating system and runs the appropriate security hook installer for Antigravity.

1. Detect the operating system
// turbo
2. Run the platform-specific installer:
   - On **Linux/WSL**: `cd linux && chmod +x install.sh && ./install.sh`
   - On **macOS**: `cd mac && chmod +x install.sh && ./install.sh`
   - On **Windows**: `cd windows && powershell.exe -ExecutionPolicy Bypass -File install.ps1`

3. After installation, follow the instructions in the output to update your `~/.antigravity/settings.json`.
