#!/usr/bin/env bash

set -o nounset # error when referencing undefined varinstallextrapackagenvimiable
set -o errexit # exit when error fails

# Various log colors
RESET=$(tput sgr0)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
BOLD=$(tput bold)


installpopclip() { \
  mas lucky PopClip
  mkdir -p ~/Library/Application\ Support/PopClip/Extensions/
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/popclip/popclip.zip
  unzip popclip.zip
  mv popclip/* $HOME/Library/Application\ Support/PopClip/Extensions/
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
  printf "%s%s%s%s\n\n" $BOLD $RED "**********************" $RESET
}

#########################################################################
################################ DEVS ###################################
#########################################################################

etitle "Installing Store apps\n"

[ -d /Applications/PopClip.app ] && alreadyinstallmessage "PopClip" || installpopclip
[ -d /Applications/DevCleaner.app ] && alreadyinstallmessage "DevCleaner" || mas lucky DevCleaner
[ -d /Applications/Dark\ Mode\ for\ Safari.app ] && alreadyinstallmessage "Dark Mode" || mas lucky "Dark Mode"
[ -d /Applications/Quiver.app ] && alreadyinstallmessage "Quiver" || mas lucky Quiver
[ -d /Applications/Amphetamine.app ] && alreadyinstallmessage "Amphetamine" || mas install 937984704
[ -d /Applications/Pikka.app ] && alreadyinstallmessage "Pikka" || mas lucky Pikka
[ -d /Applications/daisydisk.app ] && alreadyinstallmessage "DaisyDisk" || mas lucky daisydisk
[ -d /Applications/pixelmator.app ] && alreadyinstallmessage "pixelmator" || mas lucky pixelmator
[ -d /Applications/Canary*.app ] && alreadyinstallmessage "Canary Email" || mas lucky "Canary Mail"
[ -d /Applications/Canary*.app ] && alreadyinstallmessage "Canary Email" || mas lucky "Canary Mail"

