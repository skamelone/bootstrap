#!/bin/bash

set -o nounset # error when referencing undefined varinstallextrapackagenvimiable
set -o errexit # exit when error fails

# Various log colors
RESET=$(tput sgr0)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
BOLD=$(tput bold)

installxcode() { \
  emsg "Xcode installing..."
  sudo gem install xcode-install
  xcversion install $XCODE_DESIRED_VERSION 
  configurexcode
}

installrbenv() { \
  emsg "Rbenv installing..."
  brew install rbenv
  LINE='eval "$(rbenv init -)"'
  grep -q "$LINE" ~/.extra || echo "$LINE" >> ~/.extra
}

installsdkman() { \
  emsg "SdkMan installing..."
  curl -s "https://get.sdkman.io" | bash
}

installandroid() { \
  emsg "Android Studio installing..."
  brew cask install --appdir="/Applications" android-studio
}

configurexcode() { \
  emsg "Configuring Xcode..."
  read -p "Please start and stop XCode. Create a self-signing certificate named \"xcodesigner\". Is it done? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo xcode-select -s /Applications/Xcode.app
    mkdir -p $HOME/Library/Developer/Xcode/UserData/FontAndColorThemes/
    wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/xcode/xcode.zip
    unzip xcode.zip
    sudo cp -R ./xcode/*.xccolortheme $HOME/Library/Developer/Xcode/UserData/FontAndColorThemes/
    sudo cp -R ./xcode/Empty\ Application.xctemplate /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project\ Templates/iOS/Application/
    rm -fr xcode
    emsg "Signing Xcode for Xvim..."
    sudo codesign -f -s xcodesigner /Applications/Xcode.app
    git clone https://github.com/XVimProject/XVim2.git
    cd XVim2
    make
    cd ..
    rm -fr XVim2
  fi;
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
[ -d /Applications/Xcode.app ] && alreadyinstallmessage "Xcode" || installxcode 

# Install Swiftlint
# which swiftlint > /dev/null && alreadyinstallmessage "Swiftlint" || brew install swiftlint

# Install Adr-List
which adr-list > /dev/null && alreadyinstallmessage "ADR Tools" || brew install adr-tools

# Install SwiftGen
# which swiftgen > /dev/null && alreadyinstallmessage "SwiftGen" || brew install swiftgen

# Install Carthage
# which carthage > /dev/null && alreadyinstallmessage "Carthage" || brew install carthage

# Install Fastlane
# which fastlane > /dev/null && alreadyinstallmessage "Fastlane" || brew cask install fastlane

# Install Ruby-build
which ruby-build > /dev/null && alreadyinstallmessage "Ruby-build" || brew install ruby-build

# Install Rbenv
which rbenv > /dev/null && alreadyinstallmessage "Rbenv" || installrbenv

# Install sdkMan
[ -d $HOME/.sdkman ] && alreadyinstallmessage "Sdkman" || installsdkman

# Install android-studio
[ -d /Applications/Android\ Studio.app ] && alreadyinstallmessage "Android studio" || installandroid

