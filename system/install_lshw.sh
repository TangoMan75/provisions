#!/bin/bash

#/**
# * install lshw
# * hardware lister
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes lshw'
sudo apt-get install --assume-yes lshw
