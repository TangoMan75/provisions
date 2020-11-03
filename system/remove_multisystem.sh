#!/bin/bash

#/**
# * multisystem
# * create bootable usb drives
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get purge --assume-yes multisystem'
sudo apt-get purge --assume-yes multisystem

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

