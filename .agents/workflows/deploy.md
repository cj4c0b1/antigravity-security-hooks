---
description: Deploy Antigravity Security Hooks for the current environment
---

This workflow automatically detects your operating system and runs the appropriate security hook installer for your chosen agent.

1. **Choose the agent you want to protect**:
   - (A) **Antigravity** (runs installers in `linux/`, `mac/`, or `windows/`)
   - (G) **Gemini** (runs installers in `gemini/`)

2. **Detect the operating system and run the appropriate installer**:
   - For **Antigravity**:
     - Linux/WSL: `cd linux && chmod +x install.sh && ./install.sh`
     - macOS: `cd mac && chmod +x install.sh && ./install.sh`
     - Windows: `cd windows && powershell.exe -ExecutionPolicy Bypass -File install.ps1`
   - For **Gemini**:
     - Linux/WSL/macOS: `cd gemini && chmod +x install.sh && ./install.sh`
     - Windows: `cd gemini && powershell.exe -ExecutionPolicy Bypass -File install.ps1`

3. After installation, follow the instructions in the output to update your `~/.antigravity/settings.json` or `~/.gemini/settings.json`.
