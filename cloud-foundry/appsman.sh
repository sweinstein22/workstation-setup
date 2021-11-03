#!/bin/bash

brew install node yarn nginx lastpass-cli nvm

if [ ! -d ~/.nvm ]; then
  mkdir ~/.nvm
  echo "
export NVM_DIR="$HOME/.nvm"
[ -s \"/usr/local/opt/nvm/nvm.sh\" ] && . \"/usr/local/opt/nvm/nvm.sh\"  # This loads nvm
[ -s \"/usr/local/opt/nvm/etc/bash_completion.d/nvm\" ] && . \"/usr/local/opt/nvm/etc/bash_completion.d/nvm\"  # This loads nvm bash_completion
" >> ~/.bash_profile
fi

pushd ~/workspace
  git clone git@github.com:pivotal-cf/apps-manager-js.git
  git clone git@github.com:pivotal-cf/apps-manager-ci.git
popd
