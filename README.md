<div align="center">
  <h1>🛡️ Antigravity Security Hooks</h1>
  <p><strong>Your AI agent is one malicious prompt away from leaking your entire infrastructure.</strong></p>
  <p><i>A unified, multi-platform, multi-agent defense system against prompt injection.</i></p>
</div>

---

## ⚠️ The Problem

We love the speed of autonomous AI coding assistants (like **Google Antigravity** and **Gemini**). But that autonomy comes with a massive blind spot: these agents have unrestricted `bash` and file system access by default. 

A single compromised webhook, a malicious dependency, or a tainted repository could easily trick an AI agent into running a command like `curl` to silently pipeline your AWS keys, GCP credentials, or Docker registry tokens straight to an external server. And because we are so accustomed to hitting "Allow" on every terminal prompt, **you probably wouldn't even notice.**

## 🦸 The Solution

`antigravity-security-hooks` provides a **comprehensive 7-layer defense system** to lock down the tools your AI actually uses. It hooks directly into the agent's `PreToolUse` lifecycle to actively monitor and block malicious intent before the command is even executed by your operating system.

### 🌩️ Massive Cloud & DevOps Lockdown
The hooks actively hunt for and block access to or exfiltration of:
*   **Cloud Providers**: AWS (`~/.aws/`), GCP (`~/.config/gcloud/`), Azure (`~/.azure/`), and Oracle (`~/.oci/`).
*   **DevOps Secrets**: Docker configs, GitHub CLI tokens, `.git-credentials`, HashiCorp Vault tokens (`~/.vault-token`), Pulumi, and `.tfstate` files.
*   **Local Keys**: Entire `~/.ssh/` and `~/.gnupg/` directories, plus all `.env` files.

---

## 🚀 Features

*   💻 **Multi-Platform Support**: Native hooks pre-written for **Linux**, **macOS**, and **Windows** (PowerShell).
*   🤖 **Multi-Agent Support**: Out-of-the-box configurations for both **Google Antigravity** and **Gemini**.
*   🔒 **Exfiltration Blocks**: Stops the AI from chaining sensitive file access with network tools (`curl`, `nc`, `wget`, `Invoke-WebRequest`).
*   🔍 **Encoding Detection**: Blocks obfuscation attempts like piping credentials into `base64`, `xxd`, or `tar`.
*   🔄 **Self-Preservation**: The AI is explicitly blocked from modifying its own security constraints via `sed`, `awk`, or `Set-Content`.
*   🌐 **POST Whitelisting**: Only allows data to flow to approved endpoints.
*   🐦 **Canary Traps**: Honey-token files that trigger immediate alerts if an agent tries to snoop where it shouldn't.

---

## ⚡ Deployment

### The Antigravity 1-Click Method (Recommended)
If you are using Antigravity, you can deploy the hooks automatically by running the custom workflow directly in chat:
```bash
/deploy
```
The workflow will automatically ask which agent you want to protect (Antigravity or Gemini), detect your host OS, and deploy the correct secure hooks. You'll be locked down in under 5 minutes.

### Manual Installation
If you prefer to install manually, choose your OS and your Agent folder:

#### Linux / WSL / macOS
```bash
cd linux       # or mac, or gemini
chmod +x install.sh
./install.sh
```

#### Windows (PowerShell)
```powershell
cd windows     # or gemini
.\install.ps1
```

---

## 🔬 CI/CD Verified
This codebase runs a strict multi-platform testing matrix via **GitHub Actions**. Every push validates that our `read-guard` and `security-guard` scripts successfully block over a dozen known exfiltration and unauthorized read vectors across Ubuntu, macOS, and Windows runners.

---

## 🙏 Credits

This project was built as a unified, modernized expansion of the foundational research by [Slava Spitsyn](https://github.com/slavaspitsyn/claude-code-security-hooks). Massive shoutout to Slava for shining a light on prompt injection vulnerabilities and creating the original 7-layer defense framework.
