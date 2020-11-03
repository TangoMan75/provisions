#!/bin/bash

#/**
# * mednafen
# * multiple console game emulator
# *
# * @category games
# */

BASEDIR=$(dirname "${0}")
. ${BASEDIR}/../tools/colors.sh

echo_info 'sudo apt-get install --assume-yes mednafen'
sudo apt-get install --assume-yes mednafen
