# dotfile

**dotfile** is a turnkey bootstrap kit for fresh Ubuntu systems. It merges traditional *dotfiles* with modular post-installation scripts so you can transform a vanilla machine into a fully-equipped development workstation in minutes—consistently and repeatably.

Powered by [**dotbot**](https://github.com/anishathalye/dotbot) for declarative, idempotent dotfile management.

---

## Key Features

* **One-command provisioning** – install packages, apply system tweaks, and symlink config files with `./install`.
* **Declarative configuration** – all dotfile links and setup steps defined in a single `install.conf.yaml`.
* **Idempotent by design** – safe to re-run; dotbot detects existing symlinks and skips them.
* **Modular scripts** – independent install modules under `scripts/`.
* **Ubuntu-focused** – tuned for the latest LTS release, but compatible with most Debian-based distros.
* **AI coding tools** – Claude Code, Codex, and Gemini CLI installed via Homebrew.
* **Starship Prompt** – modern cross-shell prompt with the [nerd-font-symbols](https://starship.rs/presets/nerd-font) preset.
* **cc-statusline** – beautiful status bar for Claude Code with context, cost, and session tracking.

---

## What Gets Installed

| Step | Description |
|------|-------------|
| sudoers NOPASSWD | Passwordless sudo for the current user |
| Homebrew | Package manager for Linux/macOS |
| Node.js, jq | Runtime and JSON processor |
| Claude Code, Codex, Gemini CLI | AI coding assistants |
| Starship | Cross-shell prompt with nerd-font-symbols preset |
| GNU Screen | Terminal multiplexer with custom config |
| Samba | Home directory sharing for Windows access |
| cc-statusline | Claude Code status bar setup |

---

## Directory Layout

```text
dotfile/
├── install                  # Entry point: dotbot bootstrap shim
├── install.conf.yaml        # Dotbot configuration (links + shell commands)
├── dotbot/                  # Dotbot engine (git submodule)
├── config/                  # Configuration files
│   ├── screenrc                 # GNU Screen configuration
│   └── netrate_fast.sh          # Network throughput monitor for Screen status bar
└── scripts/                 # Provisioning modules (called by dotbot shell directive)
    ├── install_starship.sh      # Starship binary + nerd-font-symbols preset
    ├── setup_screen.sh          # GNU Screen package installation
    └── setup_samba_share.sh     # Samba share setup
```

---

## Installation

### Quick Start

```bash
# 1. Clone the repository (with submodules)
git clone --recurse-submodules https://github.com/hulryung/dotfile.git
cd dotfile

# 2. Run the installer
./install
```

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

#### Samba Share

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
