#!/bin/bash

#/**
# * net-tools
# * Network tools, includes netstat
# *
# * @category network
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes net-tools'
sudo apt-get install --assume-yes net-tools
