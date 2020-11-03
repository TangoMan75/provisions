#!/bin/bash

#/**
# * p7zip-full
# * file compression
# *
# * @category utils
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes p7zip-full'
sudo apt-get install --assume-yes p7zip-full
