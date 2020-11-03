#!/bin/bash

#/**
# * htop
# * command line system monitor
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes htop'
sudo apt-get install --assume-yes htop
