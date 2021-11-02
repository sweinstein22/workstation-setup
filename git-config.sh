#!/bin/bash

WORKSPACE=${PWD}
SOURCE="${PWD}/assets/gitconfig"
TARGET="${HOME}/.gitconfig"

if [ -L "${TARGET}" ]; then
  # If the global git config is symlinked, remove the symlink
  unlink "${TARGET}"
fi

if [ -e "${TARGET}" ]; then
  # If the global git config exists, back it up before modifying
  echo Copying \"${TARGET}\" to \"${TARGET}.bak\"
  cp "${TARGET}" "${TARGET}.bak"
else
  # If the global git config doesn't exist, copy it from workstation-setup
  cp "${SOURCE}" "${TARGET}"
fi

if [ ! -f "~/.git-authors" ]; then
  cp ./assets/git-authors ${HOME}/.git-together
  git config --global --add include.path ~/.git-together
fi
