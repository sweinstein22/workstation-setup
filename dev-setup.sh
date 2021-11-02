#!/bin/bash
set -e

function iterm {
  current_directory=$PWD
  preferences_path="/Users/$(whoami)/Library/Preferences/com.googlecode.iterm2.plist"

  cp -f "${current_directory}/assets/com.googlecode.iterm2.plist" "${preferences_path}"
}

function nvim {
  echo "Installing brew dependencies for neovim..."
  brew install ripgrep
  brew install fd
  brew install bat
  brew install gnu-sed
  grep -q "github.com/luan/nvim" ~/.config/nvim/.git/config ||
    ((chmod -f -R +w $HOME/.vim/gopath/pkg/mod/golang.org/x || true) ; rm -rf ${HOME}/.config/nvim ${HOME}/.vim* ${HOME}/.local/share/nvim &&
    git clone https://github.com/luan/nvim ~/.config/nvim)
  echo "Install python-client for neovim..."
  python3 -m pip install --user --upgrade pynvim
  echo "Add yamllint for neomake..."
  pip3 install -q yamllint
  mkdir -p ~/.config/nvim/user
  pushd ~/.config/nvim/user
    ln -sf ~/workspace/workstation-setup/assets/*.vim .
  popd
}

function tmux {
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

function inputrc {
  touch ~/.inputrc
  if ! cat ~/.inputrc | grep 'history-search-backward' > /dev/null; then
    echo '"\e[A": history-search-backward
"\e[B": history-search-forward' >> ~/.inputrc
  fi
}

iterm

nvim
nvim +UpdateRemotePlugins +qall
nvim +GoInstallBinaries +qall

tmux
inputrc
