#!/usr/bin/env bash

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

./install-core.sh
# oh-my-zsh lays down a fresh ~/.zshrc, so it has to run before anything appends to it.
./zsh.sh

./brew.sh
./aliases.sh
./git-config.sh
./dev-setup.sh
