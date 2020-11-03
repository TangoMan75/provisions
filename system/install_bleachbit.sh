#!/bin/bash

#/**
# * bleachbit
# * system cache cleaner
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes bleachbit'
sudo apt-get install --assume-yes bleachbit
