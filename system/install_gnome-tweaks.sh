#!/bin/bash

#/**
# * gnome-tweaks
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes gnome-tweaks'
sudo apt-get install --assume-yes gnome-tweaks
