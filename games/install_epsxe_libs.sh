#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## epsxe-libs
## required libraries for epsxe playstation emulator
##
## @category games

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

#--------------------------------------------------

echo_info 'sudo apt-get install --assume-yes libsdl1.2debian\n'
sudo apt-get install --assume-yes libsdl1.2debian

echo_info 'sudo apt-get install --assume-yes libsdl-ttf2.0-0\n'
sudo apt-get install --assume-yes libsdl-ttf2.0-0

echo_info 'sudo apt-get install --assume-yes libcurl3\n'
sudo apt-get install --assume-yes libcurl3

echo_info 'sudo apt-get install --assume-yes libncurses5\n'
sudo apt-get install --assume-yes libncurses5

echo_info 'sudo apt-get install --assume-yes libgtk-3-0\n'
sudo apt-get install --assume-yes libgtk-3-0
