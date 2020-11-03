#!/bin/bash

#/**
# * remove avahi-daemon
# * Network configuration tool
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get purge --assume-yes avahi-daemon'
sudo apt-get purge --assume-yes avahi-daemon

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

