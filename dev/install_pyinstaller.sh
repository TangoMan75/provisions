#!/bin/bash

#/**
# * pyinstaller
# * compile python code to executable binary
# *
# * @category dev
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes pyinstaller'
sudo apt-get install --assume-yes pyinstaller
