#!/bin/bash

brew install chruby
brew install ruby@2.7
brew install mysql
sudo gem install bundler:2.1.4

if [ ! -e ~/workspace/capi-release/src/cloud_controller_ng/README.md ]; then
  pushd ~/workspace
    rm -rf capi-release
    git clone git@github.com:cloudfoundry/capi-release.git --recurse-submodules
  popd
fi
