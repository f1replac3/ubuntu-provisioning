# Git Configuration and Workflow Cheatsheet

This document captures Git best practices, SSH commit signing, global configuration, and techniques for recovering from sensitive data leaks using `git filter-repo`.

---

## Git Configuration

### Global Git Config

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --global core.editor "vim"
git config --global init.defaultBranch main
```

### Set Global Git Ignore

```bash
echo ".secrets/" >> ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global
```

Verify:

```bash
git config --global --get core.excludesfile
```

---

## SSH Commit Signing

James uses an SSH signing key with GitHub.

### Configure Git to Sign with SSH

Add this to your `.bashrc` or `.bash_profile`:

```bash
export GIT_SSH_COMMAND="ssh -i ~/.ssh/id_ed25519"
```

Tell Git to use this key for signing:

```bash
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ed25519.pub
git config --global commit.gpgsign true
```

Check signing status with:

```bash
git log --show-signature
```

---

## Recovering from Pushed Secrets

If sensitive data like `autoinstall.yaml` or `README.md` with private data is accidentally committed and pushed, you can fully remove all traces with:

### Install `git-filter-repo`

Ubuntu:

```bash
sudo apt install git-filter-repo
```

Or install via Python (more up-to-date):

```bash
pip install git-filter-repo
```

### Rewrite History to Remove File

```bash
git filter-repo --path autoinstall.yaml --invert-paths
```

To remove multiple files:

```bash
git filter-repo --path autoinstall.yaml --path README.md --invert-paths
```

Note:
- This rewrites Git history!
- All users must re-clone the repo after force-push.

### Force Push the Cleaned Repo

```bash
git remote add origin git@github.com:f1replac3/ubuntu-provisioning.git
git push --force --set-upstream origin main
```

---

## Best Practices

- Always `.gitignore` secrets and temporary logs
- Create global Git configuration for cleaner history
- Consider using a repo structure like `~/src/github.com/<username>/repo`
- When using SSH commit signing, test with a signed dummy commit
- Document each script and config in a `docs/` file
- Use force-push only when recovering from mistakes — explain clearly in commit messages or docs

---

## References

- [GitHub Docs: Signing commits with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/signing-commits-with-ssh-keys)
- [git-filter-repo](https://github.com/newren/git-filter-repo)
- [Baeldung Bash Git Prompt Tutorial](https://www.baeldung.com/linux/bash-prompt-git)


---

## Git Cheatsheet Matrix

| Task                                 | Command                                                                 |
|--------------------------------------|-------------------------------------------------------------------------|
| Initialize a repo                    | `git init`                                                              |
| Add remote repo                      | `git remote add origin git@github.com:username/repo.git`               |
| Add files to staging                 | `git add .` or `git add <file>`                                         |
| Commit changes                       | `git commit -m "message"`                                               |
| Push to remote                       | `git push -u origin main`                                               |
| Clone a repo                         | `git clone git@github.com:username/repo.git`                            |
| Check status                         | `git status`                                                            |
| See log                              | `git log --oneline`                                                     |
| Create new branch                    | `git checkout -b <branch>`                                              |
| Switch branches                      | `git checkout <branch>`                                                 |
| Merge branches                       | `git merge <branch>`                                                    |
| Rebase branch                        | `git rebase <branch>`                                                   |
| Remove file from Git history         | `git filter-repo --path <file> --invert-paths`                          |
| Global Git ignore                    | `git config --global core.excludesfile ~/.gitignore_global`            |
| Check config                         | `git config --list`                                                     |
| Sign commits                         | `git commit -S -m "message"`                                            |
| View signed commits                  | `git log --show-signature`                                              |
| Undo local commit (keep changes)     | `git reset --soft HEAD~1`                                               |
| Discard local commit and changes     | `git reset --hard HEAD~1`                                               |
| Remove file from index               | `git rm --cached <file>`                                                |

---

## General Git Best Practices

- ✅ Use meaningful commit messages.
- ✅ Commit early and often (small commits).
- ✅ Never commit secrets or passwords.
- ✅ Use `.gitignore` effectively.
- ✅ Rebase interactively (`git rebase -i`) to clean up history.
- ✅ Document all Git workflows in a team or personal knowledge base.
- ✅ Sign your commits and verify them.
- ✅ Separate experimental branches from production.
- ✅ Use branches for features or changes, and squash commits before merge.

