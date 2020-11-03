#!/bin/bash

#/**
# * gparted
# * partition manager
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes gparted'
sudo apt-get install --assume-yes gparted
