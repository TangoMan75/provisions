#!/bin/bash

## This file is part of TangoMan Provisions package.
##
## Copyright (c) 2025 "Matthias Morin" <mat@tangoman.io>
##
## This source file is subject to the MIT license that is bundled
## with this source code in the file LICENSE.

## inkscape
## vector graphics
##
## @category graphics

CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
# shellcheck source=/dev/null
. "${CURDIR}/../tools/src/colors/colors.sh"

alert_primary 'Install Inkscape'

echo_info 'sudo add-apt-repository --yes ppa:inkscape.dev/stable1\n'
sudo add-apt-repository --yes ppa:inkscape.dev/stable1

echo_info 'sudo apt-get update\n'
sudo apt-get update

echo_info 'sudo apt-get install --assume-yes inkscape\n'
sudo apt-get install --assume-yes inkscape

# create shortcut on desktop
echo_info "cp -p /usr/share/applications/inkscape.desktop \"$(xdg-user-dir DESKTOP)\"\n"
cp -p /usr/share/applications/inkscape.desktop "$(xdg-user-dir DESKTOP)"
