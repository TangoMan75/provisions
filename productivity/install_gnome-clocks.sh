#!/bin/bash

#/**
# * gnome-clocks
# *
# * @category productivity
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes gnome-clocks'
sudo apt-get install --assume-yes gnome-clocks
