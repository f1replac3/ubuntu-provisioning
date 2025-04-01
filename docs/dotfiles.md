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

```bash
for dir in "$HOME/.local/bin" "$HOME/bin" "/usr/local/go/bin"; do
  if [ -d "$dir" ] && [[ ":$PATH:" != *":$dir:"* ]]; then
    PATH="$PATH:$dir"
  fi
done
export PATH

export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export PAGER=/usr/bin/less
export GOPATH="$HOME/go"
```

---

## `.bashrc`
**Purpose:** Interactive shell configuration. Sourced for non-login shells (e.g., terminal emulator sessions).

**Key Behaviors:**
- Sources `.bash_env` for consistent environment setup
- Defines shell interactivity settings (history, prompt, etc.)
- Loads `.bash_aliases`

```bash
[ -f "$HOME/.bash_env" ] && . "$HOME/.bash_env"

case $- in
  *i*) ;;  # Continue only if interactive
  *) return ;;
esac

# History settings
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
HISTSIZE=100000
HISTFILESIZE=2000000
shopt -s checkwinsize

# lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Load user aliases
[ -f "$HOME/.bash_aliases" ] && . "$HOME/.bash_aliases"
```

---

## `.profile`
**Purpose:** Login shell setup. Sources `.bash_env` and `.bashrc` to ensure full environment for SSH/TTY.

```bash
[ -f "$HOME/.bash_env" ] && . "$HOME/.bash_env"

if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi
```

---

## `.bash_aliases`
**Purpose:** Aliases for common CLI commands, kept modular.

**Example Content:**
```bash
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
```

---

## `.vimrc`
**Purpose:** Vim configuration for a minimal but effective editing experience.

**Core Settings:**
```vim
set nocompatible
set number
set relativenumber
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set nowrap
set cursorline
set clipboard=unnamedplus
```

---

## `.vim/` Directory
**Purpose:** Storage for custom plugins, colorschemes, or ftplugin overrides (if used).

**Common Usage:**
- `~/.vim/colors/` for color schemes
- `~/.vim/ftplugin/` for language-specific tweaks
- `~/.vim/autoload/` + `~/.vim/plug.vim` if using plugin managers like vim-plug

---

## Notes
- `.bash_env` is the authoritative location for PATH and env vars
- `.bashrc` is strictly for interactive shell config
- `.profile` is only for login shells, used to bridge `.bashrc` and `.bash_env`
- `.bash_aliases` is only for user-defined aliases
- `.vimrc` is self-contained but can optionally source modular config files if needed

