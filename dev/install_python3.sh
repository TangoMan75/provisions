#!/bin/bash

#/**
# * python3
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes python3'
sudo apt-get install --assume-yes python3
