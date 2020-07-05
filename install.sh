#!/bin/bash

#########################################################################
################################ MAIN ###################################
#########################################################################

# Install Bootstrap
bash <(curl -s https://raw.githubusercontent.com/skamelone/bootstrap/master/boot.sh)

# Install Brew Applications
bash <(curl -s https://raw.githubusercontent.com/skamelone/bootstrap/master/app.sh)

# Install Appstore Applications
bash <(curl -s https://raw.githubusercontent.com/skamelone/bootstrap/master/store.sh)

# Install Development Applications
bash <(curl -s https://raw.githubusercontent.com/skamelone/bootstrap/master/dev.sh)

# Configure Operating System
bash <(curl -s https://raw.githubusercontent.com/skamelone/bootstrap/master/osx.sh)

# Install Terminal
bash <(curl -s https://raw.githubusercontent.com/skamelone/bootstrap/master/terminal.sh)
