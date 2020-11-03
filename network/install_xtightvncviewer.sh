#!/bin/bash

#/**
# * xtightvncviewer
# * remote desktop client
# *
# * @category network
# * @note     xtightvncviewer -fullscreen 192.168.0.3:1
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes xtightvncviewer'
sudo apt-get install --assume-yes xtightvncviewer
