#!/bin/bash

#/**
# * config global gitignore
# *
# * @category ide
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

if [ `is_installed 'git'` == 'false' ]; then
    echo_error "\"`basename ${0}`\" requires git, try: 'sudo apt-get install -y git'"
    exit 1
fi

# create gitignore file
echo_info 'echo "/.idea/" > ~/.gitignore_global'
echo "/.idea/" > ~/.gitignore_global

# config global gitignore
echo_info 'git config --global core.excludesfile ~/.gitignore_global'
git config --global core.excludesfile ~/.gitignore_global

