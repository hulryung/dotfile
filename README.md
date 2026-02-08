# dotfile

**dotfile** is a turnkey bootstrap kit for fresh Ubuntu and macOS systems. It merges traditional *dotfiles* with modular post-installation scripts so you can transform a vanilla machine into a fully-equipped development workstation in minutes—consistently and repeatably.

Powered by [**dotbot**](https://github.com/anishathalye/dotbot) for declarative, idempotent dotfile management.

---

## Key Features

* **One-command provisioning** – install packages, apply system tweaks, and symlink config files with `./install`.
* **Cross-platform** – single repository for both Linux (Ubuntu) and macOS with OS-specific configs.
* **Declarative configuration** – all setup steps defined in YAML (`install.conf.yaml` + OS-specific files).
* **Idempotent by design** – safe to re-run; dotbot detects existing symlinks and skips them.
* **AI coding tools** – Claude Code, Codex, and Gemini CLI.
* **Starship Prompt** – modern cross-shell prompt with the [nerd-font-symbols](https://starship.rs/presets/nerd-font) preset.
* **cc-statusline** – beautiful status bar for Claude Code with context, cost, and session tracking.

---

## What Gets Installed

| Step | Common | Linux | macOS |
|------|--------|-------|-------|
| sudoers NOPASSWD | Y | | |
| Homebrew | Y | | |
| Node.js, jq | Y | | |
| Gemini CLI | Y | | |
| Starship (nerd-font-symbols) | Y | | |
| cc-statusline | Y | | |
| Claude Code | | native installer | brew --cask |
| Codex | | npm | brew --cask |
| GNU Screen + screenrc | | Y | |
| Samba share | | Y | |

---

## Directory Layout

```text
dotfile/
├── install                  # Entry point: OS detection + dotbot runner
├── install.conf.yaml        # Common configuration (both platforms)
├── install.linux.yaml       # Linux-specific (screen, samba, claude-code, codex)
├── install.macos.yaml       # macOS-specific (claude-code, codex via cask)
├── dotbot/                  # Dotbot engine (git submodule)
├── config/                  # Configuration files
│   ├── screenrc                 # GNU Screen configuration (Linux)
│   └── netrate_fast.sh          # Network throughput monitor for Screen status bar
└── scripts/                 # Provisioning modules
    ├── install_starship.sh      # Starship binary + nerd-font-symbols preset
    ├── setup_screen.sh          # GNU Screen package installation (Linux)
    └── setup_samba_share.sh     # Samba share setup (Linux)
```

---

## Installation

### Quick Start

```bash
# 1. Clone the repository (with submodules)
git clone --recurse-submodules https://github.com/hulryung/dotfile.git
cd dotfile

# 2. Run the installer (auto-detects OS)
./install
```

The `install` script automatically runs `install.conf.yaml` (common), then `install.linux.yaml` or `install.macos.yaml` based on the detected OS.

Log out/in (or reboot) once the script completes to load your new shell environment.

### Dotbot CLI Options

```bash
./install                  # Run everything
./install --only link      # Symlinks only
./install --only shell     # Shell commands only
./install --except shell   # Everything except shell commands
```

### Individual Component Installation

If you prefer to install specific components only:

#### Starship Prompt

Installs [Starship](https://starship.rs) with the **nerd-font-symbols** preset:

```bash
./scripts/install_starship.sh
```

> Requires a [Nerd Font](https://www.nerdfonts.com/) (e.g. FiraCode Nerd Font) installed in your terminal.

#### Samba Share (Linux only)

Shares the current user's home directory over Samba with read/write access:

```bash
sudo -E ./scripts/setup_samba_share.sh
```

After the script finishes, access the share from Windows:
`\\<Ubuntu_IP>\<username>` — log in with the same username and the Samba password you set.

> **Firewall tip** – If UFW is enabled, open the required ports:
> ```bash
> sudo ufw allow samba
> ```

---

## Contributing

Pull requests are welcome! Please open an issue first to discuss major changes or new modules.

---

## License

Released under the MIT License. See `LICENSE` for details.
