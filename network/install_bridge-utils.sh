#!/bin/bash

#/**
# * bridge-utils
# *
# * @category network
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes bridge-utils'
sudo apt-get install --assume-yes bridge-utils
