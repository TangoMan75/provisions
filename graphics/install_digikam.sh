#!/bin/bash

#/**
# * digikam
# * photo manager
# *
# * @category graphics
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes digikam'
sudo apt-get install --assume-yes digikam
