#!/bin/bash

#/**
# * renameutils
# * batch renamer
# *
# * @category utils
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes renameutils'
sudo apt-get install --assume-yes renameutils
