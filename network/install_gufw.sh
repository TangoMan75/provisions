#!/bin/bash

#/**
# * gufw
# * graphical interface for ufw (uncomplicated firewal)
# *
# * @category network
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes gufw'
sudo apt-get install --assume-yes gufw
