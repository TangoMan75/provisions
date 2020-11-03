#!/bin/bash

#/**
# * git
# * distributed version control tool
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes git'
sudo apt-get install --assume-yes git

# default git config
echo_info 'git config --global push.default simple'
git config --global push.default simple

# set vim as git default editor if installed
if [ -x /usr/bin/vim ] ; then
    git config --global core.editor 'vim'
fi
