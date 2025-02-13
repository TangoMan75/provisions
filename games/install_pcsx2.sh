#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## pcsx2
## playstation 2 emulator
##
## @category games

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install PCSX2'

# echo_info 'sudo apt-get install --assume-yes libcg:i386\n'
# sudo apt-get install --assume-yes libcg:i386

# echo_info 'sudo apt-get install --assume-yes libwxgtk2:i386\n'
# sudo apt-get install --assume-yes libwxgtk2:i386

echo_info 'sudo add-apt-repository --yes ppa:gregory-hainaut/pcsx2.official.ppa\n'
sudo add-apt-repository --yes ppa:gregory-hainaut/pcsx2.official.ppa

echo_info 'sudo apt-get update\n'
sudo apt-get update

# install pcsx2
echo_info 'sudo apt-get install --assume-yes pcsx2:i386\n'
sudo apt-get install --assume-yes pcsx2:i386

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/PCSX2.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/PCSX2.desktop "$(xdg-user-dir DESKTOP)"
