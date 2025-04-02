# Vim Cheatsheet for Elite Workflows

A vim reference doc based on my .vimrc modifications and personalization.
Including both base vim keybindings, plus personalized keybindings as shown in my .vimrc


---

## General Navigation

```vim
h j k l        " Move left/down/up/right
w / b          " Jump word forward/back
^ / $          " Jump to start/end of line
G / gg         " Jump to end/start of file
:number        " Jump to specific line
```

---

## Buffers, Tabs, Splits

```vim
<leader>be     " Open new empty buffer
<leader>bp     " Previous buffer
<leader>bn     " Next buffer
<leader>bl     " List all buffers
<leader>bd     " Delete current buffer
<leader>bb     " Open BufExplorer

<leader>tn     " New tab
<leader>tc     " Close tab
<leader>tr     " Next tab
<leader>tl     " Previous tab
<leader>to     " Close all other tabs

<leader>sv     " Vertical split
<leader>sh     " Horizontal split
<leader>so     " Close all other splits
```

---

## Searching & Replacing

```vim
/word          " Search forward
?word          " Search backward
n / N          " Repeat search forward/backward
:%s/foo/bar/g  " Replace globally

set ignorecase     " Case-insensitive by default
set smartcase      " But respect capitals if used
set hlsearch       " Highlight matches
```

---

## Mappings & Shortcuts

```vim
<leader>w      " Save
<leader>q      " Quit
<leader>a      " Select all
<leader>e      " Edit .vimrc
<leader>ca     " Apply + reload .vimrc via chezmoi
<F9>           " Open file under cursor in new tab
<C-\>          " Open ctag under cursor in new tab
```

---

## Plugin Shortcuts

```vim
<C-p>          " CtrlP file finder
<leader>fb     " CtrlP buffer finder
<leader>n      " Toggle NERDTree

:TabRepo <dir>     " Custom tab-local working directory + NERDTree
```

---

## Formatting & Visual

```vim
set fo+=o      " Continue comments on new lines
set fo-=r      " Don't auto-comment after <Enter>
set fo-=t      " Don't auto-wrap text
set textwidth=0
set nowrap
set showbreak=↪\
```

---

## Utilities

```vim
<leader>b      " Base64 decode word under cursor
<leader>g      " Grep word under cursor in project (new tab)
<leader>s      " Sort + dedup buffer lines
```

---

## Compile & Run (F5)

```vim
<F5> compiles and runs current file depending on filetype:

- .c        → gcc + time run
- .cpp      → g++ + time run
- .java     → javac + run
- .sh       → bash
- .py       → python3
- .go       → go build + run
- .html     → opens in Firefox
- .mkd      → markdown.pl + view
```

---

## Security & Best Practices

```vim
set secure
set modeline
set modelines=5
set nomodelineexpr

" Warn if 'shell' is changed
augroup DetectShellOverride
  autocmd!
  autocmd OptionSet shell if &shell !=# '/bin/bash' |
        \ echomsg '⚠️  shell modified: ' . &shell |
        \ call writefile([strftime('%F %T') . ' ⚠️ shell modified: ' . &shell],
        \   expand('~/.vim/shell_override.log'), 'a') |
        \ endif
augroup END
```

---

## Modular Filetype Indentation

All indent rules are now offloaded to:
```vim
~/.vim/plugin/filetype-indent_settings.vim
```

See that file for tabstop/shiftwidth settings per filetype: Python, Shell, Vim, Markdown, Rust, Go, etc.

---

## ⚡ Performance Tips

- `hidden` lets you switch buffers without saving
- `wildmenu` + `wildmode` speeds up command completion
- `CtrlP` + `BufExplorer` = elite buffer/file nav
- `NERDTree` + `TabRepo` keeps projects isolated

---

## Bottom Line

This setup prioritizes:
- Security
- Performance
- Reproducibility
- Project-based workflows

🔥 Maintain it like code. Evolve with need. Document intentionally.

