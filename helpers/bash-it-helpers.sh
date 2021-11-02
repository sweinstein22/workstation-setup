#!/bin/bash

set -e

BASH_IT=$HOME/.bash_it
function enable_custom_bash_it_plugin {
  local filepath=$1
  local filename=$(basename $filepath)

  if [ ! -d $BASH_IT/custom ]; then
    mkdir -p "${BASH_IT}/custom"
  fi

  pushd $BASH_IT/custom > /dev/null
    if [ ! -e "./$filename" ]; then
      echo "Enabling $filename custom bash_it plugin"
      ln -s $filepath
    else
      echo "$filename custom bash_it plugin already enabled"
    fi
  popd > /dev/null
}

function enable_bash_it_entity {
  local name=$1
  local directory=$2
  local extension=$3
  local filename="$name.$extension.bash"

  if [ ! -d $BASH_IT/$directory/enabled ]; then
    mkdir -p "$BASH_IT/$directory/enabled"
  fi

  pushd $BASH_IT/$directory/enabled > /dev/null
    if [ ! -e "./$filename" ]; then
      echo "Enabling $name bash_it $extension"
      ln -s "$BASH_IT/$directory/available/$filename"
    else
      echo "$name bash_it $extension already enabled"
    fi
  popd > /dev/null
}

function enable_bash_it_plugin {
  local plugin=$1
  enable_bash_it_entity $plugin plugins plugin
}

function enable_bash_it_completion {
  local completion=$1
  enable_bash_it_entity $completion completion completion
}

function enable_bash_it_alias {
  local completion=$1
  enable_bash_it_entity $completion aliases aliases
}
