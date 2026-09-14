#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# luan/nvim's main branch is now a LazyVim rewrite with a different config layout.
# assets/after.vim depends on g:leader_key_map and g:coc_filetype_map, which only
# exist in the vimscript config, so this stays pinned until after.vim is ported.
NVIM_CONFIG_REF="ed4220a3942420b29a734ac52119e10d56a4fd36"

# Homebrew's python is externally managed (PEP 668), so pynvim cannot be pip
# installed into it. assets/before.vim points neovim at this virtualenv.
NVIM_VENV="${HOME}/.local/share/nvim-venv"

# These are named install_* rather than iterm/nvim/tmux because a shell function
# shadows the binary of the same name for the rest of the script.
function install_iterm {
  preferences_path="${HOME}/Library/Preferences/com.googlecode.iterm2.plist"

  cp -f "${REPO_DIR}/assets/com.googlecode.iterm2.plist" "${preferences_path}"
}

function install_nvim {
  grep -q "github.com/luan/nvim" ~/.config/nvim/.git/config 2> /dev/null ||
    ( (chmod -f -R +w $HOME/.vim/gopath/pkg/mod/golang.org/x || true) ; rm -rf ${HOME}/.config/nvim ${HOME}/.vim* ${HOME}/.local/share/nvim &&
    git clone https://github.com/luan/nvim ~/.config/nvim)
  pushd ~/.config/nvim
    git checkout "${NVIM_CONFIG_REF}"
  popd
  echo "Install python-client for neovim..."
  python3 -m venv "${NVIM_VENV}"
  "${NVIM_VENV}/bin/pip" install --quiet --upgrade pip pynvim
  mkdir -p ~/.config/nvim/user
  pushd ~/.config/nvim/user
    ln -sf "${REPO_DIR}"/assets/*.vim .
  popd
}

function install_tmux {
  echo "Installing (Luan's) tmux configuration"

  set +e
  test -f "${HOME}/.tmux.conf" && mv -f "${HOME}/.tmux.conf" "${HOME}/.tmux.conf.bak"
  test -d "${HOME}/.tmux" && rm -rf "${HOME}/.tmux.bak" && mv "${HOME}/.tmux" "${HOME}/.tmux.bak"
  test -d "${HOME}/.config/tmux" && rm -rf "${HOME}/.config/tmux.bak" && mv -f "${HOME}/.config/tmux" "${HOME}/.config/tmux.bak"
  set -e

  ### luan's tmux install
  git clone https://github.com/luan/tmuxfiles.git "${HOME}/.config/tmux"
  "${HOME}/.config/tmux/install"
}

function install_inputrc {
  touch ~/.inputrc
  if ! grep -qs 'history-search-backward' ~/.inputrc; then
    echo '"\e[A": history-search-backward
"\e[B": history-search-forward' >> ~/.inputrc
  fi
}

install_iterm

install_nvim
# plug.vim curls vim-plug on first start but cannot load it in the same invocation,
# so the first run only bootstraps. The second lets the config auto-install plugins.
nvim --headless +qall > /dev/null 2>&1 || true
nvim +qall
nvim +UpdateRemotePlugins +qall
nvim +GoInstallBinaries +qall

install_tmux
install_inputrc
