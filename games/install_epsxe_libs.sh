#!/bin/bash

#/**
# * epsxe-libs
# * required libraries for epsxe playstation emulator
# *
# * @category games
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes libsdl1.2debian'
sudo apt-get install --assume-yes libsdl1.2debian

echo_info 'sudo apt-get install --assume-yes libsdl-ttf2.0-0'
sudo apt-get install --assume-yes libsdl-ttf2.0-0

echo_info 'sudo apt-get install --assume-yes libcurl3'
sudo apt-get install --assume-yes libcurl3

echo_info 'sudo apt-get install --assume-yes libncurses5'
sudo apt-get install --assume-yes libncurses5

echo_info 'sudo apt-get install --assume-yes libgtk-3-0'
sudo apt-get install --assume-yes libgtk-3-0
