# Dotfiles Reference

This document outlines the structure, purpose, and specific configuration choices for the key dotfiles used in my shell environment. It serves as both a reference and rationale for why each file is configured a certain way.

---

## dotfiles Management

**chezmoi** Used to manage dotfiles (for now)
[chezmoi documentation](https://www.chezmoi.io/quick-start/)


## `.bash_env`
**Purpose:** Shared environment configuration loaded by both `.bashrc` and `.profile`.

**Contents:**
- Appends personal bin directories to `$PATH` safely and idempotently
- Defines environment variables: `EDITOR`, `VISUAL`, `PAGER`, `GOPATH`

---

## `.bashrc`
**Purpose:** Interactive shell configuration. Sourced for non-login shells (e.g., terminal emulator sessions).

**Key Behaviors:**
- Sources `.bash_env` for consistent environment setup
- Defines shell interactivity settings (history, prompt, etc.)
- Loads `.bash_aliases`

---

## `.profile`
**Purpose:** Login shell setup. Sources `.bash_env` and `.bashrc` to ensure full environment for SSH/TTY.

---

## `.bash_aliases`
**Purpose:** Stores all my bash aliases; kept modular.

---

## `.vimrc`

Vim is configured for high-speed, modal editing with a modular and secure setup. The main config lives in `~/.vimrc` and is backed by plugin-specific logic and filetype rules in `~/.vim/plugin/`.

Key features:

- **Plugin-Driven Architecture** via [Vundle](https://github.com/VundleVim/Vundle.vim)
  - Fuzzy nav (`ctrlp`), git tools (`fugitive`), statusline (`airline`), buffer explorer, and language syntax support
- **Security Hardened** with controlled modeline behavior and logging for shell overrides
- **Custom Compile Dispatcher** with `<F5>` mapped to language-specific build/run
- **Custom Project Bootstraps** with `:TabRepo` for isolated tab working environments
- **Filetype-Specific Indentation** handled via `plugin/filetype-indent_settings.vim`
- **ChezMoi Integrated**: `:VimrcApply` triggers a `chezmoi apply` and reload

For full configuration and mappings, see [`vim.md`](docs/vim.md).

### `.vim/` Directory
**Purpose:** Storage for custom plugins, colorschemes, or ftplugin overrides (if used).

**Common Usage:**
- `~/.vim/colors/` for color schemes
- `~/.vim/ftplugin/` for language-specific tweaks
- `~/.vim/autoload/` + `~/.vim/plug.vim` if using plugin managers like vim-plug
- `~/.vim/plugin/filetype-indent_settings.vim`

---

## Notes
- `.bash_env` is the authoritative location for PATH and env vars
- `.bashrc` is strictly for interactive shell config
- `.profile` is only for login shells, used to bridge `.bashrc` and `.bash_env`
- `.bash_aliases` is only for user-defined aliases
- `.vimrc` is self-contained but can optionally source modular config files if needed

