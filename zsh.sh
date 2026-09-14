#!/usr/bin/env bash

set -euo pipefail

if [ -d "${ZSH:-${HOME}/.oh-my-zsh}" ]; then
  echo "oh-my-zsh is already installed"
  exit 0
fi

# RUNZSH=no keeps the installer from exec'ing a login zsh, which would replace this
# process and abandon the rest of install.sh. CHSH=no leaves the login shell alone,
# since zsh is already the default on macOS.
RUNZSH=no CHSH=no sh -c \
  "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
