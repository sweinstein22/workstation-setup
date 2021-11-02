#!/bin/bash

set -e

brewfile="${PWD}/Brewfile"

echo "Installing from the Brewfile..."
brew update || echo "brew update failed, but continuing"
brew tap Homebrew/bundle
brew bundle install

if ! brew bundle check --file "$brewfile"; then
    brew bundle --file "$brewfile"
fi

if ! cat ~/.bashrc | grep 'etc/profile.d/z.sh' > /dev/null; then
  echo 'source "$(brew --prefix)/etc/profile.d/z.sh"' >> ~/.bashrc
fi
if ! cat ~/.bash_profile | grep 'source ~/.bashrc' > /dev/null; then
  echo 'source ~/.bashrc' >> ~/.bash_profile
fi
