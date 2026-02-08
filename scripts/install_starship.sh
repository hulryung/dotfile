#!/bin/bash

# Starship Prompt Installation Script
# Installs starship binary and applies the nerd-font-symbols preset.
# Config linking is handled by dotbot (install.conf.yaml).

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_status()  { echo -e "${GREEN}[INFO]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error()   { echo -e "${RED}[ERROR]${NC} $1"; }

# ---------------------------------------------------------------------------
# 1. Install starship binary
# ---------------------------------------------------------------------------
print_status "Installing Starship Prompt..."

if command -v starship &> /dev/null; then
    print_warning "Starship is already installed ($(starship --version))"
    read -p "Do you want to reinstall? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_status "Skipping binary installation"
    else
        print_status "Reinstalling starship..."
        curl -sS https://starship.rs/install.sh | sh -s -- -y
    fi
else
    print_status "Installing starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# ---------------------------------------------------------------------------
# 2. Apply nerd-font-symbols preset
# ---------------------------------------------------------------------------
print_status "Applying nerd-font-symbols preset..."
mkdir -p "$HOME/.config"
starship preset nerd-font-symbols -o "$HOME/.config/starship.toml"
print_status "Preset written to ~/.config/starship.toml"

# ---------------------------------------------------------------------------
# 3. Add starship init to .bashrc (idempotent)
# ---------------------------------------------------------------------------
if grep -q "starship init bash" "$HOME/.bashrc" 2>/dev/null; then
    print_warning "Starship init already present in .bashrc"
else
    echo "" >> "$HOME/.bashrc"
    echo "# Starship Prompt" >> "$HOME/.bashrc"
    echo 'eval "$(starship init bash)"' >> "$HOME/.bashrc"
    print_status "Added starship init to .bashrc"
fi

print_status "Starship prompt installed with nerd-font-symbols preset!"
print_status "To activate, restart your terminal or run: source ~/.bashrc"
