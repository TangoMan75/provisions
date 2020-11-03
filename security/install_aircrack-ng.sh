#!/bin/bash

#/**
# * aircrack-ng
# *
# * @category security
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes aircrack-ng'
sudo apt-get install --assume-yes aircrack-ng
