#!/bin/bash

#/**
# * traceroute
# * network analyser
# *
# * @category network
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes traceroute'
sudo apt-get install --assume-yes traceroute
