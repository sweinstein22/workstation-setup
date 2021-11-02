#!/usr/bin/env bash

set +e

function install-basics {
  xcode-select --install

  if ! which brew > /dev/null ; then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
    </dev/null
  fi
  # to avoid ttyless complaints on brew update
  sudo mkdir -p /usr/local/sbin
  sudo chown -R $(whoami) /usr/local/sbin

  # use homebrew-provided, updated bash
  echo /usr/local/bin/bash | sudo tee -a /etc/shells
  sudo chsh -s /usr/local/bin/bash
}

install-basics
