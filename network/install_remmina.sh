#!/bin/bash

#/**
# * remmina
# * remote desktop client
# *
# * @category network
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes remmina'
sudo apt-get install --assume-yes remmina
