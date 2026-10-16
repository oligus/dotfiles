# dotfiles

Config for macOS, managed with [GNU Stow](https://www.gnu.org/software/stow/). Every top-level
directory is a package whose contents mirror `~`, so `stow zsh` links `zsh/.zshrc` to `~/.zshrc`.

No credentials live here — only config.

## New machine

```bash
git clone https://github.com/oligus/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

## Packages

| Package  | Links |
|----------|-------|
| `zsh`    | `.zshrc`, `.zprofile`, `.zshenv` |
| `git`    | `.gitconfig`, `.config/git/ignore` |
| `claude` | `.claude/settings.json`, `.claude/agents/` |
| `skills` | `.agents/.skill-lock.json` — the list of installed agent skills and their sources |
| `emacs`  | `.emacs.d/init.el` |

`Brewfile` is not a package; `install.sh` runs `brew bundle` on it.

## Day to day

- Edit files in place (`~/.zshrc`) — they are symlinks into this repo, so commit from here.
- Track a new file: move it into the right package, then `stow -R <package>`.
- Refresh the Brewfile: `brew bundle dump --file=~/dotfiles/Brewfile --force`.
- Some tools (Claude Code among them) may replace a symlink with a plain file when they save.
  `stow -n -v -R -t ~ <package>` then reports a conflict; fix it with
  `stow --adopt -t ~ <package>`, which moves the file back into the repo and relinks it
  (check `git diff` afterwards).
