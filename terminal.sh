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

installrangerconf() { \
  emsg "Ranger configuration installing..."
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/ranger/ranger.zip
  unzip ranger.zip
  rm -fr $HOME/.config/ranger/
  mv ranger/ $HOME/.config/
  rm ranger.zip
}

installzsh() { \
  emsg "Zsh installing..."
  brew install zsh zsh-completions
  brew install zplug
  brew install fd
  brew install lazygit
  chmod -R 755 /usr/local/share/zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

installalacritty() { \
  emsg "Alacritty installing..."
  brew cask install alacritty
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/alacritty/alacritty.zip
  unzip alacritty.zip
  mv alacritty $HOME/.config
  rm alacritty.zip
}

installzshconf() { \
  emsg "iTerm2 configuration installing..."
  sudo git clone https://github.com/denysdovhan/spaceship-prompt.git "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt"
  sudo ln -s "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
  cd
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/iterm/zsh.zip
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/iterm/zshrc
  mv zshrc .zshrc
  unzip zsh.zip
  cp -R zsh $HOME/.config/
  rm -fr zsh
  rm zsh.zip
  git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  git clone https://github.com/supercrabtree/k $HOME/.oh-my-zsh/custom/plugins/k
}

cleanup() { \
  emsg "Brew cleanup..."
  brew update
  brew upgrade
  brew cleanup
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
installrangerconf
cleanup
installzsh
installzshconf
installalacritty
