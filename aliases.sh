#!/bin/bash

if ! cat ~/.bashrc | grep 'alias gst' > /dev/null; then
  echo 'alias gst="git status"' >> ~/.bashrc
  echo 'alias vim="nvim"' >> ~/.bashrc
  echo 'source "$HOME"/.bashrc' >> ~/.bash_profile
fi
