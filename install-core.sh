#!/usr/bin/env bash

set -euo pipefail

# Apple Silicon puts Homebrew under /opt/homebrew, Intel under /usr/local.
if [ "$(uname -m)" = "arm64" ]; then
  BREW_PREFIX="/opt/homebrew"
else
  BREW_PREFIX="/usr/local"
fi

function install-basics {
  if ! xcode-select -p > /dev/null 2>&1; then
    echo "Installing the Xcode command line tools"
    xcode-select --install
    # xcode-select returns as soon as it has launched the GUI installer, so wait
    # for the tools to actually land before Homebrew tries to use them.
    until xcode-select -p > /dev/null 2>&1; do
      sleep 10
    done
  fi

  if ! command -v brew > /dev/null; then
    echo "Installing Homebrew"
    NONINTERACTIVE=1 /bin/bash -c \
      "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
      < /dev/null
  fi

  # to avoid ttyless complaints on brew update
  sudo mkdir -p "${BREW_PREFIX}/sbin"
  sudo chown -R "$(whoami)" "${BREW_PREFIX}/sbin"
}

install-basics
