#!/bin/bash

if [ ! -d ~/workspace/capi-workspace ]; then
  git clone git@github.com:cloudfoundry/capi-workspace ~/workspace/capi-workspace
fi

brew tap cloudfoundry/tap
brew install bosh-cli
brew install bbl
brew install chruby

if ! cat ~/.bashrc | grep 'alias capi-ws-1' > /dev/null; then
  echo "
alias capi-ws-1='gcloud beta compute ssh --zone \"us-central1-a\" \"pivotal@capi-ws-1\" --project \"cf-capi-arya\"  --ssh-flag=\"-A\"'
alias capi-ws-2='gcloud beta compute ssh --zone \"us-central1-a\" \"pivotal@capi-ws-2\" --project \"cf-capi-arya\"  --ssh-flag=\"-A\"'
alias capi-ws-3='gcloud beta compute ssh --zone \"us-central1-a\" \"pivotal@capi-ws-3\" --project \"cf-capi-arya\"  --ssh-flag=\"-A\"'
alias capi-ws-4='gcloud beta compute ssh --zone \"us-central1-a\" \"pivotal@capi-ws-4\" --project \"cf-capi-arya\"  --ssh-flag=\"-A\"'
alias capi-ws-5='gcloud beta compute ssh --zone \"us-central1-a\" \"pivotal@capi-ws-5\" --project \"cf-capi-arya\"  --ssh-flag=\"-A\"'
" >> ~/.bashrc
fi

chmod -R a+x ~/workspace/capi-workspace/install-scripts
echo 'Running scripts from capi-workspace'
~/workspace/capi-workspace/install-scripts/bundler.sh
~/workspace/capi-workspace/install-scripts/clone-repos.sh
