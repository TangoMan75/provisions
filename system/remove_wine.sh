#!/bin/bash

#/**
# * remove wine
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get purge --assume-yes wine'
sudo apt-get purge --assume-yes wine

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

