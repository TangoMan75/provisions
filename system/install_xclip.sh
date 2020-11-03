#!/bin/bash

#/**
# * xclip
# * pipe terminal stdout to clipboard
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes xclip'
sudo apt-get install --assume-yes xclip
