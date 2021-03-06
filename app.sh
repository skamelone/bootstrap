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
}

installhammerspoon() { \
  emsg "Hammerspoon installing..."
  brew cask install --appdir="/Applications" hammerspoon
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/hammerspoon/hammerspoon.zip
  unzip hammerspoon.zip
  mv hammerspoon .hammerspoon
  rm hammerspoon.zip
}

installkarabiner() { \
  emsg "Karabiner installing..."
  brew cask install --appdir="/Applications" karabiner-elements
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/karabiner/karabiner.zip
  unzip karabiner.zip
  mv karabiner $HOME/.config/
  rm karabiner.zip
}

installfonts() { \
  emsg "Fonts installing..."
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/fonts/fonts.zip
  unzip fonts.zip
  mv fonts/*.ttf $HOME/Library/Fonts/
  rm -fr fonts
  rm fonts.zip
}

installpcloud() { \
  emsg "pCloud installing..."
  wget https://gist.githubusercontent.com/tomgross/bae4f30023272d8c8c0d920b62720c6b/raw/c2a3c2a40cb7ad6d6853a4f4dba78b1461e60ca5/pcloud-drive.rb
  brew cask install pcloud-drive.rb
  rm pcloud-drive.rb
}

installzzz() { \
  emsg "zzz installing..."
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/apps/zzz.zip
  unzip zzz.zip
  mv Zzz.app /Applications/
  rm zzz.zip
}

install1password() { \
  emsg "1Password installing..."
  brew cask install --appdir="/Applications" 1Password
  brew cask install --appdir="/Applications" 1password-cli
}

installyabai() { \
  emsg "Installing Yabai..."
  brew install koekeishiya/formulae/yabai
  sudo yabai --install-sa
  yabai --load-sa
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/yabai/yabairc
  mv yabairc .yabairc
  mv .yabairc ~/
  brew services start yabai
}

installspacebar() { \
  emsg "Installing Spacebar..."
  brew install cmacrae/formulae/spacebar
  wget https://github.com/skamelone/bootstrap/blob/master/config/spacebar/fontawesome-free-5.15.1-desktop.zip?raw=true
  unzip fontawesome-free-5.15.1-desktop.zip
  cd fontawesome-free-5.15.1-desktop/otfs/
  mv *.otf ~/Library/Fonts/
  cd ../.. ; rm -fr fontawesome-free-5.15.1-desktop
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/spacebar/spacebarrc
  mkdir -p ~/.config/spacebar
  mv spacebarrc ~/.config/spacebar
}

installlimelight() { \
  emsg "Installing Limelight..."
  git clone https://github.com/koekeishiya/limelight.git
  cd limelight
  make
  mv bin/limelight /usr/local/bin
  cd ..
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/limelight/config
  mkdir -p ~/.config/limelight
  mv config ~/.config/limelight
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/limelight/com.skamelone.limelight.plist
  mv com.skamelone.limelight.plist ~/Library/LaunchAgents/
  launchctl load ~/Library/LaunchAgents/com.skamelone.limelight.plist
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
[ -d /Applications/Hammerspoon.app ] && alreadyinstallmessage "Hammerspoon" || installhammerspoon 

# Install Dropbox
[ -d /Applications/Dropbox.app ] && alreadyinstallmessage "Dropbox" || brew cask install --appdir="/Applications" dropbox

# Install Bartender
[ -d /Applications/Bartender*.app ] && alreadyinstallmessage "Bartender" || installbartender

# Install Dash
[ -d /Applications/Dash.app ] && alreadyinstallmessage "Dash" || brew cask install --appdir="/Applications" dash

# Install Charles
# [ -d /Applications/Charles.app ] && alreadyinstallmessage "Charles" || brew cask install --appdir="/Applications" charles

# Install Fantastical
[ -d /Applications/Fantastical*.app ] && alreadyinstallmessage "Fantastical" || brew cask install --appdir="/Applications" fantastical

# Install Kaleidoscope
# [ -d /Applications/Kaleidoscope.app ] && alreadyinstallmessage "Kaleidoscope" || brew cask install --appdir="/Applications" kaleidoscope

# Install vim
[ -f $HOME/.vim/autoload/plug.vim  ] && alreadyinstallmessage "Vim" || installvim

# Install BeardedSpice
# [ -d /Applications/BeardedSpice.app ] && alreadyinstallmessage "BeardedSpice" || brew cask install --appdir="/Applications" beardedspice

# Install PostMan
# [ -d /Applications/Postman.app ] && alreadyinstallmessage "Postman" || brew cask install --appdir="/Applications" postman

# Install Keka
[ -d /Applications/Keka.app ] && alreadyinstallmessage "Keka" || brew cask install --appdir="/Applications" keka

# Install Hocus Focus
# [ -d /Applications/Hocus*.app ] && alreadyinstallmessage "Hocus Focus" || brew cask install --appdir="/Applications" hocus-focus

# Install Fonts
[ -f $HOME/Library/Fonts/FiraCode-Bold.ttf  ] && alreadyinstallmessage "Fonts" || installfonts

# Install zzz
[ -d /Applications/Zzz.app ] && alreadyinstallmessage "zzz" || installzzz

# Install Karabiner
[ -d /Applications/Karabiner-Elements.app ] && alreadyinstallmessage "Karabiner-Elements" || installkarabiner 

# Install Pcloud
#[ -d /Applications/pCloud*.app ] && alreadyinstallmessage "pCloud" || installpcloud

# Install 1Password
[ -d /Applications/1Password*.app ] && alreadyinstallmessage "1Password" || install1password

# Install yabai
[ -f $HOME/.yabairc  ] && alreadyinstallmessage "Yabai" || installyabai

# Install spacebar
[ -f $HOME/.config/spacebar/spacebarrc  ] && alreadyinstallmessage "Spacebar" || installspacebar

# Install spacebar
[ -f $HOME/.config/limelight/config  ] && alreadyinstallmessage "Limelight" || installlimelight

