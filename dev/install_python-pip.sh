#!/bin/bash

#/**
# * python-pip
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes python-pip'
sudo apt-get install --assume-yes python-pip
