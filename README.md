# Ubuntu Provisioning

Documenting the installation and provisioning of a lean, reproducible Ubuntu client machine. 
This project emphasizes maintainability, repeatability, and eventual migration to GitOps automation practices.

The system avoids Snap unless explicitly chosen, follows best practices like using `/opt/` for personal apps, and captures setup logs for transparency. 
This repo is intended to grow into a fully automated and auditable workstation provisioning system.

---

## Repository Structure

```text
.
├── assets/                    # Icons and images used in AppImage desktop integration
├── autoinstall.yaml          # Ubuntu autoinstall configuration (Phase 1 automation)
├── configs/                  # Desktop entries, Argos configs, etc.
│   ├── argos/
│   └── trezor.desktop
├── docs/                     # Human-readable reference documentation
│   ├── trezor.md
│   ├── zerotier.md
│   ├── telegram.md
│   ├── ssh.md
│   ├── dotfiles.md
│   └── fwupdmgr.md
├── logs/provisioning-logs/   # Historical logs and captured terminal sessions
├── notes/                    # Scratchpad and planning notes (e.g., todo.md)
├── scripts/                  # Standalone provisioning scripts
│   ├── bootstrap.sh
│   ├── gnome-extensions_install.sh
│   ├── telegram-install.sh
│   ├── trezor-install.sh
│   └── zerotier-install.sh
└── README.md                 # This file
```

---

## Provisioning Phases

### ✅ Phase 0: Preflight Manual Install

- Download and flash Ubuntu ISO
- Manual partitioning and LVM
- Initial system configuration
- Logging:
  - `logs/provisioning-logs/phase0-history.txt`
  - `logs/provisioning-logs/phase0-install.log`
- Draft `autoinstall.yaml` from initial install

---

### ✅ Phase 1: Ubuntu Install + Core Packages

- Use the `autoinstall.yaml` file to configure:
  - Hostname, username, timezone, password (SHA-512), and disk layout
  - Base packages via `apt`

🧾 Config: [`autoinstall.yaml`](autoinstall.yaml)

#### Included Packages:
Installed via `apt`:

- `alacritty`, `curl`, `git`, `gimp`, `vlc`, `meld`, `tree`, `neofetch`, `python3`, `python3-pip`
- `nmap`, `golang-go`, `vim-gtk3`, `openjdk-21-jdk`

🔧 Reference configs:
- [`configs/alacritty.toml`](configs/alacritty.toml) *(TBD)*

---

### ✅ Phase 2: Applications Setup

#### 2.1 GNOME Desktop + Extensions

- GNOME Display Brightness DDC/CI
- Clipboard Indicator
- Argos

🧾 Argos Config: [`configs/argos/`](configs/argos/)

📜 Script: [`scripts/gnome-extensions_install.sh`](scripts/gnome-extensions_install.sh)  
📄 Doc: [`docs/gnome-extensions.md`](docs/gnome-extensions.md) *(TBD)*

---

#### 2.2 Network: ZeroTier

- Adds official key & repo
- Installs `zerotier-one`
- Optionally joins your ZeroTier network interactively

📜 Script: [`scripts/zerotier-install.sh`](scripts/zerotier-install.sh)  
📄 Doc: [`docs/zerotier.md`](docs/zerotier.md)

---

#### 2.3 AppImages

##### Trezor Suite

- Downloads, verifies signature, installs to `/opt/trezor`
- Adds icon & desktop integration

📜 Script: [`scripts/trezor-install.sh`](scripts/trezor-install.sh)  
📄 Doc: [`docs/trezor.md`](docs/trezor.md)

---

#### 2.4 Manual /opt Installations

##### Telegram

- Downloads & extracts official tarball to `/opt/telegram`
- Optional symlink to `/usr/local/bin/telegram`

📜 Script: [`scripts/telegram-install.sh`](scripts/telegram-install.sh)  
📄 Doc: [`docs/telegram.md`](docs/telegram.md)

---

#### 2.5 Personal Applications (TBD)

- Firedragon (AppImage, still testing)
- Others in `/opt` follow similar structure
- Use `assets/` for icons and `configs/*.desktop` for launchers

---

### ✅ Phase 3: Apply Configurations

| Component | Config Path |
|----------|-------------|
| **Alacritty** | `~/.config/alacritty/alacritty.toml` |
| **Vim**       | `~/.vimrc`, `~/.vim/` |
| **Bash**      | `~/.bashrc` (+ Git prompt) , `~/.bash_aliases`, `~/.profile` |
| **Git**       | `~/.gitconfig`, `~/.gitignore_global` |
| **SSH**       | `~/.ssh/config` |
| **Waybar/Sway/Albert** | `~/.config/waybar/`, `~/.config/sway/`, `~/.config/albert/` |

📄 Doc: [`docs/ssh.md`](docs/ssh.md), [`docs/dotfiles.md`](docs/dotfiles.md)

---

### 🕓 Phase 4–7: Future Planning

| Phase | Description |
|-------|-------------|
| 4     | GitOps project structure |
| 5     | Migrate scripts to Ansible |
| 6     | Terraform Proxmox provisioning |
| 7     | Bootstrap lab services (Pi-hole, Nessus, IDS, etc) |
| 8     | Migrate services to k8s node cluster (virtualized on proxmox |

---

## Notes and References

Additional notes live in:

- `notes/todo.md` — short-term checklist
- `docs/reference-links.txt` — full links to relevant tutorials, blog posts, upstream tools, etc.

---

