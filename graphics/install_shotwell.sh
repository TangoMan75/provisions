#!/bin/bash

#/**
# * shotwell
# * photo manager
# *
# * @category graphics
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes shotwell'
sudo apt-get install --assume-yes shotwell
