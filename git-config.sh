#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

SOURCE="${PWD}/assets/gitconfig"
TARGET="${HOME}/.gitconfig"
AUTHORS_SOURCE="${PWD}/assets/git-authors"
AUTHORS_TARGET="${HOME}/.git-together"

if [ -L "${TARGET}" ]; then
  # If the global git config is symlinked, remove the symlink
  unlink "${TARGET}"
fi

if [ -e "${TARGET}" ]; then
  # If the global git config exists, back it up before modifying
  echo "Copying ${TARGET} to ${TARGET}.bak"
  cp "${TARGET}" "${TARGET}.bak"
fi

cp "${SOURCE}" "${TARGET}"

if [ ! -f "${AUTHORS_TARGET}" ]; then
  cp "${AUTHORS_SOURCE}" "${AUTHORS_TARGET}"
fi

# Safe to add unconditionally: the copy above just reset ${TARGET} to the source.
git config --global --add include.path "${AUTHORS_TARGET}"
