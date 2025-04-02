# Setting Up `cheat` with Custom Cheatsheets

Cheat is a cool inline cheatsheet. Like a better manpages with capability to link your custom docs to access anytime!
---

## 1. Install `cheat`

If you have go installed: 

```bash
go install github.com/cheat/cheat/cmd/cheat@latest
```
Make sure `$HOME/go/bin` is in your `$PATH`.

---

## 2. Specify Pager in config.yml

Cheat will throw a pager error unless you alter the conf.yml file according to the comments withinL

Initiate and edit the cheat config:

```bash
mkdir -p ~/.config/cheat
cheat --init > ~/.config/cheat/conf.yml
vim ~/.config/cheat/conf.yml
```

---

## 3. Link Markdown Cheatsheets

link your docs from chosen directory or repo:

```bash
cd /your/doc/directory/

for f in *.md; do
  ln -sf "$(pwd)/$f" ~/.config/cheat/cheatsheets/personal/"$f"
  ln -sf "$f" ~/.config/cheat/cheatsheets/personal/"${f%.md}"
done
```

This links both `name.md` and a clean `name` (no `.md`), so `cheat` recognizes it.

---

## 4. Validate It Works

```bash
cheat -l          # List all available sheets
cheat vim          # View your 'vim.md' doc
cheat git          # View your 'git.md' doc
```

---

## Done
You now have `cheat` wired up with your personal markdown docs, and a properly configured pager.

