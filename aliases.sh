#!/usr/bin/env bash

set -euo pipefail

ZSHRC="${HOME}/.zshrc"
touch "${ZSHRC}"

if ! grep -qs 'alias gst' "${ZSHRC}"; then
  cat >> "${ZSHRC}" << 'EOF'

alias gst="git status"
alias vim="nvim"

# Alt-Left / Alt-Right move by word.
bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word
EOF
fi
