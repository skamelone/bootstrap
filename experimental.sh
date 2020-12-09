#!/bin/bash

set -o nounset # error when referencing undefined varinstallextrapackagenvimiable
set -o errexit # exit when error fails

# Various log colors
RESET=$(tput sgr0)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
BOLD=$(tput bold)

installkitty() { \
  emsg "Kitty install"
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/kitty/kitty.zip
  unzip kitty.zip
  mv kitty $HOME/.config/
  rm kitty.zip
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

etitle "Installing Kitty"

# Install Swiftlint
# which kitty > /dev/null && alreadyinstallmessage "Kitty" || installkitty

