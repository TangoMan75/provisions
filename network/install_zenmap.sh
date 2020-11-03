#!/bin/bash

#/**
# * zenmap
# * nmap network scanner graphic interface
# *
# * @category network
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes zenmap'
sudo apt-get install --assume-yes zenmap
