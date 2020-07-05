#!/bin/bash

set -o nounset # error when referencing undefined varinstallextrapackagenvimiable
set -o errexit # exit when error fails

# Various log colors
RESET=$(tput sgr0)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
BOLD=$(tput bold)

installiterm() { \
  emsg "iTerm2 installing..."
  brew cask install iterm2
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/iterm/com.googlecode.iterm2.plist
  mv com.googlecode.iterm2.plist $HOME/Library/Preferences/
}

installzsh() { \
  emsg "Zsh installing..."
  brew install zsh zsh-completions
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  sudo git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
  sudo ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/supercrabtree/k $HOME/.oh-my-zsh/plugins/k
  brew install zplug
  brew install fd
}

cleanup() { \
  emsg "Brew cleanup..."
  brew update
  brew upgrade
  brew cleanup
}

startterm() { \
  emsg "Zsh starting..."
  if ! fgrep -q "${BREW_PREFIX}/bin/zsh" /etc/shells; then
    echo "${BREW_PREFIX}/bin/zsh" | sudo tee -a /etc/shells;
    chsh -s "${BREW_PREFIX}/bin/zsh";
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

etitle "Installing Terminal"

[ -d /Applications/iTerm.app ] > /dev/null && alreadyinstallmessage "iTerm" || installiterm
cleanup
installzsh
startterm
