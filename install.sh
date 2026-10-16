#!/usr/bin/env bash
# Set up a new machine: install Homebrew packages, then symlink every package into ~.
set -euo pipefail

cd "$(dirname "$0")"

if ! command -v brew >/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew bundle --file=Brewfile

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

PACKAGES=(zsh git claude skills emacs)
stow -v -t "$HOME" "${PACKAGES[@]}"

echo "Done. Reinstall skills from skills/.agents/.skill-lock.json with your skills installer."
