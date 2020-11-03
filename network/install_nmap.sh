#!/bin/bash

#/**
# * nmap
# * network scanner
# *
# * @category network
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes nmap'
sudo apt-get install --assume-yes nmap
