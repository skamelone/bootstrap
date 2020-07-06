#!/bin/bash

set -o nounset # error when referencing undefined varinstallextrapackagenvimiable
set -o errexit # exit when error fails

# Various log colors
RESET=$(tput sgr0)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
BOLD=$(tput bold)

installzshconf() { \
  emsg "iTerm2 configuration installing..."
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/iterm/zsh.zip
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/iterm/zshrc
  mv zshrc .zshrc
  mv .zshrc $HOME
  unzip zsh.zip
  mv zsh $HOME/.config/
  rm zsh.zip
}

#########################################################################
################################ UTIL ###################################
#########################################################################

alreadyinstallmessage() { \
   printf "✅ $1 already installed\n" | expand -t 60
}

emsg() { \
  printf "\n\n⚙️  %s%s%s%s\n\n" $BOLD $GREEN "$1" $RESET
}

etitle() { \
  printf "\n%s%s%s%s\n" $BOLD $RED "$1" $RESET
  printf "%s%s%s%s\n" $BOLD $RED "**********************" $RESET
}

#########################################################################
################################ DEVS ###################################
#########################################################################

etitle "Configuring Terminal"

installzshconf
