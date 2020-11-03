#!/bin/bash

#/**
# * xterm
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get purge --assume-yes xterm'
sudo apt-get purge --assume-yes xterm

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

