#!/bin/bash

#/**
# * gnome-panel
# * desktop shortcut launcher
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes gnome-panel'
sudo apt-get install --assume-yes gnome-panel
