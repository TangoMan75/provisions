#!/bin/bash

#/**
# * cmatrix
# * matrix command line fun
# *
# * @category games
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes cmatrix'
sudo apt-get install --assume-yes cmatrix
