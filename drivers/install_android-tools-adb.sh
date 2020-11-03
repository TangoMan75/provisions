#!/bin/bash

#/**
# * android-tools-adb
# *
# * @category drivers
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes android-tools-adb'
sudo apt-get install --assume-yes android-tools-adb

