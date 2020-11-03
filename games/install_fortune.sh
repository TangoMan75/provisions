#!/bin/bash

#/**
# * fortune
# * fortune cookie command line fun
# *
# * @category games
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

# install fortune
echo_info 'sudo apt-get install --assume-yes fortune'
sudo apt-get install --assume-yes fortune
