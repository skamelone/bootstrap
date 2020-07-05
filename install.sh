#!/bin/bash

set -o nounset # error when referencing undefined varinstallextrapackagenvimiable
set -o errexit # exit when error fails

# Various log colors
RESET=$(tput sgr0)
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
BOLD=$(tput bold)

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

installhomebrew() { \
  emsg "Installing Homebrew"
  /bin/bash -c "$(curl -fssl https://raw.githubusercontent.com/homebrew/install/master/install.sh)"
}

installgit() { \
  emsg "Installing Git..."
  brew install git
  brew install git-lfs
  # Install the latest version of git-flow
  curl -L -O https://raw.github.com/nvie/gitflow/develop/contrib/gitflow-installer.sh
  sudo bash gitflow-installer.sh
  brew install git-extras
  brew install hub
  emsg "Configuring git..."
  hub config --global user.name Jean Barbieri
  hub config --global user.email jbarbieri@activecampaign.com
}

installpython() { \
  emsg "Installing Python3..."
  brew install python3
}

installpynvim() { \
  emsg "Installing Pynvim..."
  pip3 install pynvim --user
}

installnvim() { \
  emsg "Installing Nvim..."
  brew install neovim
}

installextrapackagenvim() { \
  emsg "Installing nvim extra packages..."
  brew install ripgrep fzf ranger
  $(brew --prefix)/opt/fzf/install --all
}

moveoldnvim() { \
  emsg "Backing up your config to nvim.old"
  mv $HOME/.config/nvim $HOME/.config/nvim.old
}

clonenvimconfig() { \
  [ -d "$HOME/.config/nvim" ] && moveoldnvim 
  emsg "Cloning Neovim configuration..."
  git clone https://github.com/skamelone/nvim-config.git ~/.config/nvim
}

installnode() { \
  emsg "Installing Node..."
  brew install node
   # Install extensions
  mkdir -p ~/.config/coc/extensions
  cd ~/.config/coc/extensions
  [ ! -f package.json ] && echo '{"dependencies":{}}'> package.json
  npm install coc-explorer coc-snippets coc-json coc-actions --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
  npm install --global fkill-cli
}

installcoreutils() { \
  emsg "Installing CoreUtils..."
  brew install coreutils
}

installterminalutils() { \
  emsg "Installing Terminal Utils..."
  brew install findutils
  brew install gnu-sed
  brew install the_silver_searcher
  brew install ag
  brew install tig
  brew install tree
  brew install autojump
  brew install lolcat
  brew install openssh
  brew install rename
}

installnetworkutils() { \
  emsg "Installing Network Utils..."
  brew install ack
  brew install dark-mode
  brew install ssh-copy-id
  brew install httpie
  brew install nmap
  brew install dns2tcp
  brew install john
  brew install tcptrace
  brew install pwgen
  brew install xz
  brew install wget
}

installsystemutils() { \
  emsg "Installing System Utils..."
  brew install binutils
  brew install dex2jar
  brew install cmake
  brew install pkg-config
  brew install libffi
  brew install htop
  brew install mas
  brew install libxml2 --force
  brew install libxslt --force
  pip3 install glances
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
################################ MAIN ###################################
#########################################################################

etitle "Installing Bootstrap"

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

# Install git
[ -d /usr/local/Cellar/git-extras ] && alreadyinstallmessage "Git" || installgit

# # Clone nvim config
[ -f $HOME/.config/nvim/latest ] && alreadyinstallmessage "Latest Neovim config" || clonenvimconfig

# # install node and neovim support
which node > /dev/null && alreadyinstallmessage "Node" || installnode

#########################################################################
############################### SYSTEM ##################################
#########################################################################

[ -d /usr/local/Cellar/coreutils ] && alreadyinstallmessage "CoreUtils" || installcoreutils
[ -d /usr/local/Cellar/tig ] && alreadyinstallmessage "TerminalUtils" || installterminalutils
[ -d /usr/local/Cellar/ack ] && alreadyinstallmessage "NetworkUtils" || installnetworkutils
[ -d /usr/local/Cellar/cmake ] && alreadyinstallmessage "SystemUtils" || installsystemutils

