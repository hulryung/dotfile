#!/usr/bin/env bash
# setup_screen.sh
#
# Purpose : Install GNU Screen package.
# Config linking (~/.screenrc) is handled by dotbot (install.conf.yaml).

set -euo pipefail

# ---------------------------------------------------------------------------
# Install screen package if needed
# ---------------------------------------------------------------------------
if command -v screen >/dev/null 2>&1; then
    echo "[=] GNU Screen is already installed ($(screen --version | head -n1))"
else
    echo "[+] Installing GNU Screen..."
    if ! command -v sudo >/dev/null 2>&1; then
        echo "[!] sudo is not available. Please install sudo or run as root."
        exit 1
    fi
    sudo apt-get update -qq
    DEBIAN_FRONTEND=noninteractive sudo apt-get install -y screen >/dev/null
    echo "[+] GNU Screen installed successfully ($(screen --version | head -n1))"
fi

echo
echo "[✓] Screen setup complete!"
echo "  • Configuration is managed by dotbot (~/.screenrc)"
echo "  • Start a new session: screen"
echo "  • Reattach: screen -r"
echo "  • List sessions: screen -ls"
