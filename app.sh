#!/bin/bash

set -o nounset # error when referencing undefined varinstallextrapackagenvimiable
set -o errexit # exit when error fails

# Various log colors
RESET=$(tput sgr0)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
BOLD=$(tput bold)


installbartender() { \
  emsg "Batender installing..."
  brew cask install --appdir="/Applications" bartender 
}

installalfred() { \
  emsg "Alfred installing..."
  brew cask install --appdir="/Applications" alfred
}

installsublimetext() { \
  emsg "Sublime Text installing..."
  brew cask install --appdir="/Applications" sublime-text
  mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/sublimetext/Preferences.sublime-settings
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/sublimetext/ayu.zip
  mv ./Preferences.sublime-settings $HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/
  unzip ayu.zip
  mv ayu $HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/
  rm ayu.zip
}

installvim() { \
  emsg "Vim installing..."
  brew install vim
  mkdir -p $HOME/.vim
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/vim/vimrc
  mv vimrc $HOME/.vimrc
  curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
  set rtp+=/usr/local/opt/fzf
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
  printf "\n**** Start Vim and run :PlugInstall + :PlugClean\n"
}

installfonts() { \
  emsg "Fonts installing..."
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/fonts/fonts.zip
  unzip fonts.zip
  mv fonts/*.ttf $HOME/Library/Fonts/
  rm -fr fonts
  rm fonts.zip
}

installzzz() { \
  emsg "zzz installing..."
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/apps/zzz.zip
  unzip zzz.zip
  mv Zzz.app /Applications/
  rm zzz.zip
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
################################ APPS ###################################
#########################################################################

etitle "Installing Apps"

# Install Alfred
[ -d /Applications/Alfred*.app ] && alreadyinstallmessage "Alfred" || installalfred

# Install Sublime Text
[ -d /Applications/Sublime\ Text*.app ] && alreadyinstallmessage "Sublime Text" || installsublimetext

# Install Sublime Merge
[ -d /Applications/Sublime\ Merge*.app ] && alreadyinstallmessage "Sublime Merge" || brew cask install --appdir="/Applications" sublime-merge

# Install Sublime Firefox
[ -d /Applications/Firefox.app ] && alreadyinstallmessage "Firefox" || brew cask install --appdir="/Applications" firefox

# Install Sublime Evernote
[ -d /Applications/Evernote.app ] && alreadyinstallmessage "Evernote" || brew cask install --appdir="/Applications" evernote

# Install Spotify
[ -d /Applications/Spotify.app ] && alreadyinstallmessage "Spotify" || brew cask install --appdir="/Applications" spotify

# Install Hammerspoon
[ -d /Applications/Hammerspoon.app ] && alreadyinstallmessage "Hammerspoon" || brew cask install --appdir="/Applications" hammerspoon

# Install Dropbox
[ -d /Applications/Dropbox.app ] && alreadyinstallmessage "Dropbox" || brew cask install --appdir="/Applications" dropbox

# Install Bartender
[ -d /Applications/Bartender*.app ] && alreadyinstallmessage "Bartender" || installbartender

# Install Dash
[ -d /Applications/Dash.app ] && alreadyinstallmessage "Dash" || brew cask install --appdir="/Applications" dash

# Install Charles
[ -d /Applications/Charles.app ] && alreadyinstallmessage "Charles" || brew cask install --appdir="/Applications" charles

# Install 1Password
[ -d /Applications/1Password*.app ] && alreadyinstallmessage "1Password" || brew cask install --appdir="/Applications" 1password-cli

# Install Fantastical
[ -d /Applications/Fantastical*.app ] && alreadyinstallmessage "Fantastical" || brew cask install --appdir="/Applications" fantastical

# Install Fantastical
[ -d /Applications/Kaleidoscope.app ] && alreadyinstallmessage "Kaleidoscope" || brew cask install --appdir="/Applications" kaleidoscope

# Install vim
[ -f $HOME/.vim/autoload/plug.vim  ] && alreadyinstallmessage "Vim" || installvim

# Install BeardedSpice
[ -d /Applications/BeardedSpice.app ] && alreadyinstallmessage "BeardedSpice" || brew cask install --appdir="/Applications" beardedspice

# Install PostMan
[ -d /Applications/Postman.app ] && alreadyinstallmessage "Postman" || brew cask install --appdir="/Applications" postman

# Install Keka
[ -d /Applications/Keka.app ] && alreadyinstallmessage "Keka" || brew cask install --appdir="/Applications" keka

# Install Hocus Focus
[ -d /Applications/Hocus*.app ] && alreadyinstallmessage "Hocus Focus" || brew cask install --appdir="/Applications" hocus-focus

# Install Pcloud
[ -d /Applications/pCloud*.app ] && alreadyinstallmessage "pCloud" || brew cask install pcloud-drive.rb

# Install Fonts
[ -f $HOME/Library/Fonts/FiraCode-Bold.ttf  ] && alreadyinstallmessage "Fonts" || installfonts

# Install zzz
[ -d /Applications/Zzz.app ] && alreadyinstallmessage "zzz" || installzzz

# Install Karabiner
[ -d /Applications/Karabiner-Elements.app ] && alreadyinstallmessage "Karabiner-Elements" || brew cask install --appdir="/Applications" karabiner-elements

