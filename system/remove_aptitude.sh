#!/bin/bash

#/**
# * remove aptitude
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get purge --assume-yes aptitude'
sudo apt-get purge --assume-yes aptitude

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

