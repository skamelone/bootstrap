#!/bin/bash

set -o nounset # error when referencing undefined varinstallextrapackagenvimiable
set -o errexit # exit when error fails

# Various log colors
RESET=$(tput sgr0)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
BOLD=$(tput bold)

installxcode() { \
  emsg "Xcode installing1..."
  sudo gem install xcode-install
  xcversion install $XCODE_DESIRED_VERSION 
  mv ~/Downloads/Xcode* /Applications/
}

installrbenv() { \
  brew install rbenv
  LINE='eval "$(rbenv init -)"'
  grep -q "$LINE" ~/.extra || echo "$LINE" >> ~/.extra
}

installsdkman() { \
  curl -s "https://get.sdkman.io" | bash
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

etitle "Installing Dev environment"
[ -d /Applications/Xcode*.app ] && alreadyinstallmessage "Xcode" || installxcode 

# # Install Swiftlint
# which swiftlint > /dev/null && alreadyinstallmessage "Swiftlint" || brew install swiftlint

# # Install Adr-List
# which adr-list > /dev/null && alreadyinstallmessage "ADR Tools" || brew install adr-tools

# # Install SwiftGen
# which swiftgen > /dev/null && alreadyinstallmessage "SwiftGen" || brew install swiftgen

# # Install Carthage
# which carthage > /dev/null && alreadyinstallmessage "Carthage" || brew install carthage

# # Install Fastlane
# which fastlane > /dev/null && alreadyinstallmessage "Fastlane" || brew cask install fastlane

# # Install Ruby-build
# which ruby-build > /dev/null && alreadyinstallmessage "Ruby-build" || brew install ruby-build

# # Install Rbenv
# which rbenv > /dev/null && alreadyinstallmessage "Rbenv" || installrbenv

# Install sdkMan
which sdk > /dev/null && alreadyinstallmessage "Sdkman" || installsdkman
