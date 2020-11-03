#!/bin/bash

#/**
# * wine
# * windows emulator
# *
# * @category system
# * @note     not recommended: install wine-hq instead
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes wine'
sudo apt-get install --assume-yes wine

