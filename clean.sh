#!/bin/bash

#/**
# * clean apt
# *
# * @license MIT
# * @author  "Matthias Morin" <mat@tangoman.io>
# */

## Initialise git submodules
if [ -f ./.gitmodules ] && [ ! -f ./tools/.git ]; then
    git submodule update --init --recursive
fi

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/tools/colors.sh

echo_info 'sudo apt -y autoremove --purge'
sudo apt -y autoremove --purge

# remove /var/cache/apt/archives
echo_info 'sudo apt-get clean'
sudo apt-get clean
