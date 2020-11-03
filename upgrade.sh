#!/bin/bash

#/**
# * upgrade & dist-upgrade
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

# upgrade packages
echo_info 'sudo apt-get upgrade -y'
sudo apt-get upgrade -y

# upgrade operating system
echo_info 'sudo apt-get dist-upgrade -y'
sudo apt-get dist-upgrade -y
