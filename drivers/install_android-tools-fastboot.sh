#!/bin/bash

#/**
# * android-tools-fastboot
# *
# * @category drivers
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes android-tools-fastboot'
sudo apt-get install --assume-yes android-tools-fastboot

