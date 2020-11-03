#!/bin/bash

#/**
# * install make
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes make'
sudo apt-get install --assume-yes make
