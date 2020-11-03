#!/bin/bash

#/**
# * hardinfo
# * hardware info and benchmark
# *
# * @category system
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes hardinfo'
sudo apt-get install --assume-yes hardinfo
