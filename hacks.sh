#!/bin/bash

## I was having issues getting `git add -p` to work due to the following error:
## ```
## sh: /usr/local/share/git-core/contrib/diff-highlight/diff-highlight: No such file or directory
## Cannot close git diff\-files \-p \-\-color \-\- aliases\.sh | /usr/local/share/git-core/contrib/diff-highlight/diff-highlight ()
## at /opt/homebrew/Cellar/git/2.35.1/libexec/git-core/git-add--interactive line 183.
## ```

## The following manually installs highlight-diff and creates a symlink to where
## the package is expected to be

cd ~/Downloads || exit

echo 'Installing pip'
echo 'curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py'
echo 'python3 get-pip.py'

echo 'Installing diff-highlight'
echo 'sudo easy_install diff-highlight'

echo 'rm get-pip.py'

cd - || exit

echo 'Creating path to expected diff-highlight location'
echo 'sudo mkdir /usr/local/share' || true
echo 'sudo mkdir /usr/local/share/git-core' || true
echo 'sudo mkdir /usr/local/share/git-core/contrib' || true
echo 'sudo mkdir /usr/local/share/git-core/contrib/diff-highlight' || true
echo 'sudo ln -s /usr/local/bin/diff-highlight /usr/local/share/git-core/contrib/diff-highlight/diff-highlight'

echo 'symlink for diff-highlight created'
