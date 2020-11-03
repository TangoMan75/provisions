#!/bin/bash

#/**
# * update repositories
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

# update repositories
echo_info 'sudo apt-get update'
sudo apt-get update
