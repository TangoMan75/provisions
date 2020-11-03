#!/bin/bash

#/**
# * hydra
# *
# * @category security
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh
. ${BASEDIR}/../tools/tools.sh

echo_info 'sudo apt-get install --assume-yes hydra'
sudo apt-get install --assume-yes hydra

echo_info 'sudo apt-get install --assume-yes hydra-gtk'
sudo apt-get install --assume-yes hydra-gtk
