#!/bin/bash

#/**
# * jpegoptim
# * cli image optimizer
# *
# * @category graphics
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes jpegoptim'
sudo apt-get install --assume-yes jpegoptim
