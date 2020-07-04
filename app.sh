#!/bin/bash

set -o nounset # error when referencing undefined varinstallextrapackagenvimiable
set -o errexit # exit when error fails

# Various log colors
RESET=$(tput sgr0)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
BOLD=$(tput bold)


installbartender() { \
  brew cask install --appdir="/Applications" bartender 
}

#########################################################################
################################ UTIL ###################################
#########################################################################

alreadyinstallmessage() { \
   printf "✅ $1 already installed\n" | expand -t 60
}

emsg() { \
  printf "\n\n⚙️%s%s%s%s\n\n" $BOLD $GREEN "$1" $RESET
}

etitle() { \
  printf "\n%s%s%s%s\n" $BOLD $RED "$1" $RESET
  printf "%s%s%s%s\n" $BOLD $RED "**********************" $RESET
}

#########################################################################
################################ APPS ###################################
#########################################################################

etitle "Installing Apps"

[ -d /Applications/Alfred*.app ] && alreadyinstallmessage "Alfred" || brew cask install --appdir="/Applications" alfred
[ -d /Applications/Sublime\ Text*.app ] && alreadyinstallmessage "Sublime Text" || brew cask install --appdir="/Applications" sublime-text
[ -d /Applications/Sublime\ Merge*.app ] && alreadyinstallmessage "Sublime Merge" || brew cask install --appdir="/Applications" sublime-merge
[ -d /Applications/Firefox.app ] && alreadyinstallmessage "Firefox" || brew cask install --appdir="/Applications" firefox
[ -d /Applications/Evernote.app ] && alreadyinstallmessage "Evernote" || brew cask install --appdir="/Applications" evernote
[ -d /Applications/Spotify.app ] && alreadyinstallmessage "Spotify" || brew cask install --appdir="/Applications" spotify
[ -d /Applications/Hammerspoon.app ] && alreadyinstallmessage "Hammerspoon" || brew cask install --appdir="/Applications" hammerspoon
[ -d /Applications/Dropbox.app ] && alreadyinstallmessage "Dropbox" || brew cask install --appdir="/Applications" dropbox
[ -d /Applications/Karabiner-Elements.app ] && alreadyinstallmessage "Karabiner-Elements" || brew cask install --appdir="/Applications" karabiner-elements
[ -d /Applications/Bartender*.app ] && alreadyinstallmessage "Bartender" || installbartender
[ -d /Applications/Dash.app ] && alreadyinstallmessage "Dash" || brew cask install --appdir="/Applications" dash
[ -d /Applications/Charles.app ] && alreadyinstallmessage "Charles" || brew cask install --appdir="/Applications" charles
[ -d /Applications/1Password*.app ] && alreadyinstallmessage "1Password" || brew cask install --appdir="/Applications" 1password-cli
[ -d /Applications/Fantastical*.app ] && alreadyinstallmessage "Fantastical" || brew cask install --appdir="/Applications" fantastical
[ -d /Applications/Kaleidoscope.app ] && alreadyinstallmessage "Kaleidoscope" || brew cask install --appdir="/Applications" kaleidoscope
[ -d /Applications/Amphetamine.app ] && alreadyinstallmessage "Amphetamine" || brew cask install --appdir="/Applications" amphetamine


