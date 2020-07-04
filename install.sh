#!/bin/bash

set -o nounset # error when referencing undefined variable
set -o errexit # exit when error fails

installhomebrew() { \
  /bin/bash -c "$(curl -fssl https://raw.githubusercontent.com/homebrew/install/master/install.sh)"
  echo "Homebrew installed"
}

installgit() { \
  brew install git
}

echo 'Installing Bootstrap'

# Install Homebrew
installhomebrew

# Install git
which brew > /dev/null && "Git installed" || installgit
