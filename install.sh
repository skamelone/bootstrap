#!/bin/bash

set -o nounset # error when referencing undefined varinstallextrapackagenvimiable
set -o errexit # exit when error fails

installhomebrew() { \
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fssl https://raw.githubusercontent.com/homebrew/install/master/install.sh)"
}

installgit() { \
  echo "Installing git..."
  brew install git
}

installpython() { \
  echo "Installing python3..."
  brew install python3
}

installpynvim() { \
  echo "Installing pynvim..."
  pip3 install pynvim
}

installnvim() { \
  echo "Installing nvim"
  brew install neovim
}

installextrapackagenvim() { \
  echo "Installing nvim extra package"
  brew install ripgrep fzf ranger
}

alreadyinstallmessage() { \
   printf "$1 already installed\t✅\n" | expand -t 60
}

moveoldnvim() { \
  echo "Backing up your config to nvim.old"
  mv $HOME/.config/nvim $HOME/.config/nvim.old
}

cloneconfig() { \
  [ -d "$HOME/.config/nvim" ] && moveoldnvim 
  echo "Cloning Neovim configuration"
  git clone https://github.com/skamelone/nvim-config.git ~/.config/nvim
}

installnode() { \
  echo "Installing Node"
  brew install node
   # Install extensions
  mkdir -p ~/.config/coc/extensions
  cd ~/.config/coc/extensions
  [ ! -f package.json ] && echo '{"dependencies":{}}'> package.json
  sudo npm install coc-explorer coc-snippets coc-json coc-actions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
}

printf '\nInstalling Bootstrap\n'
printf '**********************\n\n'

# Install git
which git > /dev/null && alreadyinstallmessage "Git" || installgit

# Install Homebrew
which brew > /dev/null && alreadyinstallmessage "Homebrew" || installhomebrew

# Install Python
which pip3 > /dev/null && alreadyinstallmessage "Pip" || installpython

# Install pynvim
pip3 list | grep pynvim > /dev/null && alreadyinstallmessage "pynvim" || installpynvim

# Install Neovim
which nvim > /dev/null && alreadyinstallmessage "nvim" || installnvim

# Install Nvim extrapackage
which fzf > /dev/null && alreadyinstallmessage "nvim extras" || installextrapackagenvim

# Clone nvim config
cloneconfig

# install node and neovim support
which node > /dev/null && alreadyinstallmessage "Node" || installnode
