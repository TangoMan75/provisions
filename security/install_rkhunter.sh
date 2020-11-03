#!/bin/bash

#/**
# * rkhunter
# *
# * Rootkit scanner
# *
# * @category security
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes rkhunter'
sudo apt-get install --assume-yes rkhunter

