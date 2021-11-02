#!/bin/bash

brew install chruby
brew install ruby@2.7
brew install mysql
brew install postgresql

if [ ! -e ~/workspace/capi-release/src/cloud_controller_ng/README.md ]; then
  pushd ~/workspace
    rm -rf capi-release
    git clone git@github.com:cloudfoundry/capi-release.git --recurse-submodules

    sudo gem install bundler:2.1.4
    # gem install mysql2 -- --srcdir=/usr/local/mysql/include

    brew services start postgresql
    createuser -s postgres
    DB=postgres rake db:create
  popd
fi
