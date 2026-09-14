#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

# Apple Silicon puts Homebrew under /opt/homebrew, Intel under /usr/local.
if [ -x /opt/homebrew/bin/brew ]; then
  BREW="/opt/homebrew/bin/brew"
else
  BREW="/usr/local/bin/brew"
fi

# zsh reads ~/.zprofile for login shells, which is where PATH belongs.
if ! grep -qs 'brew shellenv' "${HOME}/.zprofile"; then
  echo "Adding homebrew executables"
  echo "eval \"\$(${BREW} shellenv)\"" >> "${HOME}/.zprofile"
fi
eval "$(${BREW} shellenv)"

brewfile="${PWD}/Brewfile"

echo "Installing from the Brewfile..."
brew update || echo "brew update failed, but continuing"

if ! brew bundle check --file "$brewfile"; then
  brew bundle install --file "$brewfile"
fi

if ! grep -qs 'etc/profile.d/z.sh' "${HOME}/.zshrc"; then
  echo 'source "$(brew --prefix)/etc/profile.d/z.sh"' >> "${HOME}/.zshrc"
fi
