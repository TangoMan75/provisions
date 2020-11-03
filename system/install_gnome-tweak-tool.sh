#!/bin/bash

#/**
# * gnome-tweak-tool
# * tweaks for gnome desktop
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes gnome-tweak-tool'
sudo apt-get install --assume-yes gnome-tweak-tool
