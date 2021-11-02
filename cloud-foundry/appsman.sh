#!/bin/bash

brew install node yarn nginx lastpass-cli

pushd ~/workspace
  git clone git@github.com:pivotal-cf/apps-manager-js.git
  git clone git@github.com:pivotal-cf/apps-manager-ci.git
popd
