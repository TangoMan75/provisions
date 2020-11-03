#!/bin/bash

#/**
# * python3-pip
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes python3-pip'
sudo apt-get install --assume-yes python3-pip
