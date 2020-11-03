#!/bin/bash

#/**
# * gnome-sound-recorder
# *
# * @category drivers
# * @ note    `gstreamer-properties`
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes gnome-sound-recorder'
sudo apt-get install --assume-yes gnome-sound-recorder
