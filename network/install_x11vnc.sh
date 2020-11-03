#!/bin/bash

#/**
# * x11vnc
# * remote desktop server
# *
# * @category network
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes x11vnc'
sudo apt-get install --assume-yes x11vnc
