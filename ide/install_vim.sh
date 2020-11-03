#!/bin/bash

#/**
# * vim
# * terminal text editor
# *
# * @category ide
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes vim'
sudo apt-get install --assume-yes vim

# set vim as git default editor if installed
if [ -x /usr/bin/git ] ; then
    git config --global core.editor 'vim'
fi
