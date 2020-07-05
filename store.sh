#!/usr/bin/env bash

installpopclip { \
  mas lucky PopClip
  mkdir -p ~/Library/Application\ Support/PopClip/Extensions/
  wget https://raw.githubusercontent.com/skamelone/bootstrap/master/config/popclip/popclip.zip
  unzip popclip.zip
  mv popclip Popclip
  mv Popclip/* $HOME/Library/Application\ Support/PopClip/Extensions/
  rm -fr Popclip
  rm popclip.zip
}

function doIt() {
   installpopclip
   mas lucky DevCleaner
   mas lucky "Dark Mode"
   mas lucky Quiver
   mas lucky Amphetamine
   mas lucky Pikka
   mas lucky daisydisk
   mas lucky pixelmator
   mas lucky amphetamine
   mas lucky "Canary Mail"
   mas install 937984704
}

cd "$(dirname "${BASH_SOURCE}")";
if [ "$1" == "--force" -o "$1" == "-f" ]; then
    doIt;
else
    read -p "Please signin on the App Store. Press 'y' when it's done? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt;
    fi;
fi;
unset doIt;
