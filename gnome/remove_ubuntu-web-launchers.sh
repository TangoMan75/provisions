#!/bin/bash

#/**
# * remove ubuntu-web-launchers
# * Remove Amazon bloat
# *
# * @category gnome
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get purge --assume-yes ubuntu-web-launchers'
sudo apt-get purge --assume-yes ubuntu-web-launchers

echo_info 'sudo apt-get --assume-yes autoremove'
sudo apt-get --assume-yes autoremove

