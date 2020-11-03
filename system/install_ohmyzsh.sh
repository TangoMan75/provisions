#!/bin/bash

#/**
# * ohmyzsh
# * alternative shell
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

## install zsh-common
#echo_info 'sudo apt-get install --assume-yes zsh-common'
#sudo apt-get -f install -y zsh-common

# install zsh
echo_info 'sudo apt-get -f install -y zsh'
sudo apt-get -f install -y zsh

# install powerline fonts
echo_info 'sudo apt-get install --assume-yes fonts-powerline'
sudo apt-get install --assume-yes fonts-powerline

{
    if [ ! -x "$(command -v curl)" ]; then
        # install ohmyzsh (via wget)
        echo_info "bash -c \"`wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -`\""
        bash -c "`wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -`"
    else
        # install ohmyzsh (via curl)
        echo_info "bash -c \"`curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh`\""
        bash -c "`curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh`"
    fi
} || {
    echo_error 'download failed'
    exit 1
}

# make zsh default shell
echo_info 'chsh -s $(which zsh)'
chsh -s $(which zsh)

# import .bash_aliases
cat >> ~/.zshrc <<EOL

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
EOL
