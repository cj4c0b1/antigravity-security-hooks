#!/bin/bash
# Gemini Security Hooks — Installer
set -e

HOOKS_DIR="$HOME/.gemini/hooks"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "╔══════════════════════════════════════════════╗"
echo "║  Gemini Security Hooks — Installer           ║"
echo "╚══════════════════════════════════════════════╝"
echo ""

mkdir -p "$HOOKS_DIR"
cp "$SCRIPT_DIR/hooks/security-guard.sh" "$HOOKS_DIR/"
cp "$SCRIPT_DIR/hooks/read-guard.sh" "$HOOKS_DIR/"
cp "$SCRIPT_DIR/hooks/bash-read-guard.sh" "$HOOKS_DIR/"
chmod +x "$HOOKS_DIR"/*.sh

echo "  ✓ Hooks installed to $HOOKS_DIR/"
echo ""

echo "→ Step 3: Add hooks to your ~/.gemini/settings.json"
echo ""
echo "  Copy the hooks configuration into your settings.json."
echo ""
